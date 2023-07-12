<?php

/**
 * Classe Contrôleur des requêtes sur l'entité Genre de l'application admin
 */

class AdminOffre extends Admin
{

  // protected $entite = "genre";
  protected $methodes = [
    'l' => ['nom' => 'listerOffres', 'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR, Utilisateur::PROFIL_CORRECTEUR, Utilisateur::PROFIL_CLIENT]],
    'a' => ['nom' => 'ajouterOffre', 'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR]],
    'm' => ['nom' => 'modifierOffre', 'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR, Utilisateur::PROFIL_CORRECTEUR]],
    's' => ['nom' => 'supprimerGenre', 'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR]],
    'lu' => ['nom' => 'listerOffresUser', 'droits' => [Utilisateur::PROFIL_ADMINISTRATEUR, Utilisateur::PROFIL_EDITEUR, Utilisateur::PROFIL_CLIENT]]
  ];

  /**
   * Constructeur qui initialise des propriétés à partir du query string
   * et la propriété oRequetesSQL déclarée dans la classe Routeur
   * 
   */
  public function __construct()
  {
    $this->id = $_GET['id'] ?? null;
    self::$action = $_GET['action'] ?? 'l';
    $this->oRequetesSQL = new RequetesSQL;
  }


  /**
   * Lister les offres pour un usager courant
   */
  public function listerOffresUser()
  {
    $this->listerOffres(self::$oUtilConn->utilisateur_id);

  }


  /**
   * Lister les offres 
   */
  public function listerOffres($userID = null)
  {
    $offres = $this->oRequetesSQL->getOffres($userID);
    (new Vue)->generer(
      'vAdminOffres',
      [
        'oUtilConn' => self::$oUtilConn,
        'titre' => 'Gestion des Offres',
        'entite' => 'offre',
        'action' => self::$action,
        'offres' => $offres,
        'classRetour' => $this->classRetour,
        'messageRetourAction' => $this->messageRetourAction
      ],
      'gabarit-admin'
    );
  }

}