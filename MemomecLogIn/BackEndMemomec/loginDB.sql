-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               5.7.17-log - MySQL Community Server (GPL)
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Exportiere Struktur von Tabelle memomec_users.loginrecord
CREATE TABLE IF NOT EXISTS `loginrecord` (
  `RecordID` int(11) NOT NULL AUTO_INCREMENT,
  `LoginDate` varchar(50) NOT NULL,
  `LoginDuration` varchar(50) NOT NULL DEFAULT '0',
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`RecordID`),
  KEY `userID_fk` (`UserID`),
  CONSTRAINT `userID_fk` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Hold information about login date, duration of the users.';

-- Exportiere Daten aus Tabelle memomec_users.loginrecord: ~3 rows (ungefähr)
/*!40000 ALTER TABLE `loginrecord` DISABLE KEYS */;
INSERT INTO `loginrecord` (`RecordID`, `LoginDate`, `LoginDuration`, `UserID`) VALUES
	(1, '06.10.2021 10:55:49', '00:00:07.6097026', 1),
	(2, '06.10.2021 10:56:03', '00:00:01.7548706', 2),
	(3, '06.10.2021 10:56:13', '00:00:14.6761585', 2);
/*!40000 ALTER TABLE `loginrecord` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle memomec_users.users
CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(10) NOT NULL,
  `Password` varchar(60) NOT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Users of the Memomec';

-- Exportiere Daten aus Tabelle memomec_users.users: ~3 rows (ungefähr)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`UserID`, `Username`, `Password`, `Name`) VALUES
	(1, 'arif', '555', 'arif aksoy'),
	(2, 'test', '444', 'test muster'),
	(3, 'müller', 'abc4', 'müller muster');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
