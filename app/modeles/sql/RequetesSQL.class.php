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
    $this->sql = '
      INSERT INTO utilisateur SET
      utilisateur_nom            = :utilisateur_nom,
      utilisateur_prenom         = :utilisateur_prenom,
      utilisateur_courriel       = :utilisateur_courriel,
      utilisateur_mdp            = SHA2(:nouveau_mdp, 512),
      utilisateur_renouveler_mdp = "non",
      utilisateur_profil         = "' . Utilisateur::PROFIL_CLIENT . '"';
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
  public function getEncheres()
  {


    $this->sql = "SELECT
e.ID ,
e.DateDebut,
e.DateFin,
e.PrixPlancher,
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
    WHERE
        Ordre = 1
) i ON t.ID = i.TimbreID;";

    return $this->getLignes();
  }



  /**
   * Récupération des encheres à l'affiche ou prochainement ou pour l'interface admin
   * @param  string $critere
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
    WHERE
        Ordre = 1
) i ON t.ID = i.TimbreID
WHERE e.ID = :ID;";

    return $this->getLignes(['ID' => $id], RequetesPDO::UNE_SEULE_LIGNE);

  }



  public function modifierEnchereOLD($champs)
  {
    $this->sql = '
      UPDATE enchere SET
      DateDebut            = :DateDebut, 
      DateFin            = :DateFin, 
      PrixPlancher            = :PrixPlancher, 
      UtilisateurID            = :UtilisateurID, 
      Visible            = :Visible, 
      Status            = :Status
      WHERE ID = :ID';
    return $this->CUDLigne($champs);
  }

  public function ajouterEnchere($champs)
  {
    $this->sql = '
      INSERT INTO enchere (DateDebut, DateFin, PrixPlancher, UtilisateurID, Visible)
      VALUES (:DateDebut, :DateFin, :PrixPlancher, :UtilisateurID, :Visible)';
    return $this->CUDLigne($champs);
  }

  public function modifierTimbre($plChamps)
  {


    $whereClause = array(
      'ID' => $plChamps['ID']
    );
    return $this->modifierTable('timbre', $plChamps, $whereClause);
  }

  
  

  public function ajouterTimbre($champs)
  {
    $this->sql = ' INSERT INTO timbre
    (Nom, Couleur, PaysOrigine, EtatCondition, Tirage, Longueur, Largeur, Certifie, CategorieID, EnchereID) 
    VALUES 
    (:Nom, :Couleur, :PaysOrigine, :EtatCondition, :Tirage, :Longueur, :Largeur, :Certifie, :CategorieID, :EnchereID)
    ';
    return $this->CUDLigne($champs);
  }





  public function modifierEnchere($plChamps)
  {


    $whereClause = array(
      'ID' => $plChamps['ID']
    );
    return $this->modifierTable('enchere', $plChamps, $whereClause);
  }


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



  /* GESTION DES TIMBRES 
   ================= */

  /**
   * Récupération des roles
   * @param  string $critere
   * @return array tableau des lignes produites par la select   
   */
  public function getTimbres()
  {
    $this->sql = "SELECT * from Timbre ORDER BY ID desc";
    return $this->getLignes();
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

}