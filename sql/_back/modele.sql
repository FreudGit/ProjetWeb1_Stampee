-- Requête pour effacer toutes les tables
DROP TABLE IF EXISTS CoupDeCoeur;
DROP TABLE IF EXISTS Offre;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Enchere;
DROP TABLE IF EXISTS Image;
DROP TABLE IF EXISTS Timbre;
DROP TABLE IF EXISTS Categorie;
DROP TABLE IF EXISTS Utilisateur;

-- Table Utilisateur
CREATE TABLE IF NOT EXISTS Utilisateur (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Nom VARCHAR(255),
  Rue VARCHAR(255),
  CodePostal VARCHAR(50),
  Ville VARCHAR(255),
  Pays VARCHAR(255),
  Email VARCHAR(255),
  MotDePasse VARCHAR(255),
  DateInscription DATE,
  Valide BOOLEAN DEFAULT FALSE,
  Rating DECIMAL(2, 1)
) ENGINE=InnoDB;

-- Table Categorie
CREATE TABLE IF NOT EXISTS Categorie (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Nom VARCHAR(255)
) ENGINE=InnoDB;

-- Table Timbre
CREATE TABLE IF NOT EXISTS Timbre (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Nom VARCHAR(255),
  DateCreation DATE,
  Couleur VARCHAR(255),
  PaysOrigine VARCHAR(255),
  EtatCondition VARCHAR(255),
  Tirage INT,
  Longueur DECIMAL(10, 2),
  Largeur DECIMAL(10, 2),
  Certifie BOOLEAN,
  CategorieID INT,
  FOREIGN KEY (CategorieID) REFERENCES Categorie(ID)
) ENGINE=InnoDB;

-- Table Image
CREATE TABLE IF NOT EXISTS Image (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  TimbreID INT,
  CheminImage VARCHAR(255),
  Visible BOOLEAN DEFAULT TRUE,
  Description VARCHAR(255),
  Ordre INT,
  FOREIGN KEY (TimbreID) REFERENCES Timbre(ID)
) ENGINE=InnoDB;

-- Table Enchere
CREATE TABLE IF NOT EXISTS Enchere (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  TimbreID INT,
  UtilisateurID INT,
  DateDebut DATE,
  DateFin DATE,
  PrixPlancher DECIMAL(10, 2),
  UtilisateurActuelID INT,
  Visible BOOLEAN DEFAULT TRUE,
  Status VARCHAR(255),
  Rating DECIMAL(2, 1),
  FOREIGN KEY (TimbreID) REFERENCES Timbre(ID),
  FOREIGN KEY (UtilisateurID) REFERENCES Utilisateur(ID),
  FOREIGN KEY (UtilisateurActuelID) REFERENCES Utilisateur(ID)
) ENGINE=InnoDB;

-- Table Offre
CREATE TABLE IF NOT EXISTS Offre (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  EnchereID INT,
  UtilisateurID INT,
  Prix DECIMAL(10, 2),
  Visible BOOLEAN DEFAULT TRUE,
  Status VARCHAR(255),
  FOREIGN KEY (EnchereID) REFERENCES Enchere(ID),
  FOREIGN KEY (UtilisateurID) REFERENCES Utilisateur(ID)
) ENGINE=InnoDB;

-- Table Coup de cœur
CREATE TABLE IF NOT EXISTS CoupDeCoeur (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  TimbreID INT,
  UtilisateurID INT,
  FOREIGN KEY (TimbreID) REFERENCES Timbre(ID),
  FOREIGN KEY (UtilisateurID) REFERENCES Utilisateur(ID)
) ENGINE=InnoDB;

-- Table Transaction
CREATE TABLE IF NOT EXISTS Transaction (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  EnchereID INT,
  UtilisateurID INT,
  Montant DECIMAL(10, 2),
  ModePaiement VARCHAR(255),
  DateTransaction DATE,
  FOREIGN KEY (EnchereID) REFERENCES Enchere(ID),
  FOREIGN KEY (UtilisateurID) REFERENCES Utilisateur(ID)
) ENGINE=InnoDB;
