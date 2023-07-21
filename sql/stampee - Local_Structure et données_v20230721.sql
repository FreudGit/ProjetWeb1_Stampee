-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 21 juil. 2023 à 18:39
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

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

CREATE TABLE `categorie` (
  `ID` int(11) NOT NULL,
  `Nom` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `enchere` (
  `ID` int(11) NOT NULL,
  `UtilisateurID` int(11) DEFAULT NULL,
  `DateDebut` date DEFAULT NULL,
  `DateFin` date DEFAULT NULL,
  `PrixPlancher` decimal(10,2) DEFAULT NULL,
  `Visible` tinyint(1) DEFAULT 1,
  `Status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enchere`
--

INSERT INTO `enchere` (`ID`, `UtilisateurID`, `DateDebut`, `DateFin`, `PrixPlancher`, `Visible`, `Status`) VALUES
(2, 2, '2023-07-08', '2023-07-15', 20.00, 1, 'En cours'),
(4, 4, '2023-07-17', '2023-07-17', 25.00, 0, 'En cours'),
(5, 4, '2023-07-11', '2023-07-18', 35.00, 1, 'Terminée'),
(6, 4, '2023-07-14', '2023-07-14', 15.04, 1, 'En cours'),
(10, 4, '2023-07-16', '2023-07-23', 5.00, 1, 'En cours'),
(17, 2, '2023-07-07', '2023-07-13', 67.00, 1, NULL),
(18, 2, '2023-07-19', '2023-07-13', 78.00, 1, NULL),
(19, 2, '2023-07-13', '2023-07-05', 23.00, 1, NULL),
(20, 1, '2023-07-20', '2023-07-26', 50.00, 1, NULL),
(21, 1, '2023-07-20', '2023-07-21', 67.00, 1, NULL),
(22, 1, '2023-07-14', '2023-07-15', 78.00, 1, NULL),
(24, 1, '2023-07-18', '2023-07-20', 56.00, 1, NULL),
(25, 5, '2023-07-28', '2023-07-29', 2424.00, 1, NULL),
(26, 50, '2023-07-20', '2023-07-29', 777.00, 1, NULL),
(27, 50, '2023-07-21', '2023-07-21', 88.00, 1, NULL),
(28, 5, '2023-07-29', '2023-07-21', 47.00, 1, NULL),
(29, 1, '2023-07-13', '2023-07-21', 36.00, 1, NULL),
(30, 5, '2023-07-06', '2023-07-12', 3.33, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `favoris`
--

CREATE TABLE `favoris` (
  `ID` int(11) NOT NULL,
  `EnchereID` int(11) DEFAULT NULL,
  `UtilisateurID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `favoris`
--

INSERT INTO `favoris` (`ID`, `EnchereID`, `UtilisateurID`) VALUES
(2, 10, 2),
(4, 4, 2),
(5, 5, 5),
(38, 4, 2),
(71, 25, 2),
(72, 29, 5),
(73, 26, 5);

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

CREATE TABLE `image` (
  `ID` int(11) NOT NULL,
  `TimbreID` int(11) DEFAULT NULL,
  `CheminImage` varchar(255) DEFAULT NULL,
  `Visible` tinyint(1) DEFAULT 1,
  `Description` varchar(255) DEFAULT NULL,
  `Ordre` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `image`
--

INSERT INTO `image` (`ID`, `TimbreID`, `CheminImage`, `Visible`, `Description`, `Ordre`) VALUES
(1, 1, 'medias/stamps/stamp6.webp', 1, 'Image du timbre Animaux 1', 1),
(2, 2, 'medias/stamps/stamp44.webp', 1, 'Image au dos du timbre Animaux 1', 2),
(3, 4, 'medias/stamps/stamp666.webp', 1, 'Image du timbre Animaux 2', 1),
(4, 3, 'medias/stamps/timbre-1.webp', 1, 'Image du timbre Célébrités 1', 1),
(6, 6, 'medias/stamps/a-3-1689040069.jpg', 1, NULL, NULL),
(9, 5, 'medias/stamps/a-5-1689040315.jpg', 1, NULL, NULL),
(10, 9, 'medias/stamps/stamp999.webp', NULL, NULL, NULL),
(13, 11, 'medias/stamps/a-11-1689108451.jpg', 1, NULL, NULL),
(14, 14, 'medias/stamps/a-14-1689109214.jpg', 1, NULL, NULL),
(16, 15, 'medias/stamps/a-15-1689109723.jpg', 1, NULL, NULL),
(17, 17, 'medias/stamps/a-17-1689121868.jpg', 1, NULL, NULL),
(18, 19, 'medias/stamps/timbre-2.webp', 1, NULL, NULL),
(19, 20, 'medias/stamps/timbre-1.webp', 1, NULL, NULL),
(20, 21, 'medias/stamps/a-21-1689612543.jpg', 1, NULL, NULL),
(21, 18, 'medias/stamps/stamp999.webp', 1, NULL, NULL),
(22, 16, 'medias/stamps/stamp666.webp', 1, NULL, NULL),
(23, 22, 'medias/stamps/a-22-1689879179.jpg', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `offre`
--

CREATE TABLE `offre` (
  `ID` int(11) NOT NULL,
  `EnchereID` int(11) DEFAULT NULL,
  `UtilisateurID` int(11) DEFAULT NULL,
  `Prix` decimal(10,2) DEFAULT NULL,
  `Visible` tinyint(1) DEFAULT 1,
  `Note` varchar(255) DEFAULT NULL,
  `OffreDate` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `offre`
--

INSERT INTO `offre` (`ID`, `EnchereID`, `UtilisateurID`, `Prix`, `Visible`, `Note`, `OffreDate`) VALUES
(13, 10, 5, 8.70, 1, 'Offre pour enchère 10', '2023-07-06 16:52:18'),
(17, 6, 1, 11.70, 1, 'Offre pour enchère 6', '2023-07-06 16:52:18'),
(19, 4, 3, 10.39, 1, 'Offre pour enchère 4', '2023-07-06 16:52:18'),
(20, 5, 4, 19.08, 1, 'Offre pour enchère 5', '2023-07-06 16:52:18'),
(42, 5, 4, 30.77, 1, 'Offre pour enchère 5', '2023-07-06 17:04:30'),
(45, 4, 2, 12.13, 1, 'Offre pour enchère 4', '2023-07-06 17:04:30'),
(46, 6, 2, 13.15, 1, 'Offre pour enchère 6', '2023-07-06 17:04:30'),
(49, 10, 4, 8.98, 1, 'Offre pour enchère 10', '2023-07-06 17:04:30'),
(61, 4, 4, 4.11, 1, '', '2023-07-06 17:09:12'),
(62, 5, 4, 37.40, 1, '', '2023-07-06 17:09:12'),
(63, 6, 4, 18.43, 1, '', '2023-07-06 17:09:12'),
(64, 10, 4, 7.87, 1, '', '2023-07-06 17:09:12'),
(65, 10, 4, 5.11, 1, '', '2023-07-06 17:09:12'),
(66, 5, 1, 45.40, 1, NULL, '2023-07-12 14:22:04'),
(67, 5, NULL, 57.40, 1, NULL, '2023-07-12 14:27:55'),
(68, 5, NULL, 70.40, 1, NULL, '2023-07-12 14:29:10'),
(69, 5, NULL, 85.40, 1, NULL, '2023-07-12 14:31:32'),
(70, 5, NULL, 104.40, 1, NULL, '2023-07-12 14:32:18'),
(71, 5, NULL, 125.40, 1, NULL, '2023-07-12 14:33:56'),
(72, 5, NULL, 152.40, 1, NULL, '2023-07-12 14:34:32'),
(73, 5, NULL, 187.40, 1, NULL, '2023-07-12 14:35:08'),
(74, 5, NULL, 226.40, 1, NULL, '2023-07-12 14:38:30'),
(75, 5, 5, 272.40, 1, NULL, '2023-07-12 16:10:10'),
(76, 5, 5, 330.40, 1, NULL, '2023-07-12 16:11:04'),
(77, 5, 5, 398.40, 1, NULL, '2023-07-12 16:19:50'),
(78, 5, 5, 481.40, 1, NULL, '2023-07-12 16:22:58'),
(79, 5, 5, 579.40, 1, NULL, '2023-07-12 16:24:04'),
(80, 5, 5, 696.40, 1, NULL, '2023-07-12 16:32:56'),
(81, 5, 5, 837.40, 1, NULL, '2023-07-12 16:35:32'),
(82, 5, 5, 840.40, 1, NULL, '2023-07-12 16:35:58'),
(83, 5, 5, 1011.40, 1, NULL, '2023-07-12 16:44:12'),
(84, 5, 5, 1216.40, 1, NULL, '2023-07-12 16:46:41'),
(85, 5, 5, 1218.40, 1, NULL, '2023-07-12 17:00:39'),
(86, 5, 5, 1226.40, 1, NULL, '2023-07-12 17:01:46'),
(87, 4, 5, 17.13, 1, NULL, '2023-07-12 18:12:36'),
(88, 4, 5, 70.13, 1, NULL, '2023-07-12 18:17:50'),
(89, 10, 5, 13.98, 1, NULL, '2023-07-13 10:38:47'),
(90, 10, 5, 18.98, 1, NULL, '2023-07-13 10:40:18'),
(92, 25, 5, 2429.00, 1, NULL, '2023-07-18 12:20:55'),
(93, 26, 5, 782.00, 1, NULL, '2023-07-19 08:45:17'),
(94, 26, 5, 787.00, 1, NULL, '2023-07-19 09:03:03'),
(95, 25, 5, 2434.00, 1, NULL, '2023-07-19 09:04:12'),
(96, 25, 5, 2439.00, 1, NULL, '2023-07-19 09:05:01'),
(97, 26, 5, 792.00, 1, NULL, '2023-07-20 11:25:28'),
(98, 29, 5, 41.00, 1, NULL, '2023-07-20 11:43:25');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

CREATE TABLE `role` (
  `ID` int(11) NOT NULL,
  `Nom` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `timbre` (
  `ID` int(11) NOT NULL,
  `Nom` varchar(255) DEFAULT NULL,
  `DateCreation` date DEFAULT NULL,
  `Couleur` varchar(255) DEFAULT NULL,
  `PaysOrigine` varchar(255) DEFAULT NULL,
  `EtatCondition` varchar(255) DEFAULT NULL,
  `Tirage` int(11) DEFAULT NULL,
  `Longueur` decimal(10,2) DEFAULT NULL,
  `Largeur` decimal(10,2) DEFAULT NULL,
  `Certifie` tinyint(1) DEFAULT NULL,
  `CategorieID` int(11) DEFAULT NULL,
  `utilisateurID` int(11) DEFAULT NULL,
  `EnchereID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `timbre`
--

INSERT INTO `timbre` (`ID`, `Nom`, `DateCreation`, `Couleur`, `PaysOrigine`, `EtatCondition`, `Tirage`, `Longueur`, `Largeur`, `Certifie`, `CategorieID`, `utilisateurID`, `EnchereID`) VALUES
(1, 'Timbre Animaux 9', '2021-01-01', 'Multicolore', 'Canada', 'Neuf sans charnière', 24, 30.50, 20.55, 0, 5, NULL, 4),
(2, 'Timbre Animaux 3', '2021-02-01', 'Noir et blanc', 'Paysville', 'Oblitéré', NULL, 25.00, 15.00, 0, 1, NULL, 6),
(3, 'Timbre Célébrités 1', '2021-03-01', 'Multicolore', 'Paystimbre', 'Neuf avec charnière', NULL, 35.00, 25.00, 1, 5, NULL, 5),
(4, 'Timbre Célébrités 286777', '2021-04-01', 'Noir et blanc', 'Canada', 'Oblitéré', 12, 30.00, 20.00, 1, 3, NULL, 2),
(5, 'Timbre Nature 15fh', '2021-05-01', 'Multicolore', 'Paysprincipal', 'Neuf sans charnière', NULL, 40.00, 30.00, 1, 3, NULL, 10),
(6, 'Timbre antique', NULL, 'e', 'PaysOrigine', 'EtatCondition', 12, 12.00, 12.00, 1, 1, NULL, 17),
(9, 'Timbre napoleon', NULL, '78', '78', '78', NULL, 78.00, 78.00, 1, 3, NULL, 18),
(10, 'Timbre adorabble', NULL, 'adadad', 'adadad', 'adadad', 23, 23.00, 23.00, 1, NULL, NULL, 19),
(11, 'Tombre de la nativité', NULL, 'm1643', 'm1643', 'm1643', NULL, 88.04, 88.00, 1, 3, NULL, 20),
(12, 'Timbre d\'un autre siècle', NULL, '6767', '6767', '6767', 6767, 6767.00, 6767.00, 1, 4, NULL, 21),
(13, 'Timbre gnutu', NULL, '7878', '7878', '7878', 7878, 7878.00, 7878.00, 1, 5, NULL, 22),
(14, 'Ceci est un timbre', NULL, '46', '46', '46', NULL, 46.00, 46.00, 1, 5, NULL, 2),
(15, 'Ceci est pas mal beau', NULL, '56', '56', '56', 56, 56.00, 566.00, 1, 5, NULL, 24),
(16, 'Timbre familial', NULL, '24', 'Canada', '24', 24, 24.00, 24.00, 1, 5, NULL, 25),
(17, 'Timbre dans le sud', NULL, 'bleue', 'canada', 'neuf', 10000, 12.00, 45.00, 1, 5, NULL, 26),
(18, 'Timpre, ou pas timbre?', NULL, 'bleu', 'canada', 'neuf', 12000, 12.00, 14.00, 1, 3, NULL, 27),
(19, 'Absolument le plus beau timbre', NULL, 'a', 'qe', 'qe', 666, 666.00, 666.00, 1, 5, NULL, 28),
(20, 'Timbre rassurant', NULL, 'afasf', 'qrwq', 'qeqr', 35, 3535.00, 35.00, 1, 5, NULL, 29),
(21, 'timbre canadian', NULL, 'couleur444', 'Antigua and Barbuda', 'CONDITION A', 12, 33.00, 66.00, 1, 1, NULL, 30),
(22, 'Timbre joliement vendable', NULL, 'couleurfh', 'Canada', 'conditionfh', 56, 66.00, 77.00, 1, 5, NULL, 17);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `utilisateur_id` int(11) NOT NULL,
  `utilisateur_nom` varchar(255) DEFAULT NULL,
  `utilisateur_prenom` varchar(255) DEFAULT NULL,
  `utilisateur_adresse` varchar(255) DEFAULT NULL,
  `utilisateur_courriel` varchar(255) DEFAULT NULL,
  `utilisateur_mdp` varchar(255) DEFAULT NULL,
  `utilisateur_DateInscription` timestamp NOT NULL DEFAULT current_timestamp(),
  `utilisateur_valide` varchar(255) DEFAULT NULL,
  `utilisateur_renouveler_mdp` varchar(255) DEFAULT '0',
  `utilisateur_rating` decimal(2,1) DEFAULT NULL,
  `utilisateur_roleID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`utilisateur_id`, `utilisateur_nom`, `utilisateur_prenom`, `utilisateur_adresse`, `utilisateur_courriel`, `utilisateur_mdp`, `utilisateur_DateInscription`, `utilisateur_valide`, `utilisateur_renouveler_mdp`, `utilisateur_rating`, `utilisateur_roleID`) VALUES
(1, 'administrateur', 'Charles', NULL, 'administrateur@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', '2023-07-06 19:58:16', NULL, 'non', NULL, 1),
(2, 'Lord', 'Stampee', 'Chateau Stampee', 'LordStampee@stampee.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', '2023-07-06 19:58:16', NULL, 'non', NULL, 2),
(3, 'Editeur', 'Charlesse', NULL, 'editeur@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', '2023-07-06 19:58:16', NULL, 'non', NULL, 2),
(4, 'correcteur', 'Charles', NULL, 'correcteur@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', '2023-07-06 19:58:16', NULL, 'non', NULL, 3),
(5, 'client', 'Charlesss', NULL, 'client@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', '2023-07-06 19:58:16', NULL, 'non', NULL, 4),
(6, 'visiteur', 'Charless', NULL, 'visiteur@gmail.com', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', '2023-07-06 19:58:16', NULL, 'non', NULL, 4),
(34, 'bobo', 'bobo', NULL, 'bobo', 'fbab59fa07c8bc611f48b15709fea7d2fe2aada1c587309d4575f57af7452addd3d2d85a2788f475f799eb805aaad8a86949afc214d4b66199936b5da5ccf9ed', '2023-07-10 20:35:37', NULL, 'oui', NULL, 4),
(35, 'wewe', 'wewewe', NULL, 'wewewew@ddddd.com', '7046b17147147460aff514116ec03acb9070189e76af1c543a55137e9070cac18053750d659497d7e8d3e6d562e5621553bffde14d2b2df8aee4c74d0a3bd84b', '2023-07-10 20:41:38', NULL, 'oui', NULL, 4),
(36, 'TestTestTest', 'TestTestTest', NULL, 'TestTestTest@gmail.com', 'ced10f4ae0e05cf95582369127ccb41d72125b9d2e3663adaf95149ce5491325a42cb6d0db5470a88cdc29fb2a956e8df86c5655967fdb16075ef279a6499e0e', '2023-07-11 22:53:59', NULL, 'oui', NULL, 4),
(37, 'TestTestTest', 'TestTestTest', NULL, 'TestTestTest2@gmail.com', 'ced10f4ae0e05cf95582369127ccb41d72125b9d2e3663adaf95149ce5491325a42cb6d0db5470a88cdc29fb2a956e8df86c5655967fdb16075ef279a6499e0e', '2023-07-11 22:54:22', NULL, 'oui', NULL, 4),
(38, 'TestTestTest', 'TestTestTest', NULL, 'TestTestTest6@gmail.com', 'ced10f4ae0e05cf95582369127ccb41d72125b9d2e3663adaf95149ce5491325a42cb6d0db5470a88cdc29fb2a956e8df86c5655967fdb16075ef279a6499e0e', '2023-07-11 22:54:36', NULL, 'oui', NULL, 4),
(39, 'hsgfajhf', 'hsgfajh', NULL, 'hsgfajhfkhavf@gmail.com', '71c91954b87918f9f15d192654963db12cc0dc5c065edc2ef066b135f8093c51e6bf77d234ee1b92bd4f3c7d74a01b3e830a03e16088eae93de17392da9673d3', '2023-07-11 23:15:16', NULL, 'oui', NULL, 4),
(40, 'ASASAS', 'ASASAS', NULL, 'FRANCOIS@GMAIL.COM', '97935de2c60596f8f18f519d93ef05e764dbe90d02a9357196a4f02742a634e10e0b864cd3010df0863905c7f34b9b29a775f3be116d7d4ddb9e921e51091776', '2023-07-11 23:39:32', NULL, 'oui', NULL, 4),
(41, 'tes', 'ww', NULL, 'sss@sss.com', 'd801175ca6d055476dd37d09ce68998fc78e2ea648c27e5fb11bf7cc22e579b3fe8adb51566655ac2ffccb6e0d5b695b8644363d2dc41a3138cd2d447b1aedc1', '2023-07-11 23:44:22', NULL, 'oui', NULL, 4),
(42, 'testdTest', 'test', NULL, 'wwww@www.com', '7a7725f7d878bc48ab6b547f219442bf66bef98e74a43de0961fee026bc3078aee96fb2093b7cd70537d498e8357235792231f568a92f473a63b6f38bc227342', '2023-07-11 23:48:18', NULL, 'oui', NULL, 4),
(43, 'testdTest', 'testdTest', NULL, 'testdTest12!@ddd.com', '7a7725f7d878bc48ab6b547f219442bf66bef98e74a43de0961fee026bc3078aee96fb2093b7cd70537d498e8357235792231f568a92f473a63b6f38bc227342', '2023-07-11 23:49:44', NULL, 'oui', NULL, 4),
(44, 'wqeq', 'aadaT', NULL, 'ada@sss.com', 'e17459e45cfe258765bcf459520364c90fad499d283f8f56f3159581f43d4872c6657dd39206eeb0da00feab8ea8ffdf2eebfbde21fc82404d8d2624c27994ea', '2023-07-11 23:53:27', NULL, 'oui', NULL, 4),
(45, 'wqeq', 'aadaT', NULL, 'awda@sss.com', 'e17459e45cfe258765bcf459520364c90fad499d283f8f56f3159581f43d4872c6657dd39206eeb0da00feab8ea8ffdf2eebfbde21fc82404d8d2624c27994ea', '2023-07-11 23:54:49', NULL, 'oui', NULL, 4),
(46, 'aas', 'TestTest', NULL, 'adadad@ddddd.com', '199fc43443f09d6569be869b7270abb54ad3d490ed6601e0d22965d2ebd328551482ac326b65c78858d94c36641b8a2906c5405b7fa91c6d1b4973c6dacd7a3c', '2023-07-11 23:57:17', NULL, 'oui', NULL, 4),
(47, 'asasad', 'adadTest', NULL, 'adadadadada@ssd.com', '8fbc951535325ce6a75b79009b9b3cedf2018a723331a757ad5b8b43d3b5f54ca9d1548efd57eade34e96e65bec38dbb17c1c8741db510d2e122eb391c9b320a', '2023-07-12 00:00:08', NULL, 'oui', NULL, 4),
(48, 'asas', 'asasasTes', NULL, 'asasas@ddd.com', '894d9630a2e6bc280fd452d7be206bffa5860ccdba7fdd0538450805f94d2bb403432e7e7e01184060ce28849983045d449bc7f6cb99be655d8513c478c0e35f', '2023-07-12 00:05:28', NULL, 'oui', NULL, 4),
(49, 'ajhsdfajhsdjhavsdf', 'asfasfasfasf', NULL, '3i43it5353t@gmail.com', '5845bd73ac42d493b20d919836dab0136989af7865dacb86f9e8b59a27f6253c74cf75873a7dbea26d6b59f55dc0d61a5bb87687eb0ac1ff5af827622ee60bb0', '2023-07-12 00:08:15', NULL, 'oui', NULL, 4),
(50, 'francoisTest', 'Heberttest', NULL, 'gttfrancois@gmail.com', '97935de2c60596f8f18f519d93ef05e764dbe90d02a9357196a4f02742a634e10e0b864cd3010df0863905c7f34b9b29a775f3be116d7d4ddb9e921e51091776', '2023-07-12 00:27:54', NULL, 'oui', NULL, 4),
(51, 'testmercredi', 'testmercredi', NULL, 'testmercredi@gmail.com', '97935de2c60596f8f18f519d93ef05e764dbe90d02a9357196a4f02742a634e10e0b864cd3010df0863905c7f34b9b29a775f3be116d7d4ddb9e921e51091776', '2023-07-12 13:05:30', NULL, 'oui', NULL, 4),
(52, 'test', 'ssffsf', NULL, 'jdgsjdgjsgf@gmail.com', '97935de2c60596f8f18f519d93ef05e764dbe90d02a9357196a4f02742a634e10e0b864cd3010df0863905c7f34b9b29a775f3be116d7d4ddb9e921e51091776', '2023-07-12 13:41:12', NULL, 'oui', NULL, 4),
(53, 'FRancois', 'hebert', NULL, 'f@gmail.com', '2c0f45554ae065ca5b7bea528924ac16e608ac64528d74e6fe13b6501712f32f100ce020661b16bfcec0f9c2eaf5007b8b2be897e5769ac33a35b4d0e0a1dadb', '2023-07-18 18:40:40', NULL, 'oui', NULL, 4),
(54, 'francois', 'hebert', NULL, 'ff@f.com', '2c0f45554ae065ca5b7bea528924ac16e608ac64528d74e6fe13b6501712f32f100ce020661b16bfcec0f9c2eaf5007b8b2be897e5769ac33a35b4d0e0a1dadb', '2023-07-18 18:56:43', NULL, 'oui', NULL, 4),
(55, 'test', 'francois', NULL, 'fff@fff.com', '2c0f45554ae065ca5b7bea528924ac16e608ac64528d74e6fe13b6501712f32f100ce020661b16bfcec0f9c2eaf5007b8b2be897e5769ac33a35b4d0e0a1dadb', '2023-07-20 16:49:44', NULL, 'oui', NULL, 4);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `enchere`
--
ALTER TABLE `enchere`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UtilisateurID` (`UtilisateurID`);

--
-- Index pour la table `favoris`
--
ALTER TABLE `favoris`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UtilisateurID` (`UtilisateurID`),
  ADD KEY `favoris_ibfk_1` (`EnchereID`);

--
-- Index pour la table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `TimbreID` (`TimbreID`);

--
-- Index pour la table `offre`
--
ALTER TABLE `offre`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `EnchereID` (`EnchereID`),
  ADD KEY `UtilisateurID` (`UtilisateurID`);

--
-- Index pour la table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `timbre`
--
ALTER TABLE `timbre`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CategorieID` (`CategorieID`),
  ADD KEY `FK_timbre_utilisateur` (`utilisateurID`),
  ADD KEY `FK_timbre_enchere` (`EnchereID`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`utilisateur_id`),
  ADD KEY `utilisateur_ibfk_1` (`utilisateur_roleID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `enchere`
--
ALTER TABLE `enchere`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `favoris`
--
ALTER TABLE `favoris`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT pour la table `image`
--
ALTER TABLE `image`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `offre`
--
ALTER TABLE `offre`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT pour la table `role`
--
ALTER TABLE `role`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `timbre`
--
ALTER TABLE `timbre`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `utilisateur_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `enchere`
--
ALTER TABLE `enchere`
  ADD CONSTRAINT `enchere_ibfk_2` FOREIGN KEY (`UtilisateurID`) REFERENCES `utilisateur` (`utilisateur_id`);

--
-- Contraintes pour la table `favoris`
--
ALTER TABLE `favoris`
  ADD CONSTRAINT `favoris_ibfk_1_new` FOREIGN KEY (`EnchereID`) REFERENCES `enchere` (`ID`) ON DELETE CASCADE,
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
  ADD CONSTRAINT `offre_ibfk_2` FOREIGN KEY (`UtilisateurID`) REFERENCES `utilisateur` (`utilisateur_id`);

--
-- Contraintes pour la table `timbre`
--
ALTER TABLE `timbre`
  ADD CONSTRAINT `FK_timbre_enchere` FOREIGN KEY (`EnchereID`) REFERENCES `enchere` (`ID`),
  ADD CONSTRAINT `FK_timbre_utilisateur` FOREIGN KEY (`utilisateurID`) REFERENCES `utilisateur` (`utilisateur_id`),
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
