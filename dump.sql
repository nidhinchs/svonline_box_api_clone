/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(10) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `categories` VALUES (10,'Internet Of Thing'),(44,'Machine Learning'),(46,'Cloud'),(50,'Big data');
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `project_id` int(10) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(50) NOT NULL,
  `project_cat` varchar(50) NOT NULL,
  `project_startdate` date NOT NULL,
  `project_enddate` date NOT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `project` VALUES (8,'Smart City','IOT','2020-07-25','2020-08-01'),(9,'Smart Village','IOT','2020-07-24','2020-07-30'),(10,'Face Recognization','Machine Learning','2020-07-31','2020-08-08'),(11,'Face Recognization','Machine Learning','2020-07-31','2020-08-08'),(12,'Pattern Finding','Machine Learning','2020-07-24','2020-08-01'),(13,'Smart Car','Internet Of Things','2020-08-01','2020-08-07'),(16,'Pattern recognization','Big data','2020-07-25','2020-07-30');
