-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: cipher
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `credentials`
--

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credentials` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userid`),
  CONSTRAINT `fk_userid` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials`
--

LOCK TABLES `credentials` WRITE;
/*!40000 ALTER TABLE `credentials` DISABLE KEYS */;
INSERT INTO `credentials` VALUES (1,'user1','password1'),(2,'user2','password2'),(3,'user3','password3'),(4,'user4','password4'),(5,'user5','password5'),(6,'user6','password6'),(7,'user7','password7'),(8,'user8','password8'),(9,'user9','password9'),(10,'user10','password10'),(11,'user11','password11');
/*!40000 ALTER TABLE `credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `address` text,
  `pincode` varchar(10) DEFAULT NULL,
  `village` varchar(100) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `married` varchar(10) DEFAULT NULL,
  `phone_number` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `country` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `district` varchar(50) NOT NULL,
  `sex` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'first1','last1','address1','0001','village1','occupation1','No','1234567890','2000-01-01','India','State1','District1','Male'),(2,'first2','last2','address2','0002','village2','occupation2','Yes','1234567891','2000-02-02','India','State2','District2','Female'),(3,'first3','last3','address3','0003','village3','occupation3','No','1234567892','2000-03-03','India','State3','District3','Male'),(4,'first4','last4','address4','0004','village4','occupation4','Yes','1234567893','2000-04-04','India','State4','District4','Female'),(5,'first5','last5','address5','0005','village5','occupation5','No','1234567894','2000-05-05','India','State5','District5','Male'),(6,'first6','last6','address6','0006','village6','occupation6','Yes','1234567895','2000-06-06','India','State6','District6','Female'),(7,'first7','last7','address7','0007','village7','occupation7','No','1234567896','2000-07-07','India','State7','District7','Male'),(8,'first8','last8','address8','0008','village8','occupation8','Yes','1234567897','2000-08-08','India','State8','District8','Female'),(9,'first9','last9','address9','0009','village9','occupation9','No','1234567898','2000-09-09','India','State9','District9','Male'),(10,'first10','last10','address10','0010','village10','occupation10','Yes','1234567899','2000-10-10','India','State10','District10','Female'),(11,'bfnd','ntnt','btrntj','1234','hejetj','ethrtjjr','Yes','1234567891','2024-10-03','India','Karnataka','Mysuru','Female');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-08 22:05:48
