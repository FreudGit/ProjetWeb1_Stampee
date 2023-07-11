<?php

/**
 * Classe Contrôleur des requêtes sur l'entité Genre de l'application admin
 */

class AdminTimbre extends Admin {

  protected $methodes = [
    'l' => ['nom' => 'listerTimbres',   'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR, Utilisateur::PROFIL_CORRECTEUR]],
    'a' => ['nom' => 'ajouterTimbre',   'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR]],
    'm' => ['nom' => 'modifierTimbre',  'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR, Utilisateur::PROFIL_CORRECTEUR]],
    's' => ['nom' => 'supprimerTimbre', 'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR]],
    'lu' => ['nom' => 'listerTimbresUser', 'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR, Utilisateur::PROFIL_CLIENT]]
  ];

  /**
   * Constructeur qui initialise des propriétés à partir du query string
   * et la propriété oRequetesSQL déclarée dans la classe Routeur
   * 
   */
  public function __construct() {
    $this->id = $_GET['id'] ?? null;
    self::$action = $_GET['action'] ?? 'l';
    $this->oRequetesSQL = new RequetesSQL;
  }


/**
   * Lister les Timbres pour un usager courant
   */
  public function listerTimbresUser()
  {
    $this->listerTimbres(self::$oUtilConn->utilisateur_id);

  }

  /**
   * Lister les genres
   */
  public function listerTimbres($id=null) {
    $timbres = $this->oRequetesSQL->getTimbres($id);
    (new Vue)->generer(
      'vAdminTimbres',
      [
        'oUtilConn'           => self::$oUtilConn,
        'titre'               => 'Gestion des timbres',
        'entite'               => 'timbre',
        'timbres'              => $timbres,
        'classRetour'         => $this->classRetour,  
        'messageRetourAction' => $this->messageRetourAction
      ],
      'gabarit-admin');
      
  }

    
  /**
   * Supprimer un Timbre
   */
  public function supprimerTimbre() {
    $retour = $this->oRequetesSQL->supprimerTimbre($this->id);
    if ($retour === false) $this->classRetour = "erreur";
    $this->messageRetourAction = "Suppression du genre numéro $this->id ".($retour ? "" : "non ")."effectuée.";
    $this->listerTimbres();
  }
}