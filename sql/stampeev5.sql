-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 05 juil. 2023 à 20:29
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`ID`, `Nom`) VALUES
(1, 'Animaux'),
(2, 'Personnages célèbres'),
(3, 'Nature'),
(4, 'Sports'),
(5, 'Histoire');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `enchere`
--

INSERT INTO `enchere` (`ID`, `TimbreID`, `UtilisateurID`, `DateDebut`, `DateFin`, `PrixPlancher`, `UtilisateurActuelID`, `Visible`, `Status`, `Rating`) VALUES
(1, 1, 1, '2023-01-01', '2023-01-31', '10.00', 1, 1, 'En cours', '4.0'),
(2, 2, 2, '2023-02-01', '2023-02-28', '15.00', 2, 1, 'En cours', '4.2'),
(3, 3, 3, '2023-03-01', '2023-03-31', '20.00', 3, 1, 'En cours', '4.5'),
(4, 4, 4, '2023-04-01', '2023-04-30', '25.00', 4, 1, 'En cours', '4.7'),
(5, 5, 5, '2023-05-01', '2023-05-31', '30.00', 5, 1, 'En cours', '4.9');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `image`
--

INSERT INTO `image` (`ID`, `TimbreID`, `CheminImage`, `Visible`, `Description`, `Ordre`) VALUES
(1, 1, 'stamp6.webp', 1, 'Image du timbre Animaux 1', 1),
(2, 1, 'stamp44.webp', 1, 'Image au dos du timbre Animaux 1', 2),
(3, 2, 'stamp666.webp', 1, 'Image du timbre Animaux 2', 1),
(4, 3, 'timbre-1.webp', 1, 'Image du timbre Célébrités 1', 1),
(5, 4, 'timbre-2.webp', 1, 'Image du timbre Célébrités 2', 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `offre`
--

INSERT INTO `offre` (`ID`, `EnchereID`, `UtilisateurID`, `Prix`, `Visible`, `Status`) VALUES
(1, 1, 1, '10.00', 1, 'Acceptée'),
(2, 1, 2, '12.50', 1, 'Acceptée'),
(3, 1, 3, '15.00', 1, 'Acceptée'),
(4, 2, 1, '20.00', 1, 'Acceptée'),
(5, 2, 3, '22.50', 1, 'Acceptée'),
(6, 3, 2, '30.00', 1, 'Acceptée'),
(7, 3, 3, '32.50', 1, 'Acceptée'),
(8, 4, 1, '40.00', 1, 'Acceptée'),
(9, 4, 2, '42.50', 1, 'Acceptée'),
(10, 4, 3, '45.00', 1, 'Acceptée');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nom` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`ID`, `Nom`) VALUES
(1, 'administrateur'),
(2, 'editeur'),
(3, 'correcteur'),
(4, 'client'),
(5, 'visiteur');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `timbre`
--

INSERT INTO `timbre` (`ID`, `Nom`, `DateCreation`, `Couleur`, `PaysOrigine`, `EtatCondition`, `Tirage`, `Longueur`, `Largeur`, `Certifie`, `CategorieID`) VALUES
(1, 'Timbre Animaux 1', '2021-01-01', 'Multicolore', 'Paysville', 'Neuf sans charnière', 10000, '30.50', '20.50', 1, 1),
(2, 'Timbre Animaux 2', '2021-02-01', 'Noir et blanc', 'Paysville', 'Oblitéré', 5000, '25.00', '15.00', 0, 1),
(3, 'Timbre Célébrités 1', '2021-03-01', 'Multicolore', 'Paystimbre', 'Neuf avec charnière', 8000, '35.00', '25.00', 1, 2),
(4, 'Timbre Célébrités 2', '2021-04-01', 'Noir et blanc', 'Paystimbre', 'Oblitéré', 4000, '30.00', '20.00', 0, 2),
(5, 'Timbre Nature 1', '2021-05-01', 'Multicolore', 'Paysprincipal', 'Neuf sans charnière', 6000, '40.00', '30.00', 1, 3);

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
  `utilisateur_profil` varchar(255) DEFAULT NULL,
  `utilisateur_roleID` int DEFAULT NULL,
  PRIMARY KEY (`utilisateur_id`),
  KEY `utilisateur_ibfk_1` (`utilisateur_roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`utilisateur_id`, `utilisateur_nom`, `utilisateur_prenom`, `utilisateur_adresse`, `utilisateur_courriel`, `utilisateur_mdp`, `utilisateur_DateInscription`, `utilisateur_valide`, `utilisateur_renouveler_mdp`, `utilisateur_rating`, `utilisateur_profil`, `utilisateur_roleID`) VALUES
(1, 'John Doe', '', '123 Rue de la Poste', 'john.doe@example.com', 'motdepasse1', '2022-01-01', NULL, '1', '4.5', NULL, NULL),
(2, 'Jane Smith', '', '456 Avenue du Timbre', 'jane.smith@example.com', 'motdepasse2', '2022-02-01', NULL, '1', '4.2', NULL, NULL),
(3, 'Robert Johnson', '', '789 Rue Principale', 'robert.johnson@example.com', 'motdepasse3', '2022-03-01', NULL, '1', '4.7', NULL, NULL),
(4, 'Sarah Wilson', '', '987 Avenue des Philatélistes', 'sarah.wilson@example.com', 'motdepasse4', '2022-04-01', NULL, '1', '4.1', NULL, NULL),
(5, 'Michael Brown', '', '654 Rue des Collectionneurs', 'michael.brown@example.com', 'motdepasse5', '2022-05-01', NULL, '1', '4.9', NULL, NULL),
(26, 'administrateur', 'Charles', NULL, 'administrateur@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', NULL, NULL, 'non', NULL, 'administrateur', 1),
(27, 'editeur', 'Charles', NULL, 'editeur@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', NULL, NULL, 'non', NULL, 'editeur', 2),
(28, 'correcteur', 'Charles', NULL, 'correcteur@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', NULL, NULL, 'non', NULL, 'correcteur', 3),
(29, 'client', 'Charles', NULL, 'client@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', NULL, NULL, 'non', NULL, 'client', 4),
(30, 'visiteur', 'v', '1212 visiteur', 'visiteur@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', '2023-07-05', 'oui', 'non', NULL, NULL, 5);

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

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`utilisateur_roleID`) REFERENCES `role` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
