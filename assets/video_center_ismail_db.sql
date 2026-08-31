-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 31 août 2026 à 06:48
-- Version du serveur : 8.4.7
-- Version de PHP : 8.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `video_center_ismail_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20260810230458', '2026-08-10 23:05:45', 20),
('DoctrineMigrations\\Version20260813000947', '2026-08-13 00:10:48', 171),
('DoctrineMigrations\\Version20260813230732', '2026-08-13 23:08:14', 75),
('DoctrineMigrations\\Version20260814102636', '2026-08-14 10:27:18', 208),
('DoctrineMigrations\\Version20260815163219', '2026-08-15 16:33:20', 98),
('DoctrineMigrations\\Version20260817160212', '2026-08-17 16:08:00', 126);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `selector` varchar(20) NOT NULL,
  `hashed_token` varchar(100) NOT NULL,
  `requested_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_verified` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `created_at`, `updated_at`, `is_verified`) VALUES
(1, 'ismaildimah@gmail.com', '[]', '$2y$13$N8V7l.Q6SaKQtigTOQBh0.Aok72tlYm/8e6QdX.BYxF6FedYBVsr.', 'Ismail', 'Dimah', '2026-08-13 00:14:03', '2026-08-15 13:12:55', 1),
(2, 'iliasboumkassar@gmail.com', '[]', '$2y$13$26UsxJnz3jgbq4OHspqKpOZVO7UNr7xkBBla4wJGLtXOE8bRqtl9.', 'Ilias', 'Boumkassar', '2026-08-13 00:14:03', '2026-08-14 23:23:07', 1),
(3, 'amineboumkassar@gmail.com', '[]', '$2y$13$3amTqbO0mW.ROM0YIy8.1eVrcXL.3ibEE.QxIdgTKzqnE9EA4yXLi', 'Amine', 'Boumkassar', '2026-08-14 08:43:44', '2026-08-14 09:08:29', 1),
(5, 'boumkassarjunayd@gmail.com', '[]', '$2y$13$kIqn5m9YN1ApiZm95NUgXuD.di07jMXR5zK8McQ4wfRtu6Gz/2vQG', 'Junayd', 'Boumkassar', '2026-08-14 08:54:24', '2026-08-14 08:57:44', 0);

-- --------------------------------------------------------

--
-- Structure de la table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE IF NOT EXISTS `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `video_link` varchar(500) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int NOT NULL,
  `premium_video` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_29AA6432A76ED395` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `videos`
--

INSERT INTO `videos` (`id`, `title`, `video_link`, `description`, `created_at`, `updated_at`, `user_id`, `premium_video`) VALUES
(1, 'Ce Père de Famille a Infiltré la Corée du Nord', 'https://www.youtube.com/embed/XO4RngwP50s', 'On dirait le scénario d\'un film d’espionnage, mais l’histoire d’Ulrich Larsen est bien réelle.\nMerci beaucoup à NordVPN d’avoir sponsorisé cette vidéo ! Abonnez-vous avec mon lien 💛 https://nordvpn.com/yvancasta\nCollaboration commerciale\n\nUne grande partie des images d’archives utilisées est issue du documentaire The Mole: Undercover in North Korea, réalisé par Mads Brügger.\n▬▬▬▬▬▬▬▬▬ Mes réseaux 🔥 ▬▬▬▬▬▬▬▬▬\n🔻 INSTAGRAM :   / yvancasta   \n🔻 TIK TOK :   / yvan_casta   \n🔻 SPOTIFY : bit.ly/3MZ6ws0\n▬▬▬▬▬▬▬▬▬ Crédits 💡▬▬▬▬▬▬▬▬▬\nChargée de production : Solène Chupin \nCo-autrice : Marianne Sigrist\nMaquettiste : Mathéo du collectif DS\nMonteur et réalisation 3D : Tom Canals\nMonteur collaboration commerciale : Thomas Alvar\nMiniature : Enzo Kerlogot \nRéalisation plans cinématiques : Loïc Gangloff\nAssistant cadrage plans cinématiques : Thomas Alvar\n\n📩 Boîte mail pro → yvancasta.pro@gmail.com \n\n💛 Merci à tous ceux qui me soutiennent en s\'abonnant et en likant la vidéo !', '2026-08-11 21:11:26', '2026-08-15 16:51:58', 1, 1),
(2, 'Citroën Ami : L\'angoisse.', 'https://www.youtube.com/embed/bExwoNoddOA', 'Merci au circuit de l\'Ouest Parisien pour leur accueil comme toujours exceptionnel\nMerci aux mairies de Hargeville et Jumeauville pour leur accord et la fermeture de la route\n\nProduction : Anaelle Le Magorou et Capucine Semur\nImage : Lucas Martin\nSon : Alan Poirier\nDrone : Thibault Gabet et Fabrice Baroiller\nMontage sponso : Robin Danos\nMontage : Lucas Aubert, Pablo Kerlogot et Thibault Iacolare\nVignette : Quentin Legac et Skoty.Studio\nAutomobiliste énervé : Joseph Shuman\nAssistant retournement : Charles Kengen', '2026-08-11 22:08:25', '2026-08-11 22:08:25', 2, 0),
(3, 'L\'Argent chez les Influenceurs', 'https://www.youtube.com/embed/E7W_9V_OhYg', 'Profitez de 5€ de réduction sur votre premier achat sur HOLY avec le code ZACK5 https://fr.weareholy.com/Zack | Publicité\n\nRetrouvez tous les épisodes de Lockin en vidéo sur Spotify : https://open.spotify.com/show/59Xa5rp...\n\nUn Kebab, Trois Tontons et Un invité. Et ça débat.', '2026-08-11 22:10:35', '2026-08-11 22:11:28', 3, 1),
(4, 'Guillaume Pley : clap de fin d’une LEGEND.', 'https://www.youtube.com/embed/ZYDUxQWcvB4', 'C\'est le retour. RDV à la rentrée pour les « OFF » et l’après-enquête. Cette longue vidéo sur l\'iceberg derrière LEGEND et Guillaume Pley n\'est pas sponsorisée.\n🗂️ Pour nous permettre de financer les prochaines alertes 100% sans tabou, mode David contre Goliath : https://fr.ulule.com/tpz/ \n(objectif 25.000€ pour lancer notre émission!)\n\nL\'enquête du jour sur Guillaume Pley, LEGEND et tout l\'écosystème médiatique et financier autour s\'est effectuée avec l\'appui de journalistes, juristes, avocats, experte en publicité, Docteur en sociologie... et de Gaspard Cazin & Allan Simon à la co-écriture.\n\nDe NRJ à LEGEND en passant par \"Le QG\", Guillaume Pley signe de grands succès en animant ses formats. Mais, s\'y retrouvent aussi des échecs. Voyons ce qu\'on à nous en dire des personnes qui ont croisé sa route.\nDans cette vidéo, nous allons aussi en profiter pour parler de l\'agence \"/influx\", fondée par Manuel Diaz, co-productrice de l\'émission LEGEND et qui défend aussi les intérêts de : Léo Duff, Romain Lanéry, Océane, Ludoc, Laurent Baffie etc.', '2026-08-11 22:14:19', '2026-08-11 22:14:51', 1, 0),
(5, '« Les chiens m’ont sauvé la vie ! » ft. Franck Ga', 'https://www.youtube.com/embed/I6oxr4TPKf8', 'Franck Gastambide ce n’est pas un passionné de chiens… c’est plus que ça ! Les chiens lui ont sauvé la vie, et il leur doit la carrière qu’il a aujourd’hui ! \nOn revient sur son parcours, quand il était éducateur canin, éleveur, quand il faisait les expos. Mais aussi sur son passé d’agent de sécurité avec son chien, comment ses chiens lui ont donné la carrière qu’il a aujourd’hui… Les anecdotes de tournages, les chiens qui ont marqué sa vie, son engagement auprès des associations, la douleur de perdre un compagnon. \nBref un moment un peu hors du temps, fort en émotions et en surprises !', '2026-08-11 22:16:49', '2026-08-11 22:18:54', 2, 1),
(6, 'La fin d\'Infantino ?', 'https://www.youtube.com/embed/ysGdAXAPcHE', 'Affaibli comme jamais, Gianni Infantino s\'accroche à son poste de président de la FIFA avec ses soutiens africains ou sud-américains.\n\nCependant, la position prise par le président de l\'AFC, la Confédération asiatique, en soutien de la CONCACAF et l\'UEFA représente un tournant majeur de cette bataille politique...', '2026-08-11 22:21:14', '2026-08-11 22:21:14', 3, 1),
(7, 'DEVINE QUI EST LE JOUEUR PRO ! (Ft. Domingo et Wal', 'https://www.youtube.com/embed/AxgqNisSNbs', 'Retour de votre concept préféré où l\'on doit deviner le joueur pro puis les classer par ordre de niveau avec Domingo et Walid Acherchour ! Un joueur a notamment joué en Ligue 2\n\nAvez-vous trouvé la bonne réponse ? Quel est le prochain invité que vous voulez voir sur la chaîne ?', '2026-08-13 22:53:12', '2026-08-13 22:53:12', 1, 0),
(15, 'L\'Iceberg des PIRES Scandales de la TV !', 'https://www.youtube.com/embed/8HenOG4iIgc', 'Que se passe-t-il quand le direct échappe à tout contrôle ? Des tricheries légendaires aux comportements toxiques restés impunis pendant des décennies, la télévision a été le théâtre de moments ultra-gênants et parfois profondément sombres. Oubliez le script et les sourires ultra-bright : découvrez les pires scandales de la TV que vous aviez probablement oubliés (ou que l\'on a voulu vous faire oublier). Entre manipulations psychologiques, candidats tout sauf innocents, et secrets inavouables, plongez avec nous dans l’Iceberg des Pires Scandales de la TV !', '2026-08-24 07:04:26', '2026-08-24 07:04:26', 2, 1),
(16, 'GTA 30 ans de polémique et de révolution | Rétrosp', 'https://www.youtube.com/embed/_S0ha7yD0j0', 'La série Grand Theft Auto est l’une des séries les plus populaires de l’histoire du jeu vidéo et pourtant elle a commencé avec des jeux qui se sont fait détruire par les journalistes avec des 2/10 dans les magazines et a mis de longues années avant d’être reconnue, mais le plus fascinant avec la série GTA c’est l’histoire incroyable qu’il y a derrière chaque jeu, des britanniques qui font un jeu pour se moquer de l’Amérique que les américains croient être fait par un studio américain, des publicitaires qui orchestrent des polémiques fabriquées de toute pièce pour faire parler des jeux quand ils en ont besoin, des jeux qui font parler d’eux par ce qu’on peut y engager des prostituées  et les abattre, qui choquent et sont bannis dans certains pays dont la France et qui vont friser l’annulation à cause de problèmes juridiques, des dirigeants qui se déchirent dans le secret avec deux frères décrits comme machiavéliques qui piègent le directeur et producteur de la série après presque 20 ans, des employés qu’on encourage à se filmer dans des strip-clubs, et tout ça qui aboutit miraculeusement par des jeux révolutionnaires, voici l’histoire de la série GTA et de ses jeux principaux ou comment deux frères fils d’acteurs britanniques, rêvant de devenir des Rockstar, ont révolutionné le jeu vidéo en se servant des polémiques.', '2026-08-24 07:05:53', '2026-08-24 07:05:53', 3, 0),
(17, 'Pourquoi tout le monde veut de l’Ozempic ? C\'est q', 'https://www.youtube.com/embed/8ajAK_x-xX4', 'Aujourd\'hui on parle de l\'ozempic, ce médicament dont tout le monde parle en ce moment !', '2026-08-24 07:13:22', '2026-08-24 07:19:23', 1, 1),
(18, 'Mon avis sur le mercato du PSG...', 'https://www.youtube.com/embed/z-ZzHpD2Su8', 'Mon avis sur le mercato du PSG...', '2026-08-24 07:21:20', '2026-08-24 07:21:20', 2, 1),
(19, 'L\'armée n\'était pas prête pour Gradur | Small Talk', 'https://www.youtube.com/embed/-VpY2AiYPts', 'Gradur est l\'invité de Small Talk avec David Castello-Lopes.\n\nQue s’est-il passé pour qu’il quitte l\'armée ? Pourquoi dit-il que la réussite est la meilleure des vengeances ? Qu\'a-t-il fait avec son premier gros chèque ? Et pourquoi porte t-il toujours ce bob ?\nDans cet épisode, Gradur revient sur son enfance, ses années dans l\'armée, ses débuts dans le rap, les trahisons qu\'il a traversées, son rapport au succès, à l\'argent, à la famille et à la célébrité. Il raconte aussi comment il a acheté une maison à ses parents, pourquoi il ne boit plus une goutte d\'alcool et ce qu\'il a compris après plus de dix ans de carrière.\n\nUne conversation sincère, drôle et pleine d\'anecdotes avec l\'un des rappeurs les plus populaires de sa génération.\n\nL\'album Décennie de Gradur est dispo sur toutes les plateformes.', '2026-08-24 07:23:43', '2026-08-24 07:23:43', 3, 1),
(20, 'Eden Hazard, Les Confidences du Génie Belge - Zack', 'https://www.youtube.com/embed/WBnj_ObpmJ0', 'Émission du 08.08.2025', '2026-08-24 07:24:37', '2026-08-24 07:24:37', 1, 0),
(21, 'Projet 500 Épisode 3 : On passe la Xantia en souff', 'https://www.youtube.com/embed/9UQu1MkHAIM', 'Un grand merci à W-Autosport pour leur soutien et leur travail exceptionnel, et un pas du tout grand merci à Nelson Racing Engines qui a maintenant 8 mois de retard sur la fourniture du moteur mais tranquille j\'ai pas du tout la mort', '2026-08-24 07:26:11', '2026-08-24 07:26:11', 2, 1),
(22, 'ON TESTE 29 FRUITS BIZARRES (ft. Amixem, Thomas De', 'https://www.youtube.com/embed/AzkXGtDcMT0', 'Merci à Anthony de nous avoir fait découvrir tout ça, le goat des fruits ! @croissyfruits / croissy-fruits.fr\nImmense merci à @Amixem, @ThomasDeseur', '2026-08-24 07:26:57', '2026-08-24 07:26:57', 3, 0),
(23, '10 STREAMERS S\'AFFRONTENT AUX ECHECS ! (ft. Julien', 'https://www.youtube.com/embed/Kec0FzdyWaQ', 'Activez la cloche de notification, afin d\'être au courant de mes prochains lives ou vidéos !', '2026-08-24 07:28:31', '2026-08-24 07:28:31', 1, 1),
(24, 'Les animaux les plus c*ns !', 'https://www.youtube.com/embed/KJLGifYzAQs', 'Quels sont les 5 animaux les plus bêtes ? On découvre ça dans cette vidéo', '2026-08-24 07:30:26', '2026-08-24 07:30:26', 2, 1),
(25, 'Tony Parker et David : les plus gros bousillés de ', 'https://www.youtube.com/embed/STrKlQwAKnA', 'Tony Parker est dans Small Talk avec David Castello-Lopes \n\nLa légende du basketball français s’est prêtée au jeu de David : parler de tout sauf de ce pour quoi il est connu (ou presque). Ses origines multiculturelles (Belgique, France, États-Unis, Pays-Bas — bon, la liste est longue…), sa pire bêtise d’enfance (il se rappelle encore des conséquences), les conseils de sa mère pour qu’il réussisse à pécho, sa carrière de vendeur de fromage, son départ de la maison à 14 ans… Il raconte !', '2026-08-24 07:31:32', '2026-08-24 07:31:32', 3, 0),
(26, 'LEC Summer : l\'entrée en lice du bottom 6 ! (Summe', 'https://www.youtube.com/embed/RCKP4vSDV94', 'LEC SUMMER : l\'entrée en lice du bottom 6 ! (Summer W2)\n\nLa deuxième semaine du summer split du LEC a finalement révélé le niveau des 6 protagonistes manquants de la première semaine. Et une chose est sûre : Karmine Corp semble indétrônable. \n\nLes 8 rencontres de la semaine ont montré des performances en dents de scie des 9 autres équipes européennes, avec des confirmations de certaines tendances, mais aussi certaines surprises, comme la déception des Shifters, équipe préférée de Zaboutine qui ont massivement contre-performé. On revient en détail sur les matchs de la semaine.', '2026-08-24 07:32:32', '2026-08-24 07:32:32', 1, 1),
(27, 'MotoGP™ Full Race | 1996 500cc Spanish GP', 'https://www.youtube.com/embed/Elq0PPSX-cQ', 'A true Grand Prix classic! \n\nLooking back to 1996 and a last lap showdown for the victory in Jerez!', '2026-08-24 07:33:26', '2026-08-24 07:33:26', 2, 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
