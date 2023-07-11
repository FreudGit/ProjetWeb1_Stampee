<?php

/**
 * Classe de l'entité Enchere
 *
 */
class Enchere extends Entite
{
  protected $ID;
  protected $TimbreID;
  protected $UtilisateurID;
  protected $DateDebut;
  protected $DateFin;
  protected $PrixPlancher;
  protected $UtilisateurActuelID;
  protected $Visible = 0;
  protected $Status;
  protected $Rating;

  protected $TimbreNom;
  protected $TimbreDateCreation;
  protected $TimbreCouleur;
  protected $TimbrePaysOrigine;
  protected $TimbreEtatCondition;
  protected $TimbreTirage;
  protected $TimbreLongueur;
  protected $TimbreLargeur;
  protected $TimbreCertifie  = 0;
  protected $TimbreCategorieID;

  protected $ImageCheminImage;



  /**
   * Mutateur de la propriété ID
   * @param int $ID
   * @return $this
   */
  public function setID($ID) {
    unset($this->erreurs['ID']);
    $regExp = '/^[1-9]\d*$/';
    if (!preg_match($regExp, $ID)) {
      $this->erreurs['ID'] = 'Numéro d\'enchère incorrect.';
    }
    $this->ID = $ID;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreID
   * @param int $TimbreID
   * @return $this
   */
  public function setTimbreID($TimbreID) {
    unset($this->erreurs['TimbreID']);
    $regExp = '/^[1-9]\d*$/';
    if (!preg_match($regExp, $TimbreID)) {
      $this->erreurs['TimbreID'] = 'Numéro de timbre incorrect.';
    }
    $this->TimbreID = $TimbreID;
    return $this;
  }

  /**
   * Mutateur de la propriété UtilisateurID
   * @param int $UtilisateurID
   * @return $this
   */
  public function setUtilisateurID($UtilisateurID) {
    unset($this->erreurs['UtilisateurID']);
    $regExp = '/^[1-9]\d*$/';
    if (!preg_match($regExp, $UtilisateurID)) {
      $this->erreurs['UtilisateurID'] = 'Numéro d\'utilisateur incorrect.';
    }
    $this->UtilisateurID = $UtilisateurID;
    return $this;
  }

  /**
   * Mutateur de la propriété DateDebut
   * @param string $DateDebut
   * @return $this
   */
  public function setDateDebut($DateDebut) {
    unset($this->erreurs['DateDebut']);
    if (!strtotime($DateDebut)) {
      $this->erreurs['DateDebut'] = 'Date de début invalide.';
    }
    $this->DateDebut = $DateDebut;
    return $this;
  }

  /**
   * Mutateur de la propriété DateFin
   * @param string $DateFin
   * @return $this
   */
  public function setDateFin($DateFin) {
    unset($this->erreurs['DateFin']);
    if (!strtotime($DateFin)) {
      $this->erreurs['DateFin'] = 'Date de fin invalide.';
    }
    $this->DateFin = $DateFin;
    return $this;
  }

  /**
   * Mutateur de la propriété PrixPlancher
   * @param float $PrixPlancher
   * @return $this
   */
  public function setPrixPlancher($PrixPlancher) {
    unset($this->erreurs['PrixPlancher']);
    if (!is_numeric($PrixPlancher) || $PrixPlancher < 0) {
      $this->erreurs['PrixPlancher'] = 'Prix plancher invalide.';
    }
    $this->PrixPlancher = $PrixPlancher;
    return $this;
  }

  /**
   * Mutateur de la propriété UtilisateurActuelID
   * @param int $UtilisateurActuelID
   * @return $this
   */
  public function setUtilisateurActuelID($UtilisateurActuelID) {
    unset($this->erreurs['UtilisateurActuelID']);
    $regExp = '/^[1-9]\d*$/';
    if (!preg_match($regExp, $UtilisateurActuelID)) {
      $this->erreurs['UtilisateurActuelID'] = 'Numéro d\'utilisateur actuel incorrect.';
    }
    $this->UtilisateurActuelID = $UtilisateurActuelID;
    return $this;
  }

  /**
   * Mutateur de la propriété Visible
   * @param bool $Visible
   * @return $this
   */
  public function setVisible($Visible) {
    unset($this->erreurs['Visible']);
    $test = filter_var($Visible, FILTER_VALIDATE_INT);

    if ($test === null) {
      $this->erreurs['Visible'] = 'La visibilité doit être un int(boolean).';
    }
    $this->Visible = $Visible;
    return $this;
  }

  /**
   * Mutateur de la propriété Status
   * @param string $Status
   * @return $this
   */
  public function setStatus($Status) {
    unset($this->erreurs['Status']);
    $statusOptions = array('En cours', 'Terminée', 'Annulée');
    if (!in_array($Status, $statusOptions)) {
      $this->erreurs['Status'] = 'Statut invalide.';
    }
    $this->Status = $Status;
    return $this;
  }

  /**
   * Mutateur de la propriété Rating
   * @param float $Rating
   * @return $this
   */
  public function setRating($Rating) {
    unset($this->erreurs['Rating']);
    if (!is_numeric($Rating) || $Rating < 0 || $Rating > 5) {
      $this->erreurs['Rating'] = 'Évaluation invalide.';
    }
    $this->Rating = $Rating;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreNom
   * @param string $TimbreNom
   * @return $this
   */
  public function setTimbreNom($TimbreNom) {
    unset($this->erreurs['TimbreNom']);
    $TimbreNom = trim($TimbreNom);
    $regExp = '/^.+$/';
    if (!preg_match($regExp, $TimbreNom)) {
      $this->erreurs['TimbreNom'] = 'Au moins un caractère.';
    }
    $this->TimbreNom = $TimbreNom;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreDateCreation
   * @param string $TimbreDateCreation
   * @return $this
   */
  public function setTimbreDateCreation($TimbreDateCreation) {
    unset($this->erreurs['TimbreDateCreation']);
    if (!strtotime($TimbreDateCreation)) {
      $this->erreurs['TimbreDateCreation'] = 'Date de création invalide.';
    }
    $this->TimbreDateCreation = $TimbreDateCreation;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreCouleur
   * @param string $TimbreCouleur
   * @return $this
   */
  public function setTimbreCouleur($TimbreCouleur) {
    unset($this->erreurs['TimbreCouleur']);
    $TimbreCouleur = trim($TimbreCouleur);
    $regExp = '/^.+$/';
    if (!preg_match($regExp, $TimbreCouleur)) {
      $this->erreurs['TimbreCouleur'] = 'Au moins un caractère.';
    }
    $this->TimbreCouleur = $TimbreCouleur;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbrePaysOrigine
   * @param string $TimbrePaysOrigine
   * @return $this
   */
  public function setTimbrePaysOrigine($TimbrePaysOrigine) {
    unset($this->erreurs['TimbrePaysOrigine']);
    $TimbrePaysOrigine = trim($TimbrePaysOrigine);
    $regExp = '/^.+$/';
    if (!preg_match($regExp, $TimbrePaysOrigine)) {
      $this->erreurs['TimbrePaysOrigine'] = 'Au moins un caractère.';
    }
    $this->TimbrePaysOrigine = $TimbrePaysOrigine;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreEtatCondition
   * @param string $TimbreEtatCondition
   * @return $this
   */
  public function setTimbreEtatCondition($TimbreEtatCondition) {
    unset($this->erreurs['TimbreEtatCondition']);
    $TimbreEtatCondition = trim($TimbreEtatCondition);
    $regExp = '/^.+$/';
    if (!preg_match($regExp, $TimbreEtatCondition)) {
      $this->erreurs['TimbreEtatCondition'] = 'Au moins un caractère.';
    }
    $this->TimbreEtatCondition = $TimbreEtatCondition;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreTirage
   * @param int $TimbreTirage
   * @return $this
   */
  public function setTimbreTirage($TimbreTirage) {
    unset($this->erreurs['TimbreTirage']);
    if (!preg_match('/^[1-9]\d*$/', $TimbreTirage) || $TimbreTirage < 0) {
      $this->erreurs['TimbreTirage'] = 'Tirage invalide.';
    }
    $this->TimbreTirage = $TimbreTirage;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreLongueur
   * @param float $TimbreLongueur
   * @return $this
   */
  public function setTimbreLongueur($TimbreLongueur) {
    unset($this->erreurs['TimbreLongueur']);
    if (!is_numeric($TimbreLongueur) || $TimbreLongueur < 0) {
      $this->erreurs['TimbreLongueur'] = 'Longueur invalide.';
    }
    $this->TimbreLongueur = $TimbreLongueur;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreLargeur
   * @param float $TimbreLargeur
   * @return $this
   */
  public function setTimbreLargeur($TimbreLargeur) {
    unset($this->erreurs['TimbreLargeur']);
    if (!is_numeric($TimbreLargeur) || $TimbreLargeur < 0) {
      $this->erreurs['TimbreLargeur'] = 'Largeur invalide.';
    }
    $this->TimbreLargeur = $TimbreLargeur;
    return $this;
  }

  /**
   * Mutateur de la propriété TimbreCertifie
   * @param bool $TimbreCertifie
   * @return $this
   */
  public function setTimbreCertifie($TimbreCertifie) {
    unset($this->erreurs['TimbreCertifie']);
    $test = filter_var($TimbreCertifie, FILTER_VALIDATE_INT);

    if ($test === null) {
      $this->erreurs['TimbreCertifie'] = 'La certification doit être un booléen.';
    }
    $this->TimbreCertifie = $TimbreCertifie;
    return $this;
  }

  /**
   * Mutateur de la propriété CategorieID
   * @param int $CategorieID
   * @return $this
   */
  public function setTimbreCategorieID($TimbreCategorieID) {
    unset($this->erreurs['TimbreCategorieID']);
    //$TimbreCategorieID= is_numeric($TimbreCategorieID) ? (int)$TimbreCategorieID : 0;
    $regExp = '/^[1-9]\d*$/';
    if (!preg_match($regExp, $TimbreCategorieID)) {
      $this->erreurs['TimbreCategorieID'] = 'Numéro de catégorie incorrect.';
    }
    $this->TimbreCategorieID = $TimbreCategorieID;
    return $this;
  }


   /**
   * Mutateur de la propriété TimbreCouleur
   * @param string $ImageCheminImage
   * @return $this
   */
  public function setImageCheminImage($ImageCheminImage) {
    unset($this->erreurs['ImageCheminImage']);
    $ImageCheminImage = trim($ImageCheminImage);
    $regExp = '/^.+$/';
    if (!preg_match($regExp, $ImageCheminImage)) {
      $this->erreurs['ImageCheminImage'] = 'Au moins un caractère.';
    }
    $this->ImageCheminImage = $ImageCheminImage;
    return $this;
  }
}
