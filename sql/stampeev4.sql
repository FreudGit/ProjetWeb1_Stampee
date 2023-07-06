-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 05 juil. 2023 à 20:13
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `stampee`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nom` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `enchere`
--

DROP TABLE IF EXISTS `enchere`;
CREATE TABLE IF NOT EXISTS `enchere` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TimbreID` int DEFAULT NULL,
  `UtilisateurID` int DEFAULT NULL,
  `DateDebut` date DEFAULT NULL,
  `DateFin` date DEFAULT NULL,
  `PrixPlancher` decimal(10,2) DEFAULT NULL,
  `UtilisateurActuelID` int DEFAULT NULL,
  `Visible` tinyint(1) DEFAULT '1',
  `Status` varchar(255) DEFAULT NULL,
  `Rating` decimal(2,1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `TimbreID` (`TimbreID`),
  KEY `UtilisateurID` (`UtilisateurID`),
  KEY `UtilisateurActuelID` (`UtilisateurActuelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `favoris`
--

DROP TABLE IF EXISTS `favoris`;
CREATE TABLE IF NOT EXISTS `favoris` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TimbreID` int DEFAULT NULL,
  `UtilisateurID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `TimbreID` (`TimbreID`),
  KEY `UtilisateurID` (`UtilisateurID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

DROP TABLE IF EXISTS `image`;
CREATE TABLE IF NOT EXISTS `image` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TimbreID` int DEFAULT NULL,
  `CheminImage` varchar(255) DEFAULT NULL,
  `Visible` tinyint(1) DEFAULT '1',
  `Description` varchar(255) DEFAULT NULL,
  `Ordre` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `TimbreID` (`TimbreID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `offre`
--

DROP TABLE IF EXISTS `offre`;
CREATE TABLE IF NOT EXISTS `offre` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EnchereID` int DEFAULT NULL,
  `UtilisateurID` int DEFAULT NULL,
  `Prix` decimal(10,2) DEFAULT NULL,
  `Visible` tinyint(1) DEFAULT '1',
  `Status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `EnchereID` (`EnchereID`),
  KEY `UtilisateurID` (`UtilisateurID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `timbre`
--

DROP TABLE IF EXISTS `timbre`;
CREATE TABLE IF NOT EXISTS `timbre` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nom` varchar(255) DEFAULT NULL,
  `DateCreation` date DEFAULT NULL,
  `Couleur` varchar(255) DEFAULT NULL,
  `PaysOrigine` varchar(255) DEFAULT NULL,
  `EtatCondition` varchar(255) DEFAULT NULL,
  `Tirage` int DEFAULT NULL,
  `Longueur` decimal(10,2) DEFAULT NULL,
  `Largeur` decimal(10,2) DEFAULT NULL,
  `Certifie` tinyint(1) DEFAULT NULL,
  `CategorieID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `CategorieID` (`CategorieID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `utilisateur_id` int NOT NULL AUTO_INCREMENT,
  `utilisateur_nom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `utilisateur_prenom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `utilisateur_adresse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `utilisateur_courriel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `utilisateur_mdp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `utilisateur_DateInscription` date DEFAULT NULL,
  `utilisateur_valide` varchar(255) DEFAULT NULL,
  `utilisateur_renouveler_mdp` varchar(255) DEFAULT '0',
  `utilisateur_rating` decimal(2,1) DEFAULT NULL,
  `utilisateur_roleID` int DEFAULT NULL,
  `utilisateur_profil` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `enchere`
--
ALTER TABLE `enchere`
  ADD CONSTRAINT `enchere_ibfk_1` FOREIGN KEY (`TimbreID`) REFERENCES `timbre` (`ID`),
  ADD CONSTRAINT `enchere_ibfk_2` FOREIGN KEY (`UtilisateurID`) REFERENCES `utilisateur` (`utilisateur_id`),
  ADD CONSTRAINT `enchere_ibfk_3` FOREIGN KEY (`UtilisateurActuelID`) REFERENCES `utilisateur` (`utilisateur_id`);

--
-- Contraintes pour la table `favoris`
--
ALTER TABLE `favoris`
  ADD CONSTRAINT `favoris_ibfk_1` FOREIGN KEY (`TimbreID`) REFERENCES `timbre` (`ID`),
  ADD CONSTRAINT `favoris_ibfk_2` FOREIGN KEY (`UtilisateurID`) REFERENCES `utilisateur` (`utilisateur_id`);

--
-- Contraintes pour la table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `image_ibfk_1` FOREIGN KEY (`TimbreID`) REFERENCES `timbre` (`ID`);

--
-- Contraintes pour la table `offre`
--
ALTER TABLE `offre`
  ADD CONSTRAINT `offre_ibfk_1` FOREIGN KEY (`EnchereID`) REFERENCES `enchere` (`ID`),
  ADD CONSTRAINT `offre_ibfk_2` FOREIGN KEY (`UtilisateurID`) REFERENCES `utilisateur` (`utilisateur_id`);

--
-- Contraintes pour la table `timbre`
--
ALTER TABLE `timbre`
  ADD CONSTRAINT `timbre_ibfk_1` FOREIGN KEY (`CategorieID`) REFERENCES `categorie` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
