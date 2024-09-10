-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: room_911
-- ------------------------------------------------------
-- Server version	8.4.0

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
-- Table structure for table `access_attempts`
--

DROP TABLE IF EXISTS `access_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_attempts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `was_successful` tinyint(1) NOT NULL,
  `attempted_at` timestamp NOT NULL,
  `ip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_attempts`
--

LOCK TABLES `access_attempts` WRITE;
/*!40000 ALTER TABLE `access_attempts` DISABLE KEYS */;
INSERT INTO `access_attempts` VALUES (28,1,'2024-09-10 10:58:41','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(29,1,'2024-09-10 11:01:20','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(30,0,'2024-09-10 11:02:24','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(31,0,'2024-09-10 11:02:28','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(32,0,'2024-09-10 11:02:28','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(33,0,'2024-09-10 11:02:28','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(34,0,'2024-09-10 11:02:28','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(35,0,'2024-09-10 11:02:28','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(36,0,'2024-09-10 11:02:28','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(37,0,'2024-09-10 11:02:29','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(38,0,'2024-09-10 11:02:29','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(39,0,'2024-09-10 11:02:29','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(40,0,'2024-09-10 11:02:29','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(41,0,'2024-09-10 11:02:29','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(42,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(43,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(44,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(45,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(46,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(47,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(48,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(49,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(50,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(51,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(52,1,'2024-09-10 11:02:42','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(53,1,'2024-09-10 11:02:43','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(54,1,'2024-09-10 11:02:43','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(55,1,'2024-09-10 11:02:43','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(56,1,'2024-09-10 11:02:43','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(57,1,'2024-09-10 11:02:43','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(58,1,'2024-09-10 11:02:43','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(59,1,'2024-09-10 11:02:43','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(60,1,'2024-09-10 18:51:44','::1','09B4F3C41A8E4E369847DA09445C7FC9'),(61,0,'2024-09-10 18:51:59','::1','09B4F3C41A8E4E369847DA09445C7FC9');
/*!40000 ALTER TABLE `access_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('admin@example.com|127.0.0.1','i:1;',1725643481),('admin@example.com|127.0.0.1:timer','i:1725643481;',1725643481),('admin|::1','i:1;',1725919526),('admin|::1:timer','i:1725919526;',1725919526);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Research'),(2,'Production'),(3,'Security'),(4,'Laboratory');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_access` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employees_employee_id_unique` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=358 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (332,'sadasdas','sadasdas','D09769D47F6E4E42B635CE32E7841323','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(333,'sadasdas','sadasdas','460BA1AFB9734F719B8483F11078EE56','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(334,'sadasdas','sadasdas','C6A09E535C9349CE9FF2E433732047DE','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(335,'sadasdas','sadasdas','09B4F3C41A8E4E369847DA09445C7FC9','3',0,'2024-09-10 10:51:50','2024-09-10 18:51:52'),(337,'sadasdas','sadasdas','5298CC86AF304027970E607A6DF8D8D0','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(339,'asasasa','asasasa','8C8258F63C214C8BBF4F5B3955DFBA28','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(340,'sadasdas','sadasdas','C98C797582254878991769ED39E64621','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(341,'sadasdas','sadasdas','57A417E0EE7B4A9689B4117F606DC32E','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(342,'sadasdas','sadasdas','7D208EC456B249B9B1F4964B33F129CA','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(343,'sadasdas','sadasdas','8FDDA1073B744E89AD59F680BF2C2B76','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(344,'sadasdas','sadasdas','D3BB9F404478454DA39933E77893F7E9','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(345,'sadasdas','sadasdas','D4CC7E738CF3418E8C0F9F59A390914D','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(346,'sadasdas','sadasdas','EC7DAE24D5854F12A76F90048ED92912','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(347,'sadasdas','sadasdas','480400CFCF534E4AB44673AE21D4EF49','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(348,'asasasa','asasasa','14C7314E787C489380DA19A0903EECC3','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(349,'sadasdas','sadasdas','BE45BCA5B6514AD695195D75A90B2EB1','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(351,'sadasdas','sadasdas','5A5944B4D45F41939D5E3D1981A71DA3','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(352,'sadasdas','sadasdas','70EA3FCA8DA94BEA8AF32953FFA39FDA','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(353,'sadasdas','sadasdas','32397DD7DBEE409DB357492A2AB9003F','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(354,'sadasdas','sadasdas','30C72D9B810A45B48151B412C013F7A4','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(355,'sadasdas','sadasdas','3FE3F46DBD8E4751993F88FA08DBB4C8','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(356,'sadasdas','sadasdas','E7E13722E96D466780CD61271229FC4C','3',1,'2024-09-10 10:51:50','2024-09-10 10:51:50'),(357,'asasasa','asasasa','E46AE031C6034379B146B631FD3DA543','3',0,'2024-09-10 10:51:50','2024-09-10 10:51:50');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2024_09_05_041503_create_employees_table',1),(5,'2024_09_05_041533_create_access_attempts_table',1),(6,'2024_09_05_041538_create_admin_room_911_table',1),(7,'2024_09_06_222339_add_type_user',2),(8,'2024_09_06_232900_employees',3),(9,'2024_09_06_232909_history_access',3),(10,'2024_09_07_011030_add_employees_id',4),(11,'2024_09_07_012803_add_employees_id_no_read_only',5),(12,'2024_09_07_013804_add_employees_id',6),(13,'2024_09_07_013915_add_employees_ids',7),(14,'2024_09_07_014105_add_employees_id_end',8),(15,'2024_09_07_014143_add_employees_id',9),(16,'2024_09_07_033334_new_table_employees',10),(17,'2024_09_07_033345_new_table_access_attempts',10),(18,'2024_09_07_060306_new_table_departments',11);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('1kJGmbMAAZMoeL8dRk0GS2gJ20gmE3xPPVsfDoZT',NULL,'192.168.1.3','Avast Antivirus','YTozOntzOjY6Il90b2tlbiI7czo0MDoiN0NpYkg2RkdIRUJKcmdBTWFLc0Iwa01oRzA0bjJITHFiRnJlYW50NyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTg6Imh0dHA6Ly8xOTIuMTY4LjEuMyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1725977025),('G2yHfAlRBzCPOdogYN1RxjH7ZC8KsLFJDoEeRiSc',NULL,'192.168.1.3','','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUmRtS1VydTNrb0tUMldpUUxwaWtWZDRHczN1SlVNNEV0ZGhRSXRERSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTg6Imh0dHA6Ly8xOTIuMTY4LjEuMyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1725977028),('PvjHrW7hr33hXp8aRKhsPvqqspetpb6995y85Vqy',NULL,'192.168.1.3','Avast Antivirus','YTozOntzOjY6Il90b2tlbiI7czo0MDoiS1l2TGxIelBuNldOQmtPdk42b2pFMGlqMU93Zk1aSWVlcENRUncxRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xOTIuMTY4LjEuMy92ZXJpZnktdXNlciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1725977025),('RINgMqPiuE2gFbukiTt5amtsR3RKXPaFMVMJQSfj',1,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 Edg/128.0.0.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZGtkVTJpeFFjWGgyY3JlVVJRZ3RtUEZaU0dsaDk1SE9Gc0VMMTNIWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9sb2NhbGhvc3QvZ2V0LWVtcGxveWVlcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzI1OTc2MTQzO319',1725983081),('ZjBEz70ovg3EXus4YR8jqNdxqWBCKxJNMfAq1uhz',NULL,'192.168.1.3','Avast Antivirus','YTozOntzOjY6Il90b2tlbiI7czo0MDoieHV2V2Nzd2JNN01WWWlVTklaOFFORm5FdTgzbEt6MU1rc0Y5U0MyMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjEuMy9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1725977025);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type_user` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin_room_911',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'SuperAdmin','admin@pharmacy.com',NULL,'$2y$12$NTGPxKqW/FgAMQHn0JqZB.ykSTSo35D3IqOU5entw6gII/P5kNO.G',NULL,'2024-09-09 05:00:00',NULL,'admin_room_911');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'room_911'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-10 11:18:30
