-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 21 juil. 2023 à 00:36
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

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `TimbreID` (`TimbreID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `image`
--
ALTER TABLE `image`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `image_ibfk_1` FOREIGN KEY (`TimbreID`) REFERENCES `timbre` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
