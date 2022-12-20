-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: mall
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `t1`
--

DROP TABLE IF EXISTS `t1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t1` (
  `c1` int NOT NULL AUTO_INCREMENT,
  `c2` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `c3` char(5) COLLATE utf8mb3_bin NOT NULL,
  `c4` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`c2`),
  UNIQUE KEY `c1` (`c1`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t1`
--

LOCK TABLES `t1` WRITE;
/*!40000 ALTER TABLE `t1` DISABLE KEYS */;
INSERT INTO `t1` VALUES (1,'t1','aaaaa','2022-12-19 17:10:47');
/*!40000 ALTER TABLE `t1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_admin_info`
--

DROP TABLE IF EXISTS `t_admin_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_admin_info` (
  `ai_idx` int NOT NULL AUTO_INCREMENT,
  `ai_id` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `ai_qw` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `ai_name` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `ai_use` char(1) COLLATE utf8mb3_bin DEFAULT 'y',
  `ai_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ai_id`),
  UNIQUE KEY `ai_idx` (`ai_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_admin_info`
--

LOCK TABLES `t_admin_info` WRITE;
/*!40000 ALTER TABLE `t_admin_info` DISABLE KEYS */;
INSERT INTO `t_admin_info` VALUES (1,'admin','1111','관리자','y','2022-12-14 11:37:01');
/*!40000 ALTER TABLE `t_admin_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_free`
--

DROP TABLE IF EXISTS `t_bbs_free`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_free` (
  `bf_idx` int NOT NULL,
  `bf_ismem` char(1) COLLATE utf8mb3_bin DEFAULT 'y',
  `bf_writer` char(20) COLLATE utf8mb3_bin NOT NULL,
  `bf_pw` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `bf_header` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `bf_title` varchar(100) COLLATE utf8mb3_bin DEFAULT NULL,
  `bf_content` text COLLATE utf8mb3_bin NOT NULL,
  `bf_reply` int DEFAULT '0',
  `bf_read` int DEFAULT '0',
  `bf_ip` varchar(15) COLLATE utf8mb3_bin NOT NULL,
  `bf_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `bf_isdel` char(1) COLLATE utf8mb3_bin DEFAULT 'y',
  PRIMARY KEY (`bf_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_free`
--

LOCK TABLES `t_bbs_free` WRITE;
/*!40000 ALTER TABLE `t_bbs_free` DISABLE KEYS */;
INSERT INTO `t_bbs_free` VALUES (1,'y','test1','','스포츠','월드컵 16강 탈락','짜증나!!',1,0,'127.0.0.1','2022-12-15 18:31:06','y');
/*!40000 ALTER TABLE `t_bbs_free` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_free_reply`
--

DROP TABLE IF EXISTS `t_bbs_free_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_free_reply` (
  `bfr_idx` int NOT NULL AUTO_INCREMENT,
  `bf_idx` int DEFAULT NULL,
  `bfr_ismem` char(1) COLLATE utf8mb3_bin DEFAULT 'y',
  `bfr_writer` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `bfr_pw` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `bfr_content` varchar(200) COLLATE utf8mb3_bin DEFAULT NULL,
  `bfr_good` int DEFAULT '0',
  `bfr_bad` int DEFAULT '0',
  `bfr_ip` varchar(15) COLLATE utf8mb3_bin NOT NULL,
  `bfr_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `bfr_isdel` char(1) COLLATE utf8mb3_bin DEFAULT 'n',
  PRIMARY KEY (`bfr_idx`),
  KEY `fk_bbs_free_reply_bf_idx` (`bf_idx`),
  CONSTRAINT `fk_bbs_free_reply_bf_idx` FOREIGN KEY (`bf_idx`) REFERENCES `t_bbs_free` (`bf_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_free_reply`
--

LOCK TABLES `t_bbs_free_reply` WRITE;
/*!40000 ALTER TABLE `t_bbs_free_reply` DISABLE KEYS */;
INSERT INTO `t_bbs_free_reply` VALUES (7,1,'y','test2','','댓글입니다',0,0,'127.0.0.1','2022-12-16 10:54:39','y'),(8,1,'n','ㅇㅇ','1111','댓글2',0,0,'127.0.0.1','2022-12-16 10:54:41','n');
/*!40000 ALTER TABLE `t_bbs_free_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_free_reply_112`
--

DROP TABLE IF EXISTS `t_bbs_free_reply_112`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_free_reply_112` (
  `fr1_idx` int NOT NULL AUTO_INCREMENT,
  `mi_id` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `bfr_idx` int NOT NULL,
  `fr1_content` varchar(200) COLLATE utf8mb3_bin NOT NULL,
  `fr1_ip` varchar(15) COLLATE utf8mb3_bin NOT NULL,
  `fr1_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mi_id`,`bfr_idx`),
  UNIQUE KEY `fr1_idx` (`fr1_idx`),
  KEY `fk_bbs_free_reply_112_bfr_idx` (`bfr_idx`),
  CONSTRAINT `fk_bbs_free_reply_112_bfr_idx` FOREIGN KEY (`bfr_idx`) REFERENCES `t_bbs_free_reply` (`bfr_idx`),
  CONSTRAINT `fk_bbs_free_reply_112_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_free_reply_112`
--

LOCK TABLES `t_bbs_free_reply_112` WRITE;
/*!40000 ALTER TABLE `t_bbs_free_reply_112` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_bbs_free_reply_112` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_free_reply_gnb`
--

DROP TABLE IF EXISTS `t_bbs_free_reply_gnb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_free_reply_gnb` (
  `frg_idx` int NOT NULL AUTO_INCREMENT,
  `mi_id` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `bfr_idx` int NOT NULL,
  `frg_gnb` char(1) COLLATE utf8mb3_bin DEFAULT 'g',
  `frg_ip` varchar(15) COLLATE utf8mb3_bin NOT NULL,
  `frg_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mi_id`,`bfr_idx`),
  UNIQUE KEY `frg_idx` (`frg_idx`),
  KEY `fk_bbs_free_reply_gnb_bfr_idx` (`bfr_idx`),
  CONSTRAINT `fk_bbs_free_reply_gnb_bfr_idx` FOREIGN KEY (`bfr_idx`) REFERENCES `t_bbs_free_reply` (`bfr_idx`),
  CONSTRAINT `fk_bbs_free_reply_gnb_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_free_reply_gnb`
--

LOCK TABLES `t_bbs_free_reply_gnb` WRITE;
/*!40000 ALTER TABLE `t_bbs_free_reply_gnb` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_bbs_free_reply_gnb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_notice`
--

DROP TABLE IF EXISTS `t_bbs_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_notice` (
  `bn_idx` int NOT NULL,
  `bn_ctgr` varchar(10) COLLATE utf8mb3_bin NOT NULL,
  `ai_idx` int DEFAULT NULL,
  `bn_title` varchar(100) COLLATE utf8mb3_bin NOT NULL,
  `bn_content` text COLLATE utf8mb3_bin NOT NULL,
  `bn_read` int DEFAULT '0',
  `bn_isview` char(1) COLLATE utf8mb3_bin DEFAULT 'n',
  `bn_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bn_idx`),
  KEY `fk_bbs_notice_ai_idx` (`ai_idx`),
  CONSTRAINT `fk_bbs_notice_ai_idx` FOREIGN KEY (`ai_idx`) REFERENCES `t_admin_info` (`ai_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_notice`
--

LOCK TABLES `t_bbs_notice` WRITE;
/*!40000 ALTER TABLE `t_bbs_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_bbs_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_qna`
--

DROP TABLE IF EXISTS `t_bbs_qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_qna` (
  `bq_idx` int NOT NULL,
  `mi_id` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `bq_ctgr` char(1) COLLATE utf8mb3_bin DEFAULT 'a',
  `bq_title` varchar(100) COLLATE utf8mb3_bin NOT NULL,
  `bq_content` text COLLATE utf8mb3_bin NOT NULL,
  `bq_img1` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `bq_img2` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `bq_ip` varchar(15) COLLATE utf8mb3_bin NOT NULL,
  `bq_qdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `bq_isanswer` char(1) COLLATE utf8mb3_bin DEFAULT 'n',
  `bq_ai_idx` int DEFAULT '0',
  `bq_answer` text COLLATE utf8mb3_bin,
  `bq_satis` char(1) COLLATE utf8mb3_bin DEFAULT 'z',
  `bq_adate` datetime DEFAULT NULL,
  `bq_isview` char(1) COLLATE utf8mb3_bin DEFAULT 'y',
  PRIMARY KEY (`bq_idx`),
  KEY `fk_bbs_qna_mi_id` (`mi_id`),
  CONSTRAINT `fk_bbs_qna_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_qna`
--

LOCK TABLES `t_bbs_qna` WRITE;
/*!40000 ALTER TABLE `t_bbs_qna` DISABLE KEYS */;
INSERT INTO `t_bbs_qna` VALUES (1,'test1','b','질문 2','내용입니다2.',NULL,NULL,'127.0.0.1','2022-12-15 17:01:16','y',1,'답변입니다.','c','2022-12-15 17:04:33','y');
/*!40000 ALTER TABLE `t_bbs_qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_review`
--

DROP TABLE IF EXISTS `t_bbs_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_review` (
  `br_idx` int DEFAULT NULL,
  `mi_id` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `oi_id` char(12) COLLATE utf8mb3_bin NOT NULL,
  `pi_id` char(7) COLLATE utf8mb3_bin NOT NULL,
  `ps_idx` int NOT NULL,
  `br_name` varchar(100) COLLATE utf8mb3_bin NOT NULL,
  `br_title` varchar(100) COLLATE utf8mb3_bin NOT NULL,
  `br_content` text COLLATE utf8mb3_bin NOT NULL,
  `br_reply` int DEFAULT '0',
  `br_img` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `br_score` float DEFAULT '0',
  `br_good` int DEFAULT '0',
  `br_bad` int DEFAULT '0',
  `br_read` int DEFAULT '0',
  `br_ip` varchar(15) COLLATE utf8mb3_bin NOT NULL,
  `br_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `br_isdel` char(1) COLLATE utf8mb3_bin DEFAULT 'n',
  PRIMARY KEY (`mi_id`,`oi_id`,`pi_id`,`ps_idx`),
  UNIQUE KEY `br_idx` (`br_idx`),
  KEY `fk_bbs_review_oi_id` (`oi_id`),
  KEY `fk_bbs_review_pi_id` (`pi_id`),
  KEY `fk_bbs_review_ps_idx` (`ps_idx`),
  CONSTRAINT `fk_bbs_review_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`),
  CONSTRAINT `fk_bbs_review_oi_id` FOREIGN KEY (`oi_id`) REFERENCES `t_order_info` (`oi_id`),
  CONSTRAINT `fk_bbs_review_pi_id` FOREIGN KEY (`pi_id`) REFERENCES `t_product_info` (`pi_id`),
  CONSTRAINT `fk_bbs_review_ps_idx` FOREIGN KEY (`ps_idx`) REFERENCES `t_product_stock` (`ps_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_review`
--

LOCK TABLES `t_bbs_review` WRITE;
/*!40000 ALTER TABLE `t_bbs_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_bbs_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_review_gnb`
--

DROP TABLE IF EXISTS `t_bbs_review_gnb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_review_gnb` (
  `brg_idx` int NOT NULL AUTO_INCREMENT,
  `mi_id` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `br_idx` int NOT NULL,
  `brg_gnb` char(1) COLLATE utf8mb3_bin DEFAULT 'g',
  `brg_ip` varchar(15) COLLATE utf8mb3_bin NOT NULL,
  `brg_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mi_id`,`br_idx`),
  UNIQUE KEY `brg_idx` (`brg_idx`),
  KEY `fk_bbs_review_gnb_br_idx` (`br_idx`),
  CONSTRAINT `fk_bbs_review_gnb_br_idx` FOREIGN KEY (`br_idx`) REFERENCES `t_bbs_review` (`br_idx`),
  CONSTRAINT `fk_bbs_review_gnb_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_review_gnb`
--

LOCK TABLES `t_bbs_review_gnb` WRITE;
/*!40000 ALTER TABLE `t_bbs_review_gnb` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_bbs_review_gnb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bbs_review_reply`
--

DROP TABLE IF EXISTS `t_bbs_review_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bbs_review_reply` (
  `brr_idx` int NOT NULL AUTO_INCREMENT,
  `br_idx` int DEFAULT NULL,
  `mi_id` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `brr_content` varchar(200) COLLATE utf8mb3_bin NOT NULL,
  `brr_ip` varchar(15) COLLATE utf8mb3_bin NOT NULL,
  `brr_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `brr_isdel` char(1) COLLATE utf8mb3_bin DEFAULT 'n',
  PRIMARY KEY (`brr_idx`),
  KEY `fk_bbs_review_reply_br_idx` (`br_idx`),
  KEY `fk_bbs_review_reply_mi_id` (`mi_id`),
  CONSTRAINT `fk_bbs_review_reply_br_idx` FOREIGN KEY (`br_idx`) REFERENCES `t_bbs_review` (`br_idx`),
  CONSTRAINT `fk_bbs_review_reply_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bbs_review_reply`
--

LOCK TABLES `t_bbs_review_reply` WRITE;
/*!40000 ALTER TABLE `t_bbs_review_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_bbs_review_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member_addr`
--

DROP TABLE IF EXISTS `t_member_addr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_member_addr` (
  `ma_idx` int NOT NULL AUTO_INCREMENT,
  `mi_id` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `ma_name` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `ma_phone` varchar(13) COLLATE utf8mb3_bin DEFAULT NULL,
  `ma_zip` char(5) COLLATE utf8mb3_bin NOT NULL,
  `ma_addr1` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `ma_addr2` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `ma_basic` char(1) COLLATE utf8mb3_bin DEFAULT 'y',
  `ma_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_idx`),
  KEY `fk_member_addr_mi_id` (`mi_id`),
  CONSTRAINT `fk_member_addr_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member_addr`
--

LOCK TABLES `t_member_addr` WRITE;
/*!40000 ALTER TABLE `t_member_addr` DISABLE KEYS */;
INSERT INTO `t_member_addr` VALUES (1,'test1','집주소',NULL,'12345','서울시 강남구 삼성동','123-45','y','2022-12-14 11:37:02'),(2,'test1','회사주소',NULL,'12344','서울시 강남구 서초동','999-45','n','2022-12-14 11:37:02'),(3,'test2','집주소',NULL,'54321','부산시 연제구 연산동','222-33','y','2022-12-14 11:37:02'),(4,'test3','집주소',NULL,'11223','인천시 부평구 부평동','11-33','y','2022-12-14 11:37:02');
/*!40000 ALTER TABLE `t_member_addr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member_info`
--

DROP TABLE IF EXISTS `t_member_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_member_info` (
  `mi_id` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `mi_pw` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `mi_name` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `mi_gender` char(1) COLLATE utf8mb3_bin NOT NULL,
  `mi_birth` char(10) COLLATE utf8mb3_bin NOT NULL,
  `mi_phone` varchar(13) COLLATE utf8mb3_bin NOT NULL,
  `mi_email` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `mi_point` int DEFAULT '0',
  `mi_lastlogin` datetime DEFAULT NULL,
  `mi_joindate` datetime DEFAULT CURRENT_TIMESTAMP,
  `mi_status` char(1) COLLATE utf8mb3_bin DEFAULT 'a',
  PRIMARY KEY (`mi_id`),
  UNIQUE KEY `mi_phone` (`mi_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member_info`
--

LOCK TABLES `t_member_info` WRITE;
/*!40000 ALTER TABLE `t_member_info` DISABLE KEYS */;
INSERT INTO `t_member_info` VALUES ('test1','1234','홍길동','남','1988-05-20','010-1234-5678','hong@test.com',1000,NULL,'2022-12-14 11:37:02','a'),('test2','1234','전우치','남','1989-10-02','010-9876-5432','woo@test.com',1000,NULL,'2022-12-14 11:37:02','a'),('test3','1234','임꺽정','남','1995-11-02','010-8888-5555','lim@test.com',1000,NULL,'2022-12-14 11:37:02','a');
/*!40000 ALTER TABLE `t_member_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member_point`
--

DROP TABLE IF EXISTS `t_member_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_member_point` (
  `mp_idx` int NOT NULL AUTO_INCREMENT,
  `mi_id` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `mp_su` char(1) COLLATE utf8mb3_bin DEFAULT 's',
  `mp_point` int DEFAULT '0',
  `mp_desc` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `mp_detail` varchar(20) COLLATE utf8mb3_bin DEFAULT '',
  `mp_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `mp_admin` int DEFAULT '0',
  PRIMARY KEY (`mp_idx`),
  KEY `fk_member_point_mi_id` (`mi_id`),
  CONSTRAINT `fk_member_point_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member_point`
--

LOCK TABLES `t_member_point` WRITE;
/*!40000 ALTER TABLE `t_member_point` DISABLE KEYS */;
INSERT INTO `t_member_point` VALUES (1,'test1','s',1000,'가입축하금','','2022-12-14 11:37:02',0),(2,'test2','s',1000,'가입축하금','','2022-12-14 11:37:02',0),(3,'test3','s',1000,'가입축하금','','2022-12-14 11:37:02',0);
/*!40000 ALTER TABLE `t_member_point` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member_status`
--

DROP TABLE IF EXISTS `t_member_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_member_status` (
  `ms_idx` int NOT NULL AUTO_INCREMENT,
  `mi_id` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `ms_status` char(1) COLLATE utf8mb3_bin NOT NULL,
  `ms_reason` varchar(200) COLLATE utf8mb3_bin NOT NULL,
  `ms_self` int DEFAULT '0',
  `ms_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ms_idx`),
  KEY `fk_member_status_mi_id` (`mi_id`),
  CONSTRAINT `fk_member_status_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member_status`
--

LOCK TABLES `t_member_status` WRITE;
/*!40000 ALTER TABLE `t_member_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_member_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order_cart`
--

DROP TABLE IF EXISTS `t_order_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_order_cart` (
  `oc_idx` int NOT NULL AUTO_INCREMENT,
  `mi_id` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `pi_id` char(7) COLLATE utf8mb3_bin DEFAULT NULL,
  `ps_idx` int DEFAULT NULL,
  `oc_cnt` int DEFAULT '0',
  `oc_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`oc_idx`),
  KEY `fk_order_cart_mi_id` (`mi_id`),
  KEY `fk_order_cart_pi_id` (`pi_id`),
  KEY `fk_order_cart_ps_idx` (`ps_idx`),
  CONSTRAINT `fk_order_cart_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`),
  CONSTRAINT `fk_order_cart_pi_id` FOREIGN KEY (`pi_id`) REFERENCES `t_product_info` (`pi_id`),
  CONSTRAINT `fk_order_cart_ps_idx` FOREIGN KEY (`ps_idx`) REFERENCES `t_product_stock` (`ps_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order_cart`
--

LOCK TABLES `t_order_cart` WRITE;
/*!40000 ALTER TABLE `t_order_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_order_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order_detail`
--

DROP TABLE IF EXISTS `t_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_order_detail` (
  `od_idx` int NOT NULL AUTO_INCREMENT,
  `oi_id` char(12) COLLATE utf8mb3_bin DEFAULT NULL,
  `pi_id` char(7) COLLATE utf8mb3_bin DEFAULT NULL,
  `ps_idx` int DEFAULT NULL,
  `od_cnt` int DEFAULT '0',
  `od_price` int DEFAULT '0',
  `od_name` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `od_img` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `od_size` int DEFAULT '0',
  PRIMARY KEY (`od_idx`),
  KEY `fk_order_detail_oi_id` (`oi_id`),
  KEY `fk_order_detail_pi_id` (`pi_id`),
  KEY `fk_order_detail_ps_idx` (`ps_idx`),
  CONSTRAINT `fk_order_detail_oi_id` FOREIGN KEY (`oi_id`) REFERENCES `t_order_info` (`oi_id`),
  CONSTRAINT `fk_order_detail_pi_id` FOREIGN KEY (`pi_id`) REFERENCES `t_product_info` (`pi_id`),
  CONSTRAINT `fk_order_detail_ps_idx` FOREIGN KEY (`ps_idx`) REFERENCES `t_product_stock` (`ps_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order_detail`
--

LOCK TABLES `t_order_detail` WRITE;
/*!40000 ALTER TABLE `t_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order_info`
--

DROP TABLE IF EXISTS `t_order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_order_info` (
  `oi_id` char(12) COLLATE utf8mb3_bin NOT NULL,
  `mi_id` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `oi_name` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `oi_phone` varchar(13) COLLATE utf8mb3_bin NOT NULL,
  `oi_zip` char(5) COLLATE utf8mb3_bin NOT NULL,
  `oi_addr1` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `oi_addr2` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `oi_memo` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `oi_payment` char(1) COLLATE utf8mb3_bin DEFAULT 'a',
  `oi_pay` int DEFAULT '0',
  `oi_upoint` int DEFAULT '0',
  `oi_spoint` int DEFAULT '0',
  `oi_invoice` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `oi_status` char(1) COLLATE utf8mb3_bin DEFAULT 'a',
  `oi_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`oi_id`),
  KEY `fk_order_info_mi_id` (`mi_id`),
  CONSTRAINT `fk_order_info_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order_info`
--

LOCK TABLES `t_order_info` WRITE;
/*!40000 ALTER TABLE `t_order_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_poll_exam`
--

DROP TABLE IF EXISTS `t_poll_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_poll_exam` (
  `pe_idx` int NOT NULL AUTO_INCREMENT,
  `pq_idx` int DEFAULT NULL,
  `pe_seq` int DEFAULT '0',
  `pe_exam` varchar(100) COLLATE utf8mb3_bin NOT NULL,
  `pe_use` char(1) COLLATE utf8mb3_bin DEFAULT 'y',
  `pe_cnt` int DEFAULT '0',
  PRIMARY KEY (`pe_idx`),
  KEY `fk_poll_exam_pq_idx` (`pq_idx`),
  CONSTRAINT `fk_poll_exam_pq_idx` FOREIGN KEY (`pq_idx`) REFERENCES `t_poll_question` (`pq_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_poll_exam`
--

LOCK TABLES `t_poll_exam` WRITE;
/*!40000 ALTER TABLE `t_poll_exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_poll_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_poll_question`
--

DROP TABLE IF EXISTS `t_poll_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_poll_question` (
  `pq_idx` int NOT NULL,
  `pq_start` datetime DEFAULT NULL,
  `pq_end` datetime DEFAULT NULL,
  `pq_question` varchar(200) COLLATE utf8mb3_bin NOT NULL,
  `pq_status` char(1) COLLATE utf8mb3_bin DEFAULT 'a',
  `pq_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ai_idx` int DEFAULT NULL,
  PRIMARY KEY (`pq_idx`),
  KEY `fk_poll_question_ai_idx` (`ai_idx`),
  CONSTRAINT `fk_poll_question_ai_idx` FOREIGN KEY (`ai_idx`) REFERENCES `t_admin_info` (`ai_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_poll_question`
--

LOCK TABLES `t_poll_question` WRITE;
/*!40000 ALTER TABLE `t_poll_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_poll_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_poll_result`
--

DROP TABLE IF EXISTS `t_poll_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_poll_result` (
  `pr_idx` int NOT NULL AUTO_INCREMENT,
  `mi_id` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `pq_idx` int NOT NULL,
  `pe_idx` int DEFAULT NULL,
  `pr_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mi_id`,`pq_idx`),
  UNIQUE KEY `pr_idx` (`pr_idx`),
  KEY `fk_poll_result_pq_idx` (`pq_idx`),
  KEY `fk_poll_result_pe_idx` (`pe_idx`),
  CONSTRAINT `fk_poll_result_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`),
  CONSTRAINT `fk_poll_result_pe_idx` FOREIGN KEY (`pe_idx`) REFERENCES `t_poll_exam` (`pe_idx`),
  CONSTRAINT `fk_poll_result_pq_idx` FOREIGN KEY (`pq_idx`) REFERENCES `t_poll_question` (`pq_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_poll_result`
--

LOCK TABLES `t_poll_result` WRITE;
/*!40000 ALTER TABLE `t_poll_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_poll_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_product_brand`
--

DROP TABLE IF EXISTS `t_product_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_product_brand` (
  `pb_id` char(2) COLLATE utf8mb3_bin NOT NULL,
  `pb_name` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`pb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_product_brand`
--

LOCK TABLES `t_product_brand` WRITE;
/*!40000 ALTER TABLE `t_product_brand` DISABLE KEYS */;
INSERT INTO `t_product_brand` VALUES ('B1','랜드로버'),('B2','리갈'),('B3','나이키'),('B4','아디다스');
/*!40000 ALTER TABLE `t_product_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_product_ctgr_big`
--

DROP TABLE IF EXISTS `t_product_ctgr_big`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_product_ctgr_big` (
  `pcb_id` char(2) COLLATE utf8mb3_bin NOT NULL,
  `pcb_name` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`pcb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_product_ctgr_big`
--

LOCK TABLES `t_product_ctgr_big` WRITE;
/*!40000 ALTER TABLE `t_product_ctgr_big` DISABLE KEYS */;
INSERT INTO `t_product_ctgr_big` VALUES ('AA','구두'),('BB','운동화');
/*!40000 ALTER TABLE `t_product_ctgr_big` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_product_ctgr_small`
--

DROP TABLE IF EXISTS `t_product_ctgr_small`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_product_ctgr_small` (
  `pcs_id` char(4) COLLATE utf8mb3_bin NOT NULL,
  `pcb_id` char(2) COLLATE utf8mb3_bin DEFAULT NULL,
  `pcs_name` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`pcs_id`),
  KEY `fk_product_ctgr_small_pcb_id` (`pcb_id`),
  CONSTRAINT `fk_product_ctgr_small_pcb_id` FOREIGN KEY (`pcb_id`) REFERENCES `t_product_ctgr_big` (`pcb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_product_ctgr_small`
--

LOCK TABLES `t_product_ctgr_small` WRITE;
/*!40000 ALTER TABLE `t_product_ctgr_small` DISABLE KEYS */;
INSERT INTO `t_product_ctgr_small` VALUES ('AA01','AA','로퍼'),('AA02','AA','윙팁'),('AA03','AA','더비'),('BB01','BB','러닝화'),('BB02','BB','농구화'),('BB03','BB','스니커즈');
/*!40000 ALTER TABLE `t_product_ctgr_small` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_product_info`
--

DROP TABLE IF EXISTS `t_product_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_product_info` (
  `pi_id` char(7) COLLATE utf8mb3_bin NOT NULL,
  `pcs_id` char(4) COLLATE utf8mb3_bin DEFAULT NULL,
  `pb_id` char(2) COLLATE utf8mb3_bin DEFAULT NULL,
  `pi_name` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `pi_price` int DEFAULT '0',
  `pi_cost` int DEFAULT '0',
  `pi_dc` int DEFAULT '0',
  `pi_com` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `pi_img1` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `pi_img2` varchar(50) COLLATE utf8mb3_bin DEFAULT '',
  `pi_img3` varchar(50) COLLATE utf8mb3_bin DEFAULT '',
  `pi_desc` varchar(50) COLLATE utf8mb3_bin NOT NULL,
  `pi_special` varchar(4) COLLATE utf8mb3_bin DEFAULT '',
  `pi_read` int DEFAULT '0',
  `pi_score` float DEFAULT '0',
  `pi_review` int DEFAULT '0',
  `pi_sale` int DEFAULT '0',
  `pi_isview` char(1) COLLATE utf8mb3_bin DEFAULT 'n',
  `pi_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ai_idx` int DEFAULT NULL,
  `pi_last` datetime DEFAULT CURRENT_TIMESTAMP,
  `pi_ai_idx` int DEFAULT '0',
  PRIMARY KEY (`pi_id`),
  KEY `fk_product_info_pcs_id` (`pcs_id`),
  KEY `fk_product_info_pb_id` (`pb_id`),
  KEY `fk_product_info_ai_idx` (`ai_idx`),
  CONSTRAINT `fk_product_info_ai_idx` FOREIGN KEY (`ai_idx`) REFERENCES `t_admin_info` (`ai_idx`),
  CONSTRAINT `fk_product_info_pb_id` FOREIGN KEY (`pb_id`) REFERENCES `t_product_brand` (`pb_id`),
  CONSTRAINT `fk_product_info_pcs_id` FOREIGN KEY (`pcs_id`) REFERENCES `t_product_ctgr_small` (`pcs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_product_info`
--

LOCK TABLES `t_product_info` WRITE;
/*!40000 ALTER TABLE `t_product_info` DISABLE KEYS */;
INSERT INTO `t_product_info` VALUES ('AA01101','AA01','B1','좋은 로퍼',150000,80000,0,'좋은 회사','AA01101_1.jpg','','','AA01101_d.jpg','',0,0,0,0,'y','2022-12-14 11:37:02',1,'2022-12-14 11:37:02',0),('AA02102','AA02','B2','좋은 윙팁',180000,90000,10,'좋은 회사','AA01102_1.jpg','','','AA02102_d.jpg','',0,0,0,0,'y','2022-12-14 11:37:02',1,'2022-12-14 11:37:02',0),('BB01103','BB01','B3','뛰는 러닝화',130000,70000,0,'좋은 회사2','BB01103_1.jpg','','','BB01103_d.jpg','',0,0,0,0,'y','2022-12-14 11:37:02',1,'2022-12-14 11:37:02',0);
/*!40000 ALTER TABLE `t_product_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_product_stock`
--

DROP TABLE IF EXISTS `t_product_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_product_stock` (
  `ps_idx` int NOT NULL AUTO_INCREMENT,
  `pi_id` char(7) COLLATE utf8mb3_bin DEFAULT NULL,
  `ps_size` int DEFAULT '0',
  `ps_stock` int DEFAULT '0',
  `ps_sale` int DEFAULT '0',
  `ps_isview` char(1) COLLATE utf8mb3_bin DEFAULT 'n',
  PRIMARY KEY (`ps_idx`),
  KEY `fk_product_stock_pi_id` (`pi_id`),
  CONSTRAINT `fk_product_stock_pi_id` FOREIGN KEY (`pi_id`) REFERENCES `t_product_info` (`pi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_product_stock`
--

LOCK TABLES `t_product_stock` WRITE;
/*!40000 ALTER TABLE `t_product_stock` DISABLE KEYS */;
INSERT INTO `t_product_stock` VALUES (1,'AA01101',250,100,0,'n'),(2,'AA01101',255,110,0,'n'),(3,'AA01101',260,120,0,'n'),(4,'AA01101',265,130,0,'n'),(5,'AA01101',270,140,0,'n'),(6,'AA01101',275,150,0,'n'),(7,'AA01101',280,160,0,'n'),(8,'AA02102',220,120,0,'n'),(9,'AA02102',225,125,0,'n'),(10,'AA02102',230,130,0,'n'),(11,'AA02102',235,135,0,'n'),(12,'AA02102',240,140,0,'n'),(13,'AA02102',245,145,0,'n'),(14,'AA02102',250,150,0,'n'),(15,'BB01103',220,115,0,'n'),(16,'BB01103',230,120,0,'n'),(17,'BB01103',240,125,0,'n'),(18,'BB01103',250,130,0,'n'),(19,'BB01103',260,135,0,'n'),(20,'BB01103',270,140,0,'n'),(21,'BB01103',280,145,0,'n');
/*!40000 ALTER TABLE `t_product_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_schedule_info`
--

DROP TABLE IF EXISTS `t_schedule_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_schedule_info` (
  `si_idx` int NOT NULL,
  `mi_id` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `si_start` datetime NOT NULL,
  `si_end` datetime DEFAULT NULL,
  `si_content` varchar(100) COLLATE utf8mb3_bin NOT NULL,
  `si_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`si_idx`),
  KEY `fk_schedule_info_mi_id` (`mi_id`),
  CONSTRAINT `fk_schedule_info_mi_id` FOREIGN KEY (`mi_id`) REFERENCES `t_member_info` (`mi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_schedule_info`
--

LOCK TABLES `t_schedule_info` WRITE;
/*!40000 ALTER TABLE `t_schedule_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_schedule_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_cursor`
--

DROP TABLE IF EXISTS `test_cursor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_cursor` (
  `c1` int NOT NULL AUTO_INCREMENT,
  `c2` int DEFAULT '0',
  `c3` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`c1`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_cursor`
--

LOCK TABLES `test_cursor` WRITE;
/*!40000 ALTER TABLE `test_cursor` DISABLE KEYS */;
INSERT INTO `test_cursor` VALUES (1,0,'test1'),(2,29,'test2'),(3,0,'test3'),(5,7,'cursor'),(6,7,'cursor2'),(9,7,'cursor');
/*!40000 ALTER TABLE `test_cursor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_tr`
--

DROP TABLE IF EXISTS `test_tr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_tr` (
  `tt_c1` int NOT NULL AUTO_INCREMENT,
  `tt_c2` varchar(10) COLLATE utf8mb3_bin NOT NULL,
  `tt_c3` varchar(10) COLLATE utf8mb3_bin DEFAULT '',
  `tt_c4` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tt_c1`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_tr`
--

LOCK TABLES `test_tr` WRITE;
/*!40000 ALTER TABLE `test_tr` DISABLE KEYS */;
INSERT INTO `test_tr` VALUES (1,'w','n','2022-12-16 16:43:55');
/*!40000 ALTER TABLE `test_tr` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_test` AFTER UPDATE ON `test_tr` FOR EACH ROW begin
	insert into test_tr2 (tt2_c2) values ('aaa');
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_test2` AFTER UPDATE ON `test_tr` FOR EACH ROW begin
	declare c2 varchar(10);
    declare c3 varchar(10);
    set c2 = old.tt_c2;
    set c3 = old.tt_c3;
	insert into test_tr2 (tt2_c2, tt2_c3) values (c2, c3);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `test_tr2`
--

DROP TABLE IF EXISTS `test_tr2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_tr2` (
  `tt2_c1` int NOT NULL AUTO_INCREMENT,
  `tt2_c2` varchar(10) COLLATE utf8mb3_bin NOT NULL,
  `tt2_c3` varchar(10) COLLATE utf8mb3_bin DEFAULT '',
  `tt2_c4` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tt2_c1`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_tr2`
--

LOCK TABLES `test_tr2` WRITE;
/*!40000 ALTER TABLE `test_tr2` DISABLE KEYS */;
INSERT INTO `test_tr2` VALUES (1,'aaa','','2022-12-16 16:45:33'),(20,'aaa','','2022-12-16 17:09:52'),(21,'bbb','ccc','2022-12-16 17:09:52'),(22,'aaa','','2022-12-16 17:12:53'),(23,'bbb','ccc','2022-12-16 17:12:53'),(24,'aaa','','2022-12-16 17:13:13'),(25,'w','n','2022-12-16 17:13:13');
/*!40000 ALTER TABLE `test_tr2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_first`
--

DROP TABLE IF EXISTS `v_first`;
/*!50001 DROP VIEW IF EXISTS `v_first`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_first` AS SELECT 
 1 AS `mi_id`,
 1 AS `mi_pw`,
 1 AS `mi_name`,
 1 AS `mi_gender`,
 1 AS `mi_birth`,
 1 AS `mi_phone`,
 1 AS `mi_email`,
 1 AS `mi_point`,
 1 AS `mi_lastlogin`,
 1 AS `mi_joindate`,
 1 AS `mi_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_member_info`
--

DROP TABLE IF EXISTS `v_member_info`;
/*!50001 DROP VIEW IF EXISTS `v_member_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_member_info` AS SELECT 
 1 AS `mi_id`,
 1 AS `mi_name`,
 1 AS `mi_phone`,
 1 AS `ma_zip`,
 1 AS `ma_addr1`,
 1 AS `ma_addr2`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_member_order_list`
--

DROP TABLE IF EXISTS `v_member_order_list`;
/*!50001 DROP VIEW IF EXISTS `v_member_order_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_member_order_list` AS SELECT 
 1 AS `mi_id`,
 1 AS `mi_name`,
 1 AS `total`,
 1 AS `cnt`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_member_order_list2`
--

DROP TABLE IF EXISTS `v_member_order_list2`;
/*!50001 DROP VIEW IF EXISTS `v_member_order_list2`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_member_order_list2` AS SELECT 
 1 AS `mi_id`,
 1 AS `mi_name`,
 1 AS `total`,
 1 AS `cnt`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_order_list`
--

DROP TABLE IF EXISTS `v_order_list`;
/*!50001 DROP VIEW IF EXISTS `v_order_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_order_list` AS SELECT 
 1 AS `mi_id`,
 1 AS `oi_id`,
 1 AS `oi_date`,
 1 AS `pi_id`,
 1 AS `od_name`,
 1 AS `od_cnt`,
 1 AS `od_size`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_order_list2`
--

DROP TABLE IF EXISTS `v_order_list2`;
/*!50001 DROP VIEW IF EXISTS `v_order_list2`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_order_list2` AS SELECT 
 1 AS `mi_id`,
 1 AS `mi_name`,
 1 AS `oi_id`,
 1 AS `oi_date`,
 1 AS `pi_id`,
 1 AS `pcs_name`,
 1 AS `pi_name`,
 1 AS `od_cnt`,
 1 AS `od_size`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_order_monthly`
--

DROP TABLE IF EXISTS `v_order_monthly`;
/*!50001 DROP VIEW IF EXISTS `v_order_monthly`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_order_monthly` AS SELECT 
 1 AS `sYear`,
 1 AS `sMonth`,
 1 AS `sDay`,
 1 AS `total`,
 1 AS `ordercnt`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_product_sale_list`
--

DROP TABLE IF EXISTS `v_product_sale_list`;
/*!50001 DROP VIEW IF EXISTS `v_product_sale_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_product_sale_list` AS SELECT 
 1 AS `pi_id`,
 1 AS `pi_name`,
 1 AS `salecnt`,
 1 AS `total`,
 1 AS `ordercnt`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'mall'
--

--
-- Dumping routines for database 'mall'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_age` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_age`(miid varchar(20)) RETURNS int
begin
	declare age int;				-- 나이를 저장할 변수
    -- ㅁㅁ mi_birth를 어떻게 뽑아오지?	--> select로 가져온다 ㅁㅁ
    declare nYear int;	-- 현재 연도를 저장할 변수
    declare bYear int;	-- 태어난 연도를 저장할 변수
    
    set nYear =  year(now());		-- 오늘 날짜에서 연도부분만 추출하여 저장
    select left(mi_birth, 4) into bYear from t_member_info where mi_id = miid;
    -- 받아온 회원ID에 해당하는 생일에서 태어난 연도 부분을 추출하여 bYear에 저장
    set age = nYear - bYear;
	return age;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_mem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_mem`(mistatus char(1)) RETURNS varchar(10) CHARSET utf8mb3 COLLATE utf8mb3_bin
begin
	declare mem varchar(10);
    if mistatus = 'a' then
		set mem = '정상회원';
	elseif mistatus = 'b' then
		set mem = '휴면회원';
	elseif mistatus = 'c' then
		set mem = '탈퇴회원';
	end if;
	return mem;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_price`(piid char(7)) RETURNS int
begin
	declare price int;		-- 가격을 저장할 변수
    declare dc int;			-- 할인율을 저장할 변수
    select pi_price into price from t_product_info where pi_id = piid;
    select pi_dc into dc from t_product_info where pi_id = piid;
	
	return price - price * (dc / 100);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cursor_test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cursor_test`()
begin
	declare cid int default 0;	-- 커서에 들어있는 c1 컬럼의 값을 저장할 변수
	declare is_end boolean default false;	-- 커서가 끝까지 루프를 돌았는지 판단할 변수
	-- 커서의 값들을 받을 변수들을 선언해 놓아야 함
	declare cs cursor for select c1 from test_cursor;	-- 지정한 select문으로 커서 생성
	-- test_cursor 테이블에서 c1컬럼을 모두 추출하여 cs라는 커서를 생성
    
	declare continue handler for not found set is_end = true;
	open cs;
	cursorLoop:while true do
		fetch cs into cid;	-- cs 커서의 c1 컬럼의 값을 cid 변수에 저장
		if is_end then
			leave cursorLoop;
		end if;
		update test_cursor set c2 = c2 + cid where c1 = cid;
	end while;
	close cs;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cursor_test2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cursor_test2`()
begin
	declare val int default 0;
	declare cid int default 0;
	declare is_end boolean default false;
	declare cs cursor for  select c1 from test_cursor;
    
	declare continue handler for not found set is_end = true;
	open cs;
	cursorLoop:while true do	
		fetch cs into cid;
		if is_end then
			leave cursorLoop;
		end if;
		if cid % 2 = 0 then
			set val = 5;
		else
			set val = -5;
		end if;
        update test_cursor set c2 = c2 + val where c1 = cid;
	end while;
	close cs;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cursor_test3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cursor_test3`()
begin
	declare vc1 int default 0;
    declare vc2 int default 0;
    declare vc3 varchar(20) default '';
	declare is_end boolean default false;
	declare cs cursor for  select * from test_cursor;
    
	declare continue handler for not found set is_end = true;
	open cs;
	cursorLoop:while true do	
		fetch cs into vc1, vc2, vc3;
		if is_end then
			leave cursorLoop;
		end if;
        
        if vc1 % 10 = 0 or vc2 % 10 = 0 then
			insert into test_cursor (c2, c3) values (vc1, vc2);
		elseif vc1 % 2 = 1 and vc2 % 2 = 1 then
			update test_cursor set c2 = 0 where c1 = vc1;
		end if;
	end while;
	close cs;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_free_manage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_free_manage`(kind char(1),
bfidx int, bfismem char(1), bfwriter varchar(20), bfpw varchar(20), bfheader varchar(20), bftitle varchar(100), bfcontent text, 
bfip varchar(15)
)
begin
	if kind = 'i' then
		insert into t_bbs_free(bf_idx, bf_ismem, bf_writer, bf_pw, bf_header, bf_title, bf_content, bf_ip)
        values(bfidx, bfismem, bfwriter, bfpw, bfheader, bftitle, bfcontent, bfip);
    elseif kind = 'u' and bfismem = 'y' then 		-- 회원글이면 
				update t_bbs_free set bf_header = bfheader, bf_title = bftitle, bf_content = bfcontent
				where bf_idx = bfidx and bf_writer = bfwriter;
	elseif kind = 'u' and bfismem = 'n' then		-- 비회원글이면
				update t_bbs_free set bf_header = bfheader, bf_title = bftitle, bf_content = bfcontent
				where bf_idx = bfidx and bf_pw = bfpw;
	elseif kind = 'd' and bfismem = 'y' then		-- 회원글 삭제이면	
				update t_bbs_free set bf_isdel = 'y'
                where  bf_idx = bfidx and bf_writer = bfwriter;
	elseif kind = 'd' and bfismem = 'n' then		-- 비회원글 삭제이면	
				update t_bbs_free set bf_isdel = 'y'
				where bf_idx = bfidx and bf_pw = bfpw;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_free_reply_manage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_free_reply_manage`(kind char(1),
	bfridx int, bfidx int, bfrismem char(1), bfrwriter varchar(20), bfrpw varchar(20), bfrcontent varchar(200), 
    bfrip varchar(15), bfrisdel char(1)
)
begin
	if kind = 'i' then 
		insert into t_bbs_free_reply(bf_idx, bfr_ismem, bfr_writer, bfr_pw, bfr_content, bfr_ip) 
        values(bfidx, bfrismem, bfrwriter, bfrpw, bfrcontent, bfrip);
        
        update t_bbs_free set bf_reply = bf_reply + 1 where bf_idx = bfidx;
        -- 원본 게시글의 댓글 개수를 1 증가시키는 쿼리
        
	elseif kind = 'a' then				-- 관리자가 삭제할 경우
		update t_bbs_free_reply set bfr_isdel = 'a' where bfr_idx = bfridx;
        
        update t_bbs_free set bf_reply = bf_reply - 1 where bf_idx = bfidx and bf_reply > 0;
        -- 원본 게시글의 댓글 개수를 1 감소시키는 쿼리(음수가 되지 않도록 조건 추가)
	else								-- 본인이 삭제할 경우
		begin
			if bfrismem = 'y' then 		-- 회원이 등록한 댓글일 경우
				update t_bbs_free_reply set bfr_isdel = 'y'
                where bfr_idx = bfridx and bfr_writer = bfrwriter;
            else						-- 비회원이 등록한 댓글일 경우
				update t_bbs_free_reply set bfr_isdel = 'y'
                where bfr_idx = bfridx and bfr_pw = bfrpw;
            end if;
			update t_bbs_free set bf_reply = bf_reply - 1 where bf_idx = bfidx and bf_reply > 0;
	        -- 원본 게시글의 댓글 개수를 1 감소시키는 쿼리(음수가 되지 않도록 조건 추가)
        end;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_notice_manage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_notice_manage`(kind char(1),
	bnidx int, bnctgr varchar(10), aiidx int, bntitle varchar(100), bncontent text, bnisview char(1)
)
begin
	if kind = 'i' then
		insert into t_bbs_notice (bn_idx, bn_ctgr, ai_idx, bn_title, bn_content, bn_isview) 
        values (bnidx, bnctgr, aiidx, bntitle, bncontent, bnisview);
    else
		update t_bbs_notice set bn_ctgr = bnctgr, bn_title = bntitle, bn_content = bncontent, bn_isview = bnisview 
        where bn_idx = bnidx;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_qna_manage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_qna_manage`(kind char(1),
	bqidx int, miid varchar(20), bqctgr char(1), bqtitle varchar(100), bqcontent text, bqimg1 varchar(50), 
    bqimg2 varchar(50), bqip varchar(15), bqisanswer char(1), bqaiidx int, bqanswer text, bqsatis char(1), bqisview char(1)
)
begin
	if kind = 'i' then			-- 질문등록일 경우
		insert into t_bbs_qna(bq_idx, mi_id, bq_ctgr, bq_title, bq_content, bq_img1, bq_img2, bq_ip) 
        values (bqidx, miid, bqctgr, bqtitle, bqcontent, bqimg1, bqimg2, bqip);
	elseif kind = 'u' then		-- 질문수정일 경우(답변이 달리기 전에만 가능)
		update t_bbs_qna set bq_ctgr = bqctgr, bq_title = bqtitle, bq_content = bqcontent, bq_img1 = bq_img1, bq_img2 = bqimg2
        where bq_idx = bqidx and mi_id = miid;
    elseif kind = 'a' then						-- 답변등록일 경우
		update t_bbs_qna set bq_isanswer = bqisanswer, bq_ai_idx = bqaiidx, bq_answer = bqanswer, bq_satis = bqsatis, bq_adate = now(), bq_isview = bqisview
        where bq_idx = bqidx;
	else	
		update t_bbs_qna set bq_satis = bqsatis 
        where bq_idx = bqidx and mi_id = miid;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_t1_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_t1_insert`(ic2 varchar(20), ic3 char(5))
begin
	insert into t1(c2, c3) values (ic2, ic3);
									-- in 은 생략가능
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_transaction`(kind char(1),
vc2 int, vc3 varchar(20), t1c2 varchar(20), t1c3 char(5))
begin
	declare err int default 0;	-- 오류 여부를 저장할 변수
    declare continue handler for sqlexception set err = 1;
    -- 쿼리 작업시 오류가 발생하면 err 변수의 값에 1을 저장
    start transaction;	-- 트랜잭션 시작
    
    if kind = 'e' then	-- 롤백 테스트용 쿼리 작업
    begin
		insert into test_cursor (c2, c3) values (vc2, vc3);
        insert into t1 (c1, c2, c3) values (vc3, t1c2, t1c3);
    end;
    else				-- 커밋 테스트용 쿼리 작업
    begin
		insert into test_cursor (c2, c3) values (vc2, vc3);
        insert into t1 (c2, c3) values (t1c2, t1c3);
    end;
    end if;
    
    if err = 0 then		-- 트랜젝션내의 쿼리 실행시 오류가 발생하지 않았으면
		commit;			-- 쿼리의 실행 결과들을 해당 테이블에 적용
	else				-- 트랜젝션내의 쿼리 실행시 오류가 발생했으면
		rollback;		-- 모든 쿼리의 실행을 처음으로 되돌림
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_first`
--

/*!50001 DROP VIEW IF EXISTS `v_first`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_first` AS select `t_member_info`.`mi_id` AS `mi_id`,`t_member_info`.`mi_pw` AS `mi_pw`,`t_member_info`.`mi_name` AS `mi_name`,`t_member_info`.`mi_gender` AS `mi_gender`,`t_member_info`.`mi_birth` AS `mi_birth`,`t_member_info`.`mi_phone` AS `mi_phone`,`t_member_info`.`mi_email` AS `mi_email`,`t_member_info`.`mi_point` AS `mi_point`,`t_member_info`.`mi_lastlogin` AS `mi_lastlogin`,`t_member_info`.`mi_joindate` AS `mi_joindate`,`t_member_info`.`mi_status` AS `mi_status` from `t_member_info` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_member_info`
--

/*!50001 DROP VIEW IF EXISTS `v_member_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_member_info` AS select `a`.`mi_id` AS `mi_id`,`a`.`mi_name` AS `mi_name`,`a`.`mi_phone` AS `mi_phone`,`b`.`ma_zip` AS `ma_zip`,`b`.`ma_addr1` AS `ma_addr1`,`b`.`ma_addr2` AS `ma_addr2` from (`t_member_info` `a` join `t_member_addr` `b`) where ((`a`.`mi_id` = `b`.`mi_id`) and (`b`.`ma_basic` = 'y')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_member_order_list`
--

/*!50001 DROP VIEW IF EXISTS `v_member_order_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_member_order_list` AS select `a`.`mi_id` AS `mi_id`,`a`.`mi_name` AS `mi_name`,sum(`b`.`oi_pay`) AS `total`,count(`b`.`oi_id`) AS `cnt` from (`t_member_info` `a` join `t_order_info` `b`) where (`a`.`mi_id` = `b`.`mi_id`) group by `a`.`mi_id`,`a`.`mi_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_member_order_list2`
--

/*!50001 DROP VIEW IF EXISTS `v_member_order_list2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_member_order_list2` AS select `a`.`mi_id` AS `mi_id`,`a`.`mi_name` AS `mi_name`,ifnull(sum(`b`.`oi_pay`),0) AS `total`,count(`b`.`oi_id`) AS `cnt` from (`t_member_info` `a` left join `t_order_info` `b` on((`a`.`mi_id` = `b`.`mi_id`))) group by `a`.`mi_id`,`a`.`mi_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_order_list`
--

/*!50001 DROP VIEW IF EXISTS `v_order_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_order_list` AS select `a`.`mi_id` AS `mi_id`,`a`.`oi_id` AS `oi_id`,`a`.`oi_date` AS `oi_date`,`b`.`pi_id` AS `pi_id`,`b`.`od_name` AS `od_name`,`b`.`od_cnt` AS `od_cnt`,`b`.`od_size` AS `od_size` from (`t_order_info` `a` join `t_order_detail` `b`) where (`a`.`oi_id` = `b`.`oi_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_order_list2`
--

/*!50001 DROP VIEW IF EXISTS `v_order_list2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_order_list2` AS select `a`.`mi_id` AS `mi_id`,`a`.`mi_name` AS `mi_name`,`b`.`oi_id` AS `oi_id`,`b`.`oi_date` AS `oi_date`,`d`.`pi_id` AS `pi_id`,`e`.`pcs_name` AS `pcs_name`,`d`.`pi_name` AS `pi_name`,`c`.`od_cnt` AS `od_cnt`,`c`.`od_size` AS `od_size` from ((((`t_member_info` `a` join `t_order_info` `b`) join `t_order_detail` `c`) join `t_product_info` `d`) join `t_product_ctgr_small` `e`) where ((`a`.`mi_id` = `b`.`mi_id`) and (`b`.`oi_id` = `c`.`oi_id`) and (`c`.`pi_id` = `d`.`pi_id`) and (`d`.`pcs_id` = `e`.`pcs_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_order_monthly`
--

/*!50001 DROP VIEW IF EXISTS `v_order_monthly`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_order_monthly` AS select year(`t_order_info`.`oi_date`) AS `sYear`,month(`t_order_info`.`oi_date`) AS `sMonth`,dayofmonth(`t_order_info`.`oi_date`) AS `sDay`,sum(`t_order_info`.`oi_pay`) AS `total`,count(`t_order_info`.`oi_id`) AS `ordercnt` from `t_order_info` group by `sYear`,`sMonth`,`sDay` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_product_sale_list`
--

/*!50001 DROP VIEW IF EXISTS `v_product_sale_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_product_sale_list` AS select `a`.`pi_id` AS `pi_id`,`a`.`pi_name` AS `pi_name`,sum(`b`.`od_cnt`) AS `salecnt`,sum((`b`.`od_cnt` * `b`.`od_price`)) AS `total`,count(`b`.`oi_id`) AS `ordercnt` from (`t_product_info` `a` join `t_order_detail` `b`) where (`a`.`pi_id` = `b`.`pi_id`) group by `a`.`pi_id`,`a`.`pi_name` */;
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

-- Dump completed on 2022-12-20 13:02:39
