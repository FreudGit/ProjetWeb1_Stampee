<?php

/**
 * Classe Contrôleur des requêtes sur l'entité Genre de l'application admin
 */

class AdminTimbre extends Admin {

  protected $methodes = [
    'l' => ['nom' => 'listerTimbres',   'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR, Utilisateur::PROFIL_CORRECTEUR]],
    'a' => ['nom' => 'ajouterTimbre',   'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR]],
    'm' => ['nom' => 'modifierTimbre',  'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR, Utilisateur::PROFIL_CORRECTEUR]],
    's' => ['nom' => 'supprimerTimbre', 'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR]]
  ];

  /**
   * Constructeur qui initialise des propriétés à partir du query string
   * et la propriété oRequetesSQL déclarée dans la classe Routeur
   * 
   */
  public function __construct() {
    $this->genre_id = $_GET['genre_id'] ?? null;
    $this->oRequetesSQL = new RequetesSQL;
  }

  /**
   * Lister les genres
   */
  public function listerTimbres() {
    $timbres = $this->oRequetesSQL->getTimbres();
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
   * Supprimer un genre
   */
  public function supprimerTimbre() {
    $retour = $this->oRequetesSQL->supprimerTimbre($this->genre_id);
    if ($retour === false) $this->classRetour = "erreur";
    $this->messageRetourAction = "Suppression du genre numéro $this->genre_id ".($retour ? "" : "non ")."effectuée.";
    $this->listerTimbres();
  }
}