-- MariaDB dump 10.17  Distrib 10.4.14-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: auftrag
-- ------------------------------------------------------
-- Server version	10.4.14-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `artikel`
--

DROP TABLE IF EXISTS `artikel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artikel` (
  `artikelnr` int(11) NOT NULL,
  `beschreibung` char(30) DEFAULT NULL,
  `preis` decimal(6,2) DEFAULT NULL,
  `bestand` int(5) DEFAULT NULL,
  PRIMARY KEY (`artikelnr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artikel`
--

LOCK TABLES `artikel` WRITE;
/*!40000 ALTER TABLE `artikel` DISABLE KEYS */;
INSERT INTO `artikel` VALUES (1,'Tasse',12.99,250),(2,'Handtuch',3.50,847),(3,'Zucker',0.99,1050),(4,'Tee',1.99,278),(5,'Decke',19.99,280),(6,'Kaffee',4.99,1);
/*!40000 ALTER TABLE `artikel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bestellung`
--

DROP TABLE IF EXISTS `bestellung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestellung` (
  `rechnungsnr` int(11) NOT NULL,
  `kundennr` int(11) NOT NULL,
  `datum` date DEFAULT NULL,
  PRIMARY KEY (`rechnungsnr`),
  KEY `kundennr` (`kundennr`),
  CONSTRAINT `bestellung_ibfk_1` FOREIGN KEY (`kundennr`) REFERENCES `kunde` (`kundennr`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestellung`
--

LOCK TABLES `bestellung` WRITE;
/*!40000 ALTER TABLE `bestellung` DISABLE KEYS */;
INSERT INTO `bestellung` VALUES (1,1,'2005-11-02'),(2,4,'2005-11-03'),(3,3,'2005-11-04'),(4,1,'2005-11-08'),(5,6,'2016-12-01'),(7,2,'2016-12-02');
/*!40000 ALTER TABLE `bestellung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kunde`
--

DROP TABLE IF EXISTS `kunde`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kunde` (
  `kundennr` int(11) NOT NULL,
  `vorname` char(20) DEFAULT NULL,
  `zuname` char(20) DEFAULT NULL,
  `strasse` char(30) DEFAULT NULL,
  `plz` char(5) DEFAULT NULL,
  `ort` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kundennr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunde`
--

LOCK TABLES `kunde` WRITE;
/*!40000 ALTER TABLE `kunde` DISABLE KEYS */;
INSERT INTO `kunde` VALUES (1,'Maik','Liemann','Wiesenweg 12','45468','Nirgendwo'),(2,'Maik','Lumle','Klottschen 54','45468','Nirgendwo'),(3,'Maik','Luml','Klottschen 54','45468','Nirgendwo'),(4,'Maik','Lum','Klottschen 54','45468','Nirgendwo'),(5,'Maik','Lu','Klottschen 54','45468','Nirgendwo'),(6,'Maik','L','Klottschen 54','45468','Nirgendwo');
/*!40000 ALTER TABLE `kunde` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posten`
--

DROP TABLE IF EXISTS `posten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posten` (
  `rechnungsnr` int(11) NOT NULL,
  `artikelnr` int(11) NOT NULL,
  `menge` int(11) DEFAULT 0,
  PRIMARY KEY (`rechnungsnr`,`artikelnr`),
  KEY `rechnungsnr` (`rechnungsnr`),
  KEY `artikelnr` (`artikelnr`),
  CONSTRAINT `posten_ibfk_1` FOREIGN KEY (`rechnungsnr`) REFERENCES `bestellung` (`rechnungsnr`) ON UPDATE CASCADE,
  CONSTRAINT `posten_ibfk_2` FOREIGN KEY (`artikelnr`) REFERENCES `artikel` (`artikelnr`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posten`
--

LOCK TABLES `posten` WRITE;
/*!40000 ALTER TABLE `posten` DISABLE KEYS */;
INSERT INTO `posten` VALUES (1,2,1),(1,6,3),(5,6,7);
/*!40000 ALTER TABLE `posten` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger anzahl before insert on posten for each row set new.menge=1 */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger anzahl2 before update on posten for each row begin
 set new.menge=old.menge+1;
 update artikel set bestand=bestand-1 where artikelnr=old.artikelnr;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v1`
--

DROP TABLE IF EXISTS `v1`;
/*!50001 DROP VIEW IF EXISTS `v1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v1` (
  `artikelnr` tinyint NOT NULL,
  `beschreibung` tinyint NOT NULL,
  `preis` tinyint NOT NULL,
  `bestand` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v1`
--

/*!50001 DROP TABLE IF EXISTS `v1`*/;
/*!50001 DROP VIEW IF EXISTS `v1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v1` AS select `artikel`.`artikelnr` AS `artikelnr`,`artikel`.`beschreibung` AS `beschreibung`,`artikel`.`preis` AS `preis`,`artikel`.`bestand` AS `bestand` from `artikel` where `artikel`.`bestand` > 100 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-19 10:42:57
