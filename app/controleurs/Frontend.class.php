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

  /**
   * Créer un compte utilisateur
   */
  public function creerCompte()
  {
    $oUtilisateur = new Utilisateur($_POST);
    $erreurs = $oUtilisateur->erreurs;
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
    $encheres = $this->oRequetesSQL->getEncheres();
    $aEncheres = [];

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
    //save to session encheres
    $_SESSION['aEncheres'] = $encheres;
    $_SESSION['hello'] = 'hello';

    //get encheres from session

    (new Vue)->generer(
      "vCatalogueContent",
      [
        'oUtilConn' => $this->oUtilConn,
        'titre' => "Welcome",
        'aEncheres' => $encheres
      ],
      "gabarit-frontendS"
    );
  }

  public function recupererEncheresFromJS() {
    $encheres = $this->oRequetesSQL->getEncheres();
    $aEncheres = [];

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
    if (!is_null($this->id)) {
      $enchere = $this->oRequetesSQL->getEnchere($this->id);
    }
    if (!$enchere)
      throw new Exception("Enchere inexistante.");
    $offres = $this->oRequetesSQL->getOffres($this->id);

    (new Vue)->generer(
      "vEnchereContent",
      [
        'oUtilConn' => $this->oUtilConn,
        'titre' => $enchere['TimbreNom'],
        'oEnchere' => $enchere,
        'offres' => $offres,
        'erreurs' => $erreurs
      ],
      "gabarit-frontendS"
    );
  }


}