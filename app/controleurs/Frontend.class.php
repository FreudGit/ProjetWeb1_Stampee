<?php

/**
 * Classe Contrôleur des requêtes de l'interface frontend
 * 
 */

class Frontend extends Routeur
{

  private $id;
  private $oUtilConn;

  /**
   * Constructeur qui initialise des propriétés à partir du query string
   * et la propriété oRequetesSQL déclarée dans la classe Routeur
   * 
   */
  public function __construct()
  {
    $this->oUtilConn = $_SESSION['oUtilConn'] ?? null;
    $this->id = $_GET['id'] ?? null;
    $this->oRequetesSQL = new RequetesSQL;
  }

  /**
   * Connecter un utilisateur
   */
  public function connecter()
  {
    $utilisateur = $this->oRequetesSQL->connecter($_POST);
    if ($utilisateur !== false) {
      $_SESSION['oUtilConn'] = new Utilisateur($utilisateur);
    }
    echo json_encode($utilisateur);
  }
  public function console_log2($output, $with_script_tags = true) {
    $js_code = 'console.log(' . json_encode($output, JSON_HEX_TAG) . 
');';
    if ($with_script_tags) {
        $js_code = '<script>' . $js_code . '</script>';
    }
    echo $js_code;
}
  /**
   * Créer un compte utilisateur
   */
  public function creerCompte()
  {
    $this->console_log2('creerCompte');
    $oUtilisateur = new Utilisateur($_POST);
    $this->console_log2(__LINE__);

    $erreurs = $oUtilisateur->erreurs;
    $this->console_log2(__LINE__);

    if (count($erreurs) > 0) {
      $retour = $erreurs;
    } else {
      $retour = $this->oRequetesSQL->creerCompteClient($_POST);
      if (!is_array($retour) && preg_match('/^[1-9]\d*$/', $retour)) {
        $oUtilisateur->utilisateur_id = $retour;
        $oUtilisateur->utilisateur_profil = Utilisateur::PROFIL_CLIENT;
        $_SESSION['oUtilConn'] = $oUtilisateur;
        $this->afficherWelcome();
        exit;
      }
    }
    $this->console_log2(__LINE__);

    
    $view = 'vModaleCreerCompte' ;
    (new Vue)->generer(
      $view,
      [
        'titre' => 'Connexion',
        //'renouvelerMdp' => $renouvelerMdp,
        //'messageErreurConnexion' => $messageErreurConnexion,
        //'utilisateur' => $utilisateur,
        'erreurs' => $erreurs
      ],
      'gabarit-admin-min'
    );
    //echo json_encode($retour);
  }

  /**
   * Ajouter une enchère à la liste des favoris
   * retourne true si l'enchère a été ajoutée, false sinon
   */

  public function ajouterEnchereAFavorisFromPost()
  {
    $post = $_POST;
    $params = [];
    $params['UtilisateurID'] = $this->oUtilConn->utilisateur_id;
    $params['EnchereID'] = $post['enchereID'];
    $retour = $this->oRequetesSQL->ajouterEnchereAFavoris($params);
    echo json_encode($retour);
  }


  /**
   * Retirer une enchère à la liste des favoris
   * retourne true si l'enchère a été ajoutée, false sinon
   */

  public function retirerEnchereAFavorisFromPost()
  {
    $post = $_POST;
    $params = [];
    $params['UtilisateurID'] = $this->oUtilConn->utilisateur_id;
    $params['EnchereID'] = $post['enchereID'];
    $retour = $this->oRequetesSQL->retirerEnchereAFavoris($params);
    echo json_encode($retour);
  }


  /**
   * Déconnecter un utilisateur
   */
  public function deconnecter()
  {
    unset($_SESSION['oUtilConn']);
    echo json_encode(true);
  }


  public function afficherLogin()
  {
    (new Vue)->generer(
      "vLoginContent",
      [
        'oUtilConn' => $this->oUtilConn,
        'titre' => "Welcome"
      ],
      "gabarit-frontendS"
    );
  }


  public function afficherLoginCreate()
  {
    (new Vue)->generer(
      "vLoginContent",
      [
        'oUtilConn' => $this->oUtilConn,
        'titre' => "Welcome"
      ],
      "gabarit-frontendS"
    );
  }

  /**
   * page Welcome
   * 
   */
  public function afficherWelcome()
  {
    (new Vue)->generer(
      "vWelcomeContent",
      [
        'oUtilConn' => $this->oUtilConn,
        'titre' => "Welcome",
      ],
      "gabarit-frontendS"
    );
  }


  /**
   * page Catalogue
   * 
   */
  public function afficherCatalogue()
  {
    $userIDFav = null;
    if ($this->oUtilConn) {
      $userIDFav = $this->oUtilConn->utilisateur_id;
    }
    $encheres = $this->oRequetesSQL->getEncheres(null, $userIDFav);

    //order by date fin asc
    usort($encheres, function ($a, $b) {
      return $b['DateFin'] <=> $a['DateFin'];
    });

    $now = new DateTime();
    foreach ($encheres as &$enchere) {
      $endDateTime = new DateTime($enchere['DateFin']);
      $interval = $now->diff($endDateTime);
      $remainingTime = '';
      if ($interval->invert) {
        $remainingTime .= 'Terminée';
      } else {
        if ($interval->d > 0) {
          $remainingTime .= $interval->d . 'j ';
        }
        if ($interval->h > 0) {
          $remainingTime .= $interval->h . 'h ';
        }
        if ($interval->i > 0) {
          $remainingTime .= $interval->i . 'min';
        }

      }
      $enchere['RemainingTime'] = $remainingTime;
    }
    $aCategories = $this->oRequetesSQL->getCategories();

    (new Vue)->generer(
      "vCatalogueContent",
      [
        'oUtilConn' => $this->oUtilConn,
        'titre' => "Welcome",
        'aEncheres' => $encheres,
        'aCategories' => $aCategories
      ],
      "gabarit-frontendS"
    );
  }

  public function recupererEncheresFromJS()
  {

    $userIDFav = null;
    if ($this->oUtilConn) {
      $userIDFav = $this->oUtilConn->utilisateur_id;
    }
    $encheres = $this->oRequetesSQL->getEncheres(null, $userIDFav);

    $now = new DateTime(); // Current date and time
    foreach ($encheres as &$enchere) {
      $endDateTime = new DateTime($enchere['DateFin']); // Date and time from the database
      $interval = $now->diff($endDateTime); // Calculate the difference between now and the end date
      $remainingTime = '';
      if ($interval->d > 0) {
        $remainingTime .= $interval->d . 'j ';
      }
      if ($interval->h > 0) {
        $remainingTime .= $interval->h . 'h ';
      }
      if ($interval->i > 0) {
        $remainingTime .= $interval->i . 'min';
      }
      $enchere['RemainingTime'] = $remainingTime;
    }
    echo json_encode($encheres);
  }


  /**
   * Voir les informations d'une enchere
   * 
   */
  public function afficherEnchere()
  {
    $erreurs = [];
    if (count($_POST) !== 0) {

      $enchere = $this->oRequetesSQL->ajouterOffre([
        'EnchereID' => $_POST['EnchereID'],
        'EncherePrix' => $_POST['EncherePrix'],
        'UtilisateurID' => $this->oUtilConn->utilisateur_id
      ]);
      $erreurs['messageRetour'] = '      Offre ajoutée!';
      $erreurs['classRetour'] = 'fait';
    }
    $enchere = false;


    $userIDFav = null;
    if ($this->oUtilConn) {
      $userIDFav = $this->oUtilConn->utilisateur_id;
    }

    if (!is_null($this->id)) {
      $enchere = $this->oRequetesSQL->getEnchere($this->id, $userIDFav);
      // Validadion si enchere terminée
      $now = new DateTime();
      $dateFin = new DateTime($enchere['DateFin']);
      $interval = $now->diff($dateFin);
      $enchere['EnchereIsActive'] = !($interval->invert);
    }

    if (!$enchere)
      throw new Exception("Enchere inexistante.");
    $offres = $this->oRequetesSQL->getOffres($this->id);
    $aCategories = $this->oRequetesSQL->getCategories();

    (new Vue)->generer(
      "vEnchereContent",
      [
        'oUtilConn' => $this->oUtilConn,
        'titre' => $enchere['TimbreNom'],
        'oEnchere' => $enchere,
        'offres' => $offres,
        'aCategories' => $aCategories,
        'erreurs' => $erreurs
      ],
      "gabarit-frontendS"
    );
  }
}