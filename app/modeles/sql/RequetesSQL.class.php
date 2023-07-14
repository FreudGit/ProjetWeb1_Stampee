<?php

/**
 * Classe des requêtes SQL
 *
 */
class RequetesSQL extends RequetesPDO
{

  /* GESTION DES UTILISATEURS 
     ======================== */

  /**
   * Récupération des utilisateurs
   * @return array tableau d'objets Utilisateur
   */
  public function getUtilisateurs()
  {
    $this->sql = "
    SELECT 
    utilisateur.utilisateur_id,
    utilisateur.utilisateur_nom,
    utilisateur.utilisateur_prenom,
    utilisateur.utilisateur_adresse,
    utilisateur.utilisateur_courriel,
    utilisateur.utilisateur_mdp,
    utilisateur.utilisateur_DateInscription,
    utilisateur.utilisateur_valide,
    utilisateur.utilisateur_renouveler_mdp,
    utilisateur.utilisateur_rating,
    utilisateur.utilisateur_roleID,
    role.Nom AS utilisateur_profil
  FROM utilisateur
  JOIN role ON utilisateur.utilisateur_roleID = role.ID
   ORDER BY utilisateur_id DESC";
    return $this->getLignes();
  }

  /**
   * Récupération d'un utilisateur
   * @param int $utilisateur_id, clé du utilisateur  
   * @return array|false tableau associatif de la ligne produite par la select, false si aucune ligne
   */
  public function getUtilisateur($utilisateur_id)
  {
    $this->sql = "
    SELECT
    utilisateur.utilisateur_id,
    utilisateur.utilisateur_nom,
    utilisateur.utilisateur_prenom,
    utilisateur.utilisateur_courriel,
    utilisateur.utilisateur_renouveler_mdp,
    role.Nom AS utilisateur_profil
  FROM utilisateur
  LEFT JOIN role ON utilisateur.utilisateur_roleID = role.ID
  WHERE utilisateur.utilisateur_id = :utilisateur_id;";
    return $this->getLignes(['utilisateur_id' => $utilisateur_id], RequetesPDO::UNE_SEULE_LIGNE);
  }

  /**
   * Contrôler si adresse courriel non déjà utilisée par un autre utilisateur que utilisateur_id
   * @param array $champs tableau utilisateur_courriel et utilisateur_id (0 si dans toute la table)
   * @return array|false utilisateur avec ce courriel, false si courriel disponible
   */
  public function controlerCourriel($champs)
  {
    $this->sql = 'SELECT utilisateur_id FROM utilisateur
                  WHERE utilisateur_courriel = :utilisateur_courriel AND utilisateur_id != :utilisateur_id';
    return $this->getLignes($champs, RequetesPDO::UNE_SEULE_LIGNE);
  }

  /**
   * Connecter un utilisateur
   * @param array $champs, tableau avec les champs utilisateur_courriel et utilisateur_mdp  
   * @return array|false tableau associatif de la ligne produite par la select, false si aucune ligne
   */
  public function connecter($champs)
  {
    $this->sql = "
    SELECT
    utilisateur.utilisateur_id,
    utilisateur.utilisateur_nom,
    utilisateur.utilisateur_prenom,
    utilisateur.utilisateur_courriel,
    utilisateur.utilisateur_renouveler_mdp,
    role.Nom AS utilisateur_profil
  FROM utilisateur
  LEFT JOIN role ON utilisateur.utilisateur_roleID = role.ID
      WHERE utilisateur_courriel = :utilisateur_courriel AND utilisateur_mdp = SHA2(:utilisateur_mdp, 512)";
    return $this->getLignes($champs, RequetesPDO::UNE_SEULE_LIGNE);
  }

  /**
   * Ajouter un utilisateur
   * @param array $champs tableau des champs de l'utilisateur 
   * @return int|string clé primaire de la ligne ajoutée, message d'erreur sinon
   */
  public function ajouterUtilisateur($champs)
  {
    $utilisateur = $this->controlerCourriel(
      ['utilisateur_courriel' => $champs['utilisateur_courriel'], 'utilisateur_id' => 0]
    );
    if ($utilisateur !== false)
      return Utilisateur::ERR_COURRIEL_EXISTANT;
    $this->sql = '
    INSERT INTO utilisateur (utilisateur_nom, utilisateur_prenom, utilisateur_courriel, utilisateur_mdp, utilisateur_renouveler_mdp, utilisateur_roleID)
    SELECT
      :utilisateur_nom,
      :utilisateur_prenom,
      :utilisateur_courriel,
      SHA2(:utilisateur_mdp, 512),
      "oui",
      role.ID
    FROM role
    WHERE role.Nom = :utilisateur_profil';
    return $this->CUDLigne($champs);
  }

  /**
   * Créer un compte utilisateur dans le frontend
   * @param array $champs tableau des champs de l'utilisateur 
   * @return int|string clé primaire de la ligne ajoutée, message d'erreur sinon
   */
  public function creerCompteClient($champs)
  {
    $utilisateur = $this->controlerCourriel(
      ['utilisateur_courriel' => $champs['utilisateur_courriel'], 'utilisateur_id' => 0]
    );
    if ($utilisateur !== false)
      return ['utilisateur_courriel' => Utilisateur::ERR_COURRIEL_EXISTANT];
    unset($champs['nouveau_mdp_bis']);
    //$champs['utilisateur_profil'] = Utilisateur::PROFIL_CLIENT ;
    $this->sql = '
      INSERT INTO utilisateur SET
      utilisateur_nom            = :utilisateur_nom,
      utilisateur_prenom         = :utilisateur_prenom,
      utilisateur_courriel       = :utilisateur_courriel,
      utilisateur_mdp            = SHA2(:nouveau_mdp, 512),
      utilisateur_renouveler_mdp = "non",
      utilisateur_profil         = "' . Utilisateur::PROFIL_CLIENT . '"';

    $this->sql = '
      INSERT INTO utilisateur (utilisateur_nom, utilisateur_prenom, utilisateur_courriel, utilisateur_mdp, utilisateur_renouveler_mdp, utilisateur_roleID)
      SELECT
        :utilisateur_nom,
        :utilisateur_prenom,
        :utilisateur_courriel,
        SHA2(:nouveau_mdp, 512),
        "oui",
        role.ID
      FROM role
      WHERE role.Nom = "' . Utilisateur::PROFIL_CLIENT . '"';
    return $this->CUDLigne($champs);
  }


  /**
   * Modifier un utilisateur
   * @param array $champs tableau des champs de l'utilisateur 
   * @return boolean|string true si modifié, message d'erreur sinon
   */
  public function modifierUtilisateur($champs)
  {
    $utilisateur = $this->controlerCourriel(
      ['utilisateur_courriel' => $champs['utilisateur_courriel'], 'utilisateur_id' => $champs['utilisateur_id']]
    );
    if ($utilisateur !== false)
      return Utilisateur::ERR_COURRIEL_EXISTANT;
    $this->sql = '
      UPDATE utilisateur SET
      utilisateur_nom      = :utilisateur_nom,
      utilisateur_prenom   = :utilisateur_prenom,
      utilisateur_courriel = :utilisateur_courriel,
      utilisateur.utilisateur_roleID = (
        SELECT role.ID
        FROM role
        WHERE role.Nom = :utilisateur_profil
      )
      WHERE utilisateur_id = :utilisateur_id
      AND utilisateur_id > 4'; // ne pas modifier les 4 premiers utilisateurs du jeu d'essai
    return $this->CUDLigne($champs);
  }

  /**
   * Modifier le mot de passe d'un utilisateur
   * @param array $champs tableau des champs de l'utilisateur 
   * @return boolean true si modifié, false sinon
   */
  public function modifierUtilisateurMdpGenere($champs)
  {
    $this->sql = '
      UPDATE utilisateur SET
      utilisateur_mdp            = SHA2(:utilisateur_mdp, 512),
      utilisateur_renouveler_mdp = "oui"
      WHERE utilisateur_id = :utilisateur_id
      AND utilisateur_id > 4'; // ne pas modifier les 4 premiers utilisateurs du jeu d'essai
    return $this->CUDLigne($champs);
  }

  /**
   * Modifier le mot de passe saisi d'un utilisateur
   * @param array $champs tableau des champs de l'utilisateur 
   * @return boolean true si modifié, false sinon
   */
  public function modifierUtilisateurMdpSaisi($champs)
  {
    $this->sql = '
      UPDATE utilisateur SET
      utilisateur_mdp            = SHA2(:utilisateur_mdp, 512), 
      utilisateur_renouveler_mdp = "non"
      WHERE utilisateur_id = :utilisateur_id
      AND utilisateur_id > 4'; // ne pas modifier les 4 premiers utilisateurs du jeu d'essai
    return $this->CUDLigne($champs);
  }

  /**
   * Supprimer un utilisateur
   * @param int $utilisateur_id clé primaire
   * @return boolean|string true si suppression effectuée, message d'erreur sinon
   */
  public function supprimerUtilisateur($utilisateur_id)
  {
    $this->sql = '
    DELETE FROM utilisateur
    WHERE utilisateur_id = :utilisateur_id
      AND NOT EXISTS (
        SELECT 1
        FROM enchere
        WHERE UtilisateurID = :utilisateur_id
        LIMIT 1
      ) AND utilisateur_id > 4';
    return $this->CUDLigne(['utilisateur_id' => $utilisateur_id]);
  }



  /* GESTION DES ENCHERES 
     ================= */

  /**
   * Récupération des encheres à l'affiche ou prochainement ou pour l'interface admin
   * @param  string $critere
   * @return array tableau des lignes produites par la select   
   */


   public function getEncheres($userID = null)
{
    $params = [];
    $this->sql = "SELECT
        e.ID,
        e.DateDebut,
        e.DateFin,
        e.PrixPlancher,
        e.Visible,
        e.Status,
        e.UtilisateurID,
        t.ID AS TimbreID,
        t.Nom AS TimbreNom,
        t.DateCreation AS TimbreDateCreation,
        t.Couleur AS TimbreCouleur,
        t.PaysOrigine AS TimbrePaysOrigine,
        t.EtatCondition AS TimbreEtatCondition,
        t.Tirage AS TimbreTirage,
        t.Longueur AS TimbreLongueur,
        t.Largeur AS TimbreLargeur,
        t.Certifie AS TimbreCertifie,
        t.CategorieID,
        COALESCE(mises.NombreMises, 0) AS NombreMises,
        COALESCE(mises.PrixActuel, e.PrixPlancher) AS PrixActuel,
        i.CheminImage AS PremiereImage,
        CASE WHEN f.ID IS NOT NULL THEN 1 ELSE 0 END AS bFavoris,
        CASE WHEN fLord.ID IS NOT NULL THEN 1 ELSE 0 END AS bFavorisLord
    FROM
        enchere e
        LEFT JOIN timbre t ON e.ID = t.EnchereID
        LEFT JOIN (
            SELECT
                EnchereID,
                COUNT(*) AS NombreMises,
                MAX(Prix) AS PrixActuel
            FROM
                offre
            GROUP BY
                EnchereID
        ) mises ON e.ID = mises.EnchereID
        LEFT JOIN favoris f ON e.ID = f.EnchereID AND f.UtilisateurID = :userID
        LEFT JOIN favoris fLord ON e.ID = fLord.EnchereID AND fLord.UtilisateurID = 2
        LEFT JOIN image i ON t.ID = i.TimbreID";
        $params = ['userID' => $userID];

    if ($userID != null) {
        $params = ['userID' => $userID];
        $this->sql .= " WHERE e.UtilisateurID = :userID";
    }

    return $this->getLignes($params);
}

   



  public function getEncheresOLD($userID = null)
  {

    $params = [];
    $this->sql = "SELECT
e.ID ,
e.DateDebut,
e.DateFin,
e.PrixPlancher,
e.Visible,
e.Status,
e.UtilisateurID,

t.ID AS TimbreID,
t.Nom AS TimbreNom,
t.DateCreation AS TimbreDateCreation,
t.Couleur AS TimbreCouleur,
t.PaysOrigine AS TimbrePaysOrigine,
t.EtatCondition AS TimbreEtatCondition,
t.Tirage AS TimbreTirage,
t.Longueur AS TimbreLongueur,
t.Largeur AS TimbreLargeur,
t.Certifie AS TimbreCertifie,
t.CategorieID,
COALESCE(mises.NombreMises, 0) AS NombreMises,
COALESCE(mises.PrixActuel, e.PrixPlancher) AS PrixActuel,
i.CheminImage AS PremiereImage
FROM
enchere e
LEFT JOIN timbre t ON e.ID = t.EnchereID
LEFT JOIN (
    SELECT
        EnchereID,
        COUNT(*) AS NombreMises,
        MAX(Prix) AS PrixActuel
    FROM
        offre
    GROUP BY
        EnchereID
) mises ON e.ID = mises.EnchereID
LEFT JOIN (
    SELECT
        TimbreID,
        CheminImage
    FROM
        image
    
) i ON t.ID = i.TimbreID";

    if ($userID != null) {
      $params = ['ID' => $userID];
      $this->sql .= "
WHERE e.UtilisateurID = :ID;";
    }

    return $this->getLignes($params);
  }



  /**
   * Récupération d'une enchere
   * @param  integer $if identifiant de l'enchere
   * @return array tableau des lignes produites par la select   
   */
  public function getEnchere($id)
  {


    $this->sql = "SELECT
e.ID ,
e.DateDebut,
e.DateFin,
e.PrixPlancher,
e.UtilisateurID,
e.Visible,
e.Status,
t.ID AS TimbreID,
t.Nom AS TimbreNom,
t.DateCreation AS TimbreDateCreation,
t.Couleur AS TimbreCouleur,
t.PaysOrigine AS TimbrePaysOrigine,
t.EtatCondition AS TimbreEtatCondition,
t.Tirage AS TimbreTirage,
t.Longueur AS TimbreLongueur,
t.Largeur AS TimbreLargeur,
t.Certifie AS TimbreCertifie,
t.CategorieID AS TimbreCategorieID,
COALESCE(mises.NombreMises, 0) AS NombreMises,
COALESCE(mises.PrixActuel, e.PrixPlancher) AS PrixActuel,
i.CheminImage AS PremiereImage
FROM
enchere e


LEFT JOIN timbre t ON e.ID = t.EnchereID
LEFT JOIN (
    SELECT
        EnchereID,
        COUNT(*) AS NombreMises,
        MAX(Prix) AS PrixActuel
    FROM
        offre
    GROUP BY
        EnchereID
) mises ON e.ID = mises.EnchereID
LEFT JOIN (
    SELECT
        TimbreID,
        CheminImage
    FROM
        image
    
) i ON t.ID = i.TimbreID
WHERE e.ID = :ID;";

    return $this->getLignes(['ID' => $id], RequetesPDO::UNE_SEULE_LIGNE);
  }



  /**
   * Ajout d'une enchere
   * @param  array $champs champs à ajouter
   * @return array|bool tableau des lignes produites par la select   
   */
  public function ajouterEnchere($champs)
  {
    $this->sql = '
      INSERT INTO enchere (DateDebut, DateFin, PrixPlancher, UtilisateurID, Visible)
      VALUES (:DateDebut, :DateFin, :PrixPlancher, :UtilisateurID, :Visible)';
    return $this->CUDLigne($champs);
  }



  /**
   * Modification d'une enchere
   * @param  array $plChamps champs à ajouter
   * @return array|bool tableau des lignes produites par la select   
   */
  public function modifierEnchere($plChamps)
  {
    $whereClause = array(
      'ID' => $plChamps['ID']
    );
    return $this->modifierTable('enchere', $plChamps, $whereClause);
  }




  /* GESTION DES TIMBRES 
     ================= */
  /**
   * Modification d'une enchere
   * @param  array $plChamps champs à ajouter
   * @return array|bool tableau des lignes produites par la select   
   */
  public function modifierTimbre($plChamps)
  {
    $whereClause = array(
      'ID' => $plChamps['ID']
    );
    $resTimbreImage = $this->modifierImageTimbre($plChamps['ID']);
    $resTimbre =  $this->modifierTable('timbre', $plChamps, $whereClause);
    return ($resTimbreImage == true || $resTimbre == true);

  }




  /**
   * Ajout d'un Timbre
   * @param  array $champs champs à ajouter
   * @return array|bool tableau des lignes produites par la select   
   */

  public function ajouterTimbre($champs)
  {
    $this->sql = ' INSERT INTO timbre
    (Nom, Couleur, PaysOrigine, EtatCondition, Tirage, Longueur, Largeur, Certifie, CategorieID, EnchereID) 
    VALUES 
    (:Nom, :Couleur, :PaysOrigine, :EtatCondition, :Tirage, :Longueur, :Largeur, :Certifie, :CategorieID, :EnchereID)
    ';
    $aResults =$this->CUDLigne($champs);
    if ($aResults) {
      $resTimbreImage = $this->modifierImageTimbre($aResults);
    }
    
    return ($aResults  || $resTimbreImage);

  }


  /**
   * Modifier l'image d'un timbre
   * @param int $timbre_id
   * @return boolean true si téléversement, false sinon
   */
  public function modifierImageTimbre($timbre_id)
  {
    if ($_FILES['ImageCheminImage']['tmp_name'] !== "") {
      //$this->sql = 'update image set CheminImage = :CheminImage where TimbreID = :TimbreID';
      //$this->sql = 'UPDATE film SET film_affiche = :film_affiche WHERE film_id = :film_id';

      $this->sql = 'INSERT INTO image (TimbreID, CheminImage) VALUES (:TimbreID, :ImageCheminImage) 
              ON DUPLICATE KEY UPDATE CheminImage = :ImageCheminImage';
      $champs['TimbreID']      = $timbre_id;
      $champs['ImageCheminImage'] = "medias/stamps/a-$timbre_id-" . time() . ".jpg";
      $res = $this->CUDLigne($champs);
      foreach (glob("medias/stamps/a-$timbre_id-*") as $fichier) {
        if (!@unlink($fichier))
          throw new Exception("Erreur dans la suppression de l'ancien fichier image de l'affiche.");
      }
      if (!@move_uploaded_file($_FILES['ImageCheminImage']['tmp_name'], $champs['ImageCheminImage']))
        throw new Exception("Le stockage du fichier image de l'affiche a échoué.");
      return true;
    }
    return false;
  }


  /**
   * Récupération des Timbres
   * @param  string $critere
   * @return array tableau des lignes produites par la select   
   */
  public function getTimbres($userID = null)
  {
    $params = [];
    $this->sql = "SELECT * from Timbre ";
    if ($userID != null) {
      $params = ['ID' => $userID];
      $this->sql .= "INNER JOIN Enchere ON Timbre.EnchereID = Enchere.ID WHERE Enchere.utilisateurID = :ID ";
    }
    $this->sql .= " ORDER BY Timbre.ID desc";
    return $this->getLignes($params);
  }


  /* GESTION DES ROLES 
   ================= */

  /**
   * Récupération des roles
   * @param  string $critere
   * @return array tableau des lignes produites par la select   
   */
  public function getRoles()
  {
    $this->sql = "SELECT * from Role ORDER BY ID desc";
    return $this->getLignes();
  }



  /*  GESTION DES OFFRES 
   ================= */

  /**
   * Récupération des offres
   * @param  string $critere
   * @return array tableau des lignes produites par la select   
   */


   public function getOffres($enchereID = null)
   {
     $params = [];
     $this->sql = "SELECT * from offre ";
     if ($enchereID != null) {
       $params = ['ID' => $enchereID];
       $this->sql .= " WHERE EnchereID = :ID";
     }
 
 
     $this->sql .= " ORDER BY EnchereID ASC, ID DESC;  ";
     return $this->getLignes($params);
   }
  public function getOffresOLD($userID = null)
  {
    $params = [];
    $this->sql = "SELECT * from offre ";
    if ($userID != null) {
      $params = ['ID' => $userID];
      $this->sql .= " WHERE EnchereID IN (
        SELECT ID FROM enchere
        WHERE UtilisateurID = :ID 
    ) ";
    }


    $this->sql .= " ORDER BY EnchereID ASC, ID DESC;  ";
    return $this->getLignes($params);
  }



  /**
   * Ajout d'un Timbre
   * @param  array $champs champs à ajouter
   * @return array|bool tableau des lignes produites par la select   
   */

   public function ajouterOffre($champs)
   {
     $this->sql = ' INSERT INTO offre
      (EnchereID, UtilisateurID, Prix)
      VALUES 
      (:EnchereID, :UtilisateurID, :EncherePrix)
      ';
      return $this->CUDLigne($champs);
    }





  /* GESTION DES CATEGORIES 
   ================= */

  /**
   * Récupération des categories
   * @param  string $critere
   * @return array tableau des lignes produites par la select   
   */
  public function getCategories()
  {
    $this->sql = "SELECT * from categorie ORDER BY ID desc";
    return $this->getLignes();
  }



  /**
   * Methode  generique pour modifier une table
   * @param  string $table nom de la table
   * @param  array $champs champs à ajouter
   * @param  array $plWhereClause clause where
   * @return array|bool tableau des lignes produites par la select
   */

  public function modifierTable($table, $champs, $plWhereClause)
  {
    $this->sql = 'UPDATE ' . $table . ' SET ';
    $valeurs = '';

    foreach ($champs as $champ => $valeur) {
      $valeurs .= $champ . ' = :' . $champ . ', ';
    }

    $this->sql .= rtrim($valeurs, ', ');

    // Ajout de la clause WHERE
    $whereClause = '';
    foreach ($plWhereClause as $champ => $valeur) {
      $whereClause .= $champ . ' = :' . $champ . ' AND ';
    }

    // Supprimer le dernier 'AND' pour compléter la clause WHERE
    if (!empty($whereClause)) {
      $whereClause = substr($whereClause, 0, -5); // Cela enlève les 5 derniers caractères ' AND '
    }

    $this->sql .= ' WHERE ' . $whereClause;
    $param = $champs + $plWhereClause;

    return $this->CUDLigne($param);
  }
}
