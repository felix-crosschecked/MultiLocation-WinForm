CREATE DATABASE  IF NOT EXISTS `multilocations8167` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `multilocations8167`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: multilocations8167
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `DateChangement` datetime NOT NULL,
  `ColonneModifie` varchar(250) NOT NULL,
  `AncienneValeur` varchar(250) NOT NULL,
  `NouvelleValeur` varchar(250) NOT NULL,
  `Locations_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Locations_Audits` (`Locations_id`),
  CONSTRAINT `Locations_Audits` FOREIGN KEY (`Locations_id`) REFERENCES `locations` (`IdLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
INSERT INTO `audits` VALUES (1,'2010-05-15 00:00:00','Active','1','0',1),(2,'2019-05-22 00:00:00','Active','1','0',2),(3,'2022-02-11 00:00:00','Termes_Location_id','1','6',6),(4,'2022-02-11 00:00:00','NouveauVehicule','1','0',5),(5,'2022-02-11 00:00:00','Clients_id','1','4',5),(6,'2022-02-14 00:00:00','NombrePaiement','999','24',8),(7,'2022-02-14 00:00:00','NouveauVehicule','1','0',8);
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Prenom` varchar(250) NOT NULL,
  `Nom` varchar(250) NOT NULL,
  `Adresse` varchar(250) NOT NULL,
  `Ville` varchar(250) NOT NULL,
  `Province` varchar(250) NOT NULL,
  `CodePostal` varchar(250) NOT NULL,
  `Telephone` double NOT NULL,
  `NomComplet` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Claudine','Latreille','1000 chemin des Pruches','St-Clinclin','Qc','X1X 1X1',4501234567,'Latreille, Claudine'),(2,'Armand','Guindon','728 rue Vorien','St Benit','Qc','G1X 1H1',4504768276,'Guindon, Armand'),(3,'Pierre','Monfils','248 rue Garneau','Tenaga','Qc','J6C 8B2',8193378219,'Monfils, Pierre'),(4,'Phil','Grenier','7509 rue Beaulieu','Montreal','Qc','J4X 2B7',5149998100,'Grenier, Phil');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `couleurs`
--

DROP TABLE IF EXISTS `couleurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `couleurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Couleur` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Couleurs_ak_1` (`Couleur`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `couleurs`
--

LOCK TABLES `couleurs` WRITE;
/*!40000 ALTER TABLE `couleurs` DISABLE KEYS */;
INSERT INTO `couleurs` VALUES (1,'Bleu foncé'),(5,'Gris argenté'),(3,'Jaune citron'),(2,'Rouge vin'),(4,'Vert lime');
/*!40000 ALTER TABLE `couleurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `IdLocation` int unsigned NOT NULL AUTO_INCREMENT,
  `DateLocation` datetime NOT NULL,
  `DatePremierPaiement` datetime NOT NULL,
  `PaiementMensuel` decimal(5,2) NOT NULL,
  `NombrePaiement` int NOT NULL,
  `NouveauVehicule` tinyint(1) DEFAULT NULL,
  `Clients_id` int NOT NULL,
  `KilometrageInitial` int NOT NULL,
  `KilometrageFinal` int DEFAULT NULL,
  `Véhicules_NIV` varchar(250) NOT NULL,
  `Termes_Location_id` int NOT NULL,
  `Transactions` int DEFAULT '0',
  `Statut_Active` tinyint(1) DEFAULT '1',
  `Statut` int NOT NULL,
  PRIMARY KEY (`IdLocation`),
  UNIQUE KEY `IdLocation_UNIQUE` (`IdLocation`),
  KEY `Clients_Locations` (`Clients_id`),
  KEY `Termes_Location_Locations` (`Termes_Location_id`),
  KEY `Véhicules_Location` (`Véhicules_NIV`),
  CONSTRAINT `Clients_Locations` FOREIGN KEY (`Clients_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `Termes_Location_Locations` FOREIGN KEY (`Termes_Location_id`) REFERENCES `termes` (`id`),
  CONSTRAINT `Véhicules_Location` FOREIGN KEY (`Véhicules_NIV`) REFERENCES `véhicules` (`NIV`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'2009-05-15 00:00:00','2009-05-15 00:00:00',300.00,12,1,1,0,NULL,'Z1221-X129A-KO212-9021J',1,0,1,2),(2,'2017-05-22 00:00:00','2017-05-22 00:00:00',500.00,24,0,2,10000,NULL,'V1292-LI2X1-M21L1-3129S',2,0,1,2),(3,'2018-02-02 00:00:00','2018-02-02 00:00:00',400.00,48,1,3,0,NULL,'Z1221-X129A-KO212-9021J',3,1,1,2),(4,'2019-05-22 00:00:00','2019-05-22 00:00:00',400.00,36,0,2,100000,NULL,'V1292-LI2X1-M21L1-3129S',4,1,1,-1),(5,'2020-11-25 00:00:00','2020-11-25 00:00:00',600.00,36,0,4,0,90000,'M21L1-3129S-V1292-LI2X1',5,1,0,-1),(6,'2022-02-08 00:00:00','2022-02-08 00:00:00',999.00,99,0,4,0,NULL,'Z1221-X129A-KO212-9021J',6,0,1,0),(7,'2022-02-14 00:00:00','2022-02-14 00:00:00',999.00,999,0,4,999,NULL,'Z1221-X129A-KO212-9021J',7,0,1,0),(8,'2022-02-14 00:00:00','2022-02-14 00:00:00',999.00,24,0,4,999,0,'Z1221-X129A-KO212-9021J',8,0,1,-1);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `locations_AFTER_UPDATE` AFTER UPDATE ON `locations` FOR EACH ROW BEGIN
	IF OLD.DateLocation <> new.DateLocation THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "DateLocation", old.DateLocation, new.DateLocation,old.IdLocation);
    END IF;
	IF OLD.DatePremierPaiement <> new.DatePremierPaiement THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "DatePremierPaiement", old.DatePremierPaiement, new.DatePremierPaiement,old.IdLocation);
    END IF;
    IF OLD.PaiementMensuel <> new.PaiementMensuel THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "PaiementMensuel", old.PaiementMensuel, new.PaiementMensuel,old.IdLocation);
    END IF;
	IF OLD.NombrePaiement <> new.NombrePaiement THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "NombrePaiement", old.NombrePaiement, new.NombrePaiement,old.IdLocation);
    END IF;
    IF OLD.NouveauVehicule <> new.NouveauVehicule THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "NouveauVehicule", old.NouveauVehicule, new.NouveauVehicule,old.IdLocation);
    END IF;
	IF OLD.Clients_id <> new.Clients_id THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "Clients_id", old.Clients_id, new.Clients_id,old.IdLocation);
    END IF;
    IF OLD.KilometrageInitial <> new.KilometrageInitial THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "KilometrageInitial", old.KilometrageInitial, new.KilometrageInitial,old.IdLocation);
    END IF;
	IF OLD.KilometrageFinal <> new.KilometrageFinal THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "KilometrageFinal", old.KilometrageFinal, new.KilometrageFinal,old.IdLocation);
    END IF;
    IF OLD.Véhicules_NIV <> new.Véhicules_NIV THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "Véhicules_NIV", old.Véhicules_NIV, new.Véhicules_NIV,old.IdLocation);
    END IF;
	IF OLD.Termes_Location_id <> new.Termes_Location_id THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "Termes_Location_id", old.Termes_Location_id, new.Termes_Location_id,old.IdLocation);
    END IF;
    IF OLD.Transactions <> new.Transactions THEN
        INSERT INTO audits(DateChangement,ColonneModifie,AncienneValeur,NouvelleValeur,Locations_id)
        VALUES(current_date(), "Transactions", old.Transactions, new.Transactions,old.IdLocation);
    END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `locations_view`
--

DROP TABLE IF EXISTS `locations_view`;
/*!50001 DROP VIEW IF EXISTS `locations_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `locations_view` AS SELECT 
 1 AS `Prenom`,
 1 AS `Nom`,
 1 AS `Telephone`,
 1 AS `Véhicule_NIV`,
 1 AS `Modele_id`,
 1 AS `Véhicule_Annee`,
 1 AS `id_Paiement`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `modeles`
--

DROP TABLE IF EXISTS `modeles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modeles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Modele` varchar(250) NOT NULL,
  PRIMARY KEY (`id`,`Modele`),
  KEY `Modeles_FK` (`Modele`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modeles`
--

LOCK TABLES `modeles` WRITE;
/*!40000 ALTER TABLE `modeles` DISABLE KEYS */;
INSERT INTO `modeles` VALUES (3,'BMW'),(5,'Honda'),(2,'Mazda'),(4,'Subaru'),(1,'Toyota');
/*!40000 ALTER TABLE `modeles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paiements`
--

DROP TABLE IF EXISTS `paiements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paiements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Montant` decimal(5,2) NOT NULL,
  `Locations_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Locations_Paiements` (`Locations_id`),
  CONSTRAINT `Locations_Paiements` FOREIGN KEY (`Locations_id`) REFERENCES `locations` (`IdLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paiements`
--

LOCK TABLES `paiements` WRITE;
/*!40000 ALTER TABLE `paiements` DISABLE KEYS */;
INSERT INTO `paiements` VALUES (1,'2009-05-15',300.00,1),(2,'2017-05-22',500.00,2),(3,'2018-02-02',400.00,3),(4,'2019-05-22',400.00,4),(5,'2020-11-25',600.00,5),(6,'2020-12-25',600.00,5),(7,'2021-12-12',555.00,1),(8,'2021-12-12',555.00,1);
/*!40000 ALTER TABLE `paiements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `termes`
--

DROP TABLE IF EXISTS `termes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `termes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `NombreAnnees` int NOT NULL,
  `KilometrageMax` int NOT NULL,
  `TauxSurprime` decimal(5,2) NOT NULL COMMENT '($ / Km) ex. : 0.20',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `termes`
--

LOCK TABLES `termes` WRITE;
/*!40000 ALTER TABLE `termes` DISABLE KEYS */;
INSERT INTO `termes` VALUES (1,1,15000,0.35),(2,2,100000,0.25),(3,4,200000,0.50),(4,3,170000,0.20),(5,3,150000,0.15),(6,3,100000,0.40),(7,9,9,0.35),(8,99,99,0.55);
/*!40000 ALTER TABLE `termes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transmissions`
--

DROP TABLE IF EXISTS `transmissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transmissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Transmission` varchar(250) NOT NULL,
  PRIMARY KEY (`id`,`Transmission`),
  KEY `Transmission_FK` (`Transmission`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transmissions`
--

LOCK TABLES `transmissions` WRITE;
/*!40000 ALTER TABLE `transmissions` DISABLE KEYS */;
INSERT INTO `transmissions` VALUES (1,'Automatique'),(2,'Mannuelle');
/*!40000 ALTER TABLE `transmissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(250) NOT NULL,
  PRIMARY KEY (`id`,`Type`),
  KEY `'Types_FK'` (`Type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (3,'Camion'),(1,'Coupé 2 portes'),(2,'Sedan 4 portes'),(5,'Van'),(4,'VUS');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilisateurs` (
  `id_utilisateur` varchar(50) NOT NULL,
  `Password` varchar(12) DEFAULT NULL,
  `Prenom` varchar(45) DEFAULT NULL,
  `Nom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `idutilisateurs_UNIQUE` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateurs`
--

LOCK TABLES `utilisateurs` WRITE;
/*!40000 ALTER TABLE `utilisateurs` DISABLE KEYS */;
INSERT INTO `utilisateurs` VALUES ('admin','pass','Felix','Gagnon');
/*!40000 ALTER TABLE `utilisateurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `véhicules`
--

DROP TABLE IF EXISTS `véhicules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `véhicules` (
  `NIV` varchar(250) NOT NULL,
  `Annee` year NOT NULL,
  `Valeur` double NOT NULL,
  `Couleurs_Couleur` int NOT NULL,
  `Modeles_id` int NOT NULL,
  `Types_id` int NOT NULL,
  `Transmissions_id` int NOT NULL,
  `Disponible` tinyint(1) DEFAULT NULL,
  `AirClimatise` tinyint(1) DEFAULT NULL,
  `AntiDemarreur` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`NIV`),
  KEY `Couleurs_Véhicules` (`Couleurs_Couleur`),
  KEY `Modeles_FK` (`Modeles_id`),
  KEY `Transmissions_FK` (`Transmissions_id`),
  KEY `Types_FK` (`Types_id`),
  CONSTRAINT `Couleurs_Véhicules` FOREIGN KEY (`Couleurs_Couleur`) REFERENCES `couleurs` (`id`),
  CONSTRAINT `Modeles_FK` FOREIGN KEY (`Modeles_id`) REFERENCES `modeles` (`id`),
  CONSTRAINT `Transmissions_FK` FOREIGN KEY (`Transmissions_id`) REFERENCES `transmissions` (`id`),
  CONSTRAINT `Types_FK` FOREIGN KEY (`Types_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `véhicules`
--

LOCK TABLES `véhicules` WRITE;
/*!40000 ALTER TABLE `véhicules` DISABLE KEYS */;
INSERT INTO `véhicules` VALUES ('A1221-X129A-KO212-9021J',2022,199000,3,2,2,1,0,1,1),('K219M-K129P-V12BP-210G4',2018,45000,1,1,1,1,1,1,1),('M21L1-3129S-V1292-LI2X1',2020,75000,2,5,5,2,1,1,0),('V1292-LI2X1-M21L1-3129S',2016,39000,4,3,2,2,0,1,1),('Z1221-X129A-KO212-9021J',2009,60000,4,4,1,1,0,0,0);
/*!40000 ALTER TABLE `véhicules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'multilocations8167'
--

--
-- Dumping routines for database 'multilocations8167'
--
/*!50003 DROP PROCEDURE IF EXISTS `new_paiement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_paiement`(IN paiement_date date, IN paiement_montant decimal(5,2), IN paiement_location_id int)
BEGIN
INSERT INTO `multilocations8167`.`paiements` (`Date`, `Montant`, `Locations_id`) VALUES (paiement_date, paiement_montant, paiement_location_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_InsertLocation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertLocation`(IN p_IdLocation int, IN p_DateLocation date, IN p_DatePremierPaiement date, IN p_PaiementMensuel decimal(5,2),  IN p_NombrePaiement int,  IN p_NouveauVehicule tinyint(1),  IN p_Clients_id int,  IN p_KilometrageInitial int,  IN p_KilometrageFinal int,  IN p_Véhicules_NIV varchar(250),  IN p_Termes_Location_id int,    IN p_Statut int, IN p_NombreAnnees int, IN p_KilometrageMax int, IN p_TauxSurprime decimal(5,2))
BEGIN
INSERT INTO `multilocations8167`.`termes` (`id`, `NombreAnnees`, `KilometrageMax`, `TauxSurprime`) VALUES (p_Termes_Location_id, p_NombreAnnees, p_KilometrageMax, p_TauxSurprime);
INSERT INTO `multilocations8167`.`locations` (`IdLocation`, `DateLocation`, `DatePremierPaiement`, `PaiementMensuel`, `NombrePaiement`, `NouveauVehicule`, `Clients_id`, `KilometrageInitial`, `KilometrageFinal`, `Véhicules_NIV`, `Termes_Location_id`, `Statut`) VALUES (p_IdLocation, p_DateLocation, p_DatePremierPaiement, p_PaiementMensuel, p_NombrePaiement, p_NouveauVehicule, p_Clients_id, p_KilometrageInitial, p_KilometrageFinal, p_Véhicules_NIV, p_Termes_Location_id, p_Statut);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SelectClients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SelectClients`()
BEGIN
select * From clients;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SelectLocation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SelectLocation`()
BEGIN
select * From locations;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SelectPaiements` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SelectPaiements`()
BEGIN
select * From paiements;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SelectTermes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SelectTermes`()
BEGIN
select * From termes;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SelectVehicules` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SelectVehicules`()
BEGIN
select * From véhicules;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateLocation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateLocation`(IN p_IdLocation int, IN p_DateLocation date, IN p_DatePremierPaiement date, IN p_PaiementMensuel decimal(5,2),  IN p_NombrePaiement int,  IN p_NouveauVehicule tinyint(1),  IN p_Clients_id int,  IN p_KilometrageInitial int,  IN p_KilometrageFinal int,  IN p_Véhicules_NIV varchar(250),  IN p_Termes_Location_id int,    IN p_Statut int, IN p_NombreAnnees int, IN p_KilometrageMax int, IN p_TauxSurprime decimal(5,2))
BEGIN
update termes
SET
NombreAnnees = p_NombreAnnees,
KilometrageMax = p_KilometrageMax,
TauxSurprime = p_TauxSurprime
where id = p_IdLocation;

update locations 
SET 
DateLocation = p_DateLocation,
DatePremierPaiement = DatePremierPaiement,
PaiementMensuel = p_PaiementMensuel,
NombrePaiement = p_NombrePaiement,
NouveauVehicule = p_NouveauVehicule,
Clients_id = p_Clients_id,
KilometrageInitial = p_KilometrageInitial,
KilometrageFinal = p_KilometrageFinal,
Véhicules_NIV = p_Véhicules_NIV,
Termes_Location_id = p_Termes_Location_id, 
Statut = p_Statut
where IdLocation = p_IdLocation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `locations_view`
--

/*!50001 DROP VIEW IF EXISTS `locations_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `locations_view` AS select `clients`.`Prenom` AS `Prenom`,`clients`.`Nom` AS `Nom`,`clients`.`Telephone` AS `Telephone`,`locations`.`Véhicules_NIV` AS `Véhicule_NIV`,`véhicules`.`Modeles_id` AS `Modele_id`,`véhicules`.`Annee` AS `Véhicule_Annee`,`paiements`.`id` AS `id_Paiement` from (((`locations` join `clients`) join `véhicules`) join `paiements`) where ((`locations`.`Clients_id` = `clients`.`id`) and (`locations`.`Véhicules_NIV` = `véhicules`.`NIV`) and (`locations`.`IdLocation` = `paiements`.`Locations_id`)) */;
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

-- Dump completed on 2022-02-14 10:49:11
