/*
SQLyog Ultimate v11.27 (32 bit)
MySQL - 5.6.30 : Database - shop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shop` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `shop`;

/*Table structure for table `t_adminuser` */

DROP TABLE IF EXISTS `t_adminuser`;

CREATE TABLE `t_adminuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `t_adminuser` */

insert  into `t_adminuser`(`id`,`username`,`password`) values (1,'admin','cfcd208495d565ef66e7dff9f98764da');

/*Table structure for table `t_adminuser_msg` */

DROP TABLE IF EXISTS `t_adminuser_msg`;

CREATE TABLE `t_adminuser_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;

/*Data for the table `t_adminuser_msg` */

insert  into `t_adminuser_msg`(`id`,`username`,`time`) values (1,'admin','2016/11/04 11:30:34'),(2,'admin','2016/11/04 11:58:36'),(3,'admin','2016/11/04 11:59:19'),(4,'admin','2016/11/04 15:13:17'),(5,'admin','2016/11/04 17:05:38'),(6,'admin','2016/11/07 09:24:12'),(7,'admin','2016/11/07 11:38:59'),(8,'admin','2016/11/07 11:40:59'),(9,'admin','2016/11/07 14:20:28'),(10,'admin','2016/11/07 14:27:26'),(11,'admin','2016/11/07 14:31:30'),(12,'admin','2016/11/07 14:41:15'),(13,'admin','2016/11/07 15:55:41'),(14,'admin','2016/11/07 16:21:50'),(15,'admin','2016/11/07 16:31:23'),(16,'admin','2016/11/07 17:06:41'),(17,'admin','2016/11/07 17:48:32'),(18,'admin','2016/11/07 17:55:19'),(19,'admin','2016/11/08 09:18:04'),(20,'admin','2016/11/08 09:43:57'),(21,'admin','2016/11/08 09:46:37'),(22,'admin','2016/11/08 09:56:05'),(23,'admin','2016/11/08 10:14:27'),(24,'admin','2016/11/08 10:15:36'),(25,'admin','2016/11/08 10:30:07'),(26,'admin','2016/11/08 10:32:31'),(27,'admin','2016/11/08 10:35:16'),(28,'admin','2016/11/08 10:57:47'),(29,'admin','2016/11/08 11:02:01'),(30,'admin','2016/11/08 11:04:02'),(31,'admin','2016/11/08 11:13:35'),(32,'admin','2016/11/08 11:53:49'),(33,'admin','2016/11/08 12:04:42'),(34,'admin','2016/11/08 12:15:43'),(35,'admin','2016/11/08 14:29:34'),(36,'admin','2016/11/08 14:44:17'),(37,'admin','2016/11/08 15:00:32'),(38,'admin','2016/11/08 15:05:25'),(39,'admin','2016/11/08 15:51:11'),(40,'admin','2016/11/08 17:43:49'),(41,'admin','2016/11/09 09:42:32'),(42,'admin','2016/11/09 14:31:55'),(43,'admin','2016/11/09 15:14:12'),(44,'admin','2016/11/09 15:14:42'),(45,'admin','2016/11/09 15:26:09'),(46,'admin','2016/11/09 15:33:42'),(47,'admin','2016/11/09 15:35:46'),(48,'admin','2016/11/09 15:36:19'),(49,'admin','2016/11/09 15:58:29'),(50,'admin','2016/11/09 16:00:50'),(51,'admin','2016/11/09 16:01:06'),(52,'admin','2016/11/09 16:02:27'),(53,'admin','2016/11/09 16:12:58'),(54,'admin','2016/11/09 16:14:32'),(55,'admin','2016/11/09 16:17:35'),(56,'admin','2016/11/09 16:52:20'),(57,'admin','2016/11/09 17:03:05'),(58,'admin','2016/11/09 17:53:19'),(59,'admin','2016/11/10 09:24:52'),(60,'admin','2016/11/10 10:25:21'),(61,'admin','2016/11/10 11:10:14'),(62,'admin','2016/11/10 11:16:37'),(63,'admin','2016/11/10 11:33:18'),(64,'admin','2016/11/10 11:42:56'),(65,'admin','2016/11/10 14:34:29'),(66,'admin','2016/11/10 15:09:24'),(67,'admin','2016/11/10 16:20:01'),(68,'admin','2016/11/10 17:03:58'),(69,'admin','2016/11/10 17:38:25'),(70,'admin','2016/11/10 17:49:38'),(71,'admin','2016/11/10 18:08:29'),(72,'admin','2016/11/11 09:26:20'),(73,'admin','2016/11/11 15:14:21'),(74,'admin','2016/11/11 16:06:30'),(75,'admin','2016/11/11 19:25:50'),(76,'admin','2016/11/14 09:05:48'),(77,'admin','2016/11/14 10:20:10'),(78,'admin','2016/11/14 10:23:09'),(79,'admin','2016/11/14 10:23:45'),(80,'admin','2016/11/14 10:54:39'),(81,'admin','2016/11/14 11:50:48'),(82,'admin','2016/11/14 11:56:32'),(83,'admin','2016/11/14 14:11:11'),(84,'admin','2016/11/14 14:28:56'),(85,'admin','2016/11/14 15:14:25'),(86,'admin','2016/11/14 15:27:31'),(87,'admin','2016/11/15 09:39:46'),(88,'admin','2016/11/15 10:25:40'),(89,'admin','2016/11/15 11:29:42'),(90,'admin','2016/11/15 11:38:41'),(91,'admin','2016/11/15 11:40:07'),(92,'admin','2016/11/15 11:40:26'),(93,'admin','2016/11/15 11:44:34'),(94,'admin','2016/11/15 11:46:31'),(95,'admin','2016/11/15 11:50:22'),(96,'admin','2016/11/15 11:55:54'),(97,'admin','2016/11/15 11:57:01'),(98,'admin','2016/11/15 12:36:05'),(99,'admin','2016/11/15 13:38:24'),(100,'admin','2016/11/15 13:56:07'),(101,'admin','2016/11/15 14:04:23'),(102,'admin','2016/11/15 14:52:00'),(103,'admin','2016/11/15 16:31:32'),(104,'admin','2016/11/15 16:40:56'),(105,'admin','2016/11/15 16:52:09'),(106,'admin','2016/11/15 16:53:47'),(107,'admin','2016/11/15 17:04:15'),(108,'admin','2016/11/15 17:06:21'),(109,'admin','2016/11/16 09:26:11'),(110,'admin','2016/11/16 10:40:48'),(111,'admin','2016/11/16 10:41:04'),(112,'admin','2016/11/16 10:52:10'),(113,'admin','2016/11/16 10:52:27'),(114,'admin','2016/11/16 11:11:45'),(115,'admin','2016/11/16 11:41:32'),(116,'admin','2016/11/16 11:53:38'),(117,'admin','2016/11/16 12:05:58'),(118,'admin','2016/11/16 13:58:45'),(119,'admin','2016/11/16 14:08:43'),(120,'admin','2016/11/16 14:11:55'),(121,'admin','2016/11/16 14:14:14'),(122,'admin','2016/11/16 14:17:57'),(123,'admin','2016/11/16 14:19:13'),(124,'admin','2016/11/16 14:20:49'),(125,'admin','2016/11/16 14:28:36'),(126,'admin','2016/11/16 14:54:40'),(127,'admin','2016/11/16 15:09:25'),(128,'admin','2016/11/16 15:31:41'),(129,'admin','2016/11/16 15:59:42'),(130,'admin','2016/11/16 16:05:29'),(131,'admin','2016/11/16 16:46:34'),(132,'admin','2016/11/16 16:55:55'),(133,'admin','2016/11/16 17:17:10'),(134,'admin','2016/11/16 17:39:18'),(135,'admin','2016/11/16 17:43:28'),(136,'admin','2016/11/16 17:48:04'),(137,'admin','2016/11/16 17:48:17'),(138,'admin','2016/11/16 18:03:10'),(139,'admin','2016/11/16 18:05:50'),(140,'admin','2016/11/16 18:07:48'),(141,'admin','2016/11/16 18:23:04'),(142,'admin','2016/11/16 18:25:05'),(143,'admin','2016/11/16 18:35:45'),(144,'admin','2016/11/16 18:36:48'),(145,'admin','2016/11/16 18:39:19'),(146,'admin','2016/11/16 18:40:53'),(147,'admin','2016/11/16 18:42:21'),(148,'admin','2016/11/17 09:36:31'),(149,'admin','2016/11/17 10:30:04'),(150,'admin','2016/11/17 17:10:07'),(151,'admin','2016/11/18 09:33:48'),(152,'admin','2016/11/18 09:52:53'),(153,'admin','2016/11/18 09:54:02'),(154,'admin','2016/11/18 10:33:10'),(155,'admin','2016/11/18 10:36:14'),(156,'admin','2016/11/18 10:49:20'),(157,'admin','2016/11/18 10:49:20'),(158,'admin','2016/11/18 11:03:27'),(159,'admin','2016/11/18 11:07:33'),(160,'admin','2016/11/18 15:14:02'),(161,'admin','2016/11/18 17:45:26'),(162,'admin','2016/11/19 11:10:09'),(163,'admin','2016/11/21 09:43:23'),(164,'admin','2016/11/21 10:45:52'),(165,'admin','2016/11/21 11:45:38'),(166,'admin','2016/11/21 14:29:52'),(167,'admin','2016/11/21 14:45:09'),(168,'admin','2016/11/22 11:28:32'),(169,'admin','2016/11/22 13:48:38'),(170,'admin','2016/11/22 14:55:55'),(171,'admin','2016/11/22 17:24:55'),(172,'admin','2016/11/23 09:28:24'),(173,'admin','2016/11/24 10:48:09'),(174,'admin','2016/11/24 16:55:10'),(175,'admin','2016/11/25 11:08:55'),(176,'admin','2016/12/05 16:08:13'),(177,'admin','2016/12/05 16:23:20');

/*Table structure for table `t_banner` */

DROP TABLE IF EXISTS `t_banner`;

CREATE TABLE `t_banner` (
  `id` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_banner` */

/*Table structure for table `t_cart` */

DROP TABLE IF EXISTS `t_cart`;

CREATE TABLE `t_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `skuid` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `totalprice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `skuid` (`skuid`),
  CONSTRAINT `t_cart_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `t_user` (`id`),
  CONSTRAINT `t_cart_ibfk_2` FOREIGN KEY (`skuid`) REFERENCES `t_goods_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_cart` */

/*Table structure for table `t_distribution` */

DROP TABLE IF EXISTS `t_distribution`;

CREATE TABLE `t_distribution` (
  `id` int(11) NOT NULL COMMENT 'id',
  `userid` int(11) NOT NULL COMMENT '用户id',
  `orderid` int(11) NOT NULL COMMENT '订单id',
  `money` decimal(10,2) NOT NULL COMMENT '提成金额',
  PRIMARY KEY (`id`),
  KEY `FK_t_distribution` (`userid`),
  KEY `FK_t_distribution2` (`orderid`),
  CONSTRAINT `FK_t_distribution2` FOREIGN KEY (`orderid`) REFERENCES `t_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_distribution` */

/*Table structure for table `t_goods` */

DROP TABLE IF EXISTS `t_goods`;

CREATE TABLE `t_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) NOT NULL COMMENT '商品名称',
  `exp_name` varchar(255) NOT NULL COMMENT '商品扩充名称',
  `typeid` int(11) NOT NULL COMMENT '类目id',
  `quantity` int(11) NOT NULL COMMENT '商品总量',
  `content` text COMMENT '描述信息',
  `code` varchar(255) NOT NULL COMMENT '商品编码',
  `searchval` varchar(1000) DEFAULT NULL COMMENT '商品搜索属性',
  `brandid` int(11) NOT NULL COMMENT '商品品牌',
  `store` varchar(255) DEFAULT NULL COMMENT '所属门店',
  `top` varchar(255) DEFAULT NULL,
  `ids` varchar(255) DEFAULT NULL COMMENT '特征量组合id',
  `num` int(11) DEFAULT NULL COMMENT '购买人数',
  PRIMARY KEY (`id`),
  KEY `FK_t_goods` (`brandid`),
  KEY `FK_t_goods2` (`typeid`),
  CONSTRAINT `FK_t_goods` FOREIGN KEY (`brandid`) REFERENCES `t_goods_brand` (`id`),
  CONSTRAINT `FK_t_goods2` FOREIGN KEY (`typeid`) REFERENCES `t_goods_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods` */

insert  into `t_goods`(`id`,`name`,`exp_name`,`typeid`,`quantity`,`content`,`code`,`searchval`,`brandid`,`store`,`top`,`ids`,`num`) values (3,'33333','22222',2,33332,'22222','33333',NULL,5,'22222','1476866928493','4',1),(5,'22222','33333',1,23232,'1231','31323',NULL,4,'43132','1','5',3),(19,'棉被1','棉被1扩充',3,12,'棉被1扩充描述信息','012',NULL,3,'012',NULL,'',2),(20,'棉被测试1','棉被测试1扩充名称',5,12,'棉被测试1描述信息','01',NULL,3,'lm',NULL,'9,10',NULL),(21,'蚕丝被','蚕丝被扩充名称',5,12,'蚕丝被描述','000',NULL,12,'lm',NULL,'9,10',NULL),(22,'样式测试1','测试扩充',5,12,'测试','001',NULL,3,'lm',NULL,'2,4,5,9,10',NULL),(23,'撒的发松岛枫','1',6,1,'1','1',NULL,3,'1',NULL,'',NULL);

/*Table structure for table `t_goods_brand` */

DROP TABLE IF EXISTS `t_goods_brand`;

CREATE TABLE `t_goods_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  `content` text COMMENT '品牌介绍',
  `supplierid` int(11) NOT NULL COMMENT '供应商id',
  PRIMARY KEY (`id`,`supplierid`),
  KEY `FK_t_goods_brand` (`supplierid`),
  CONSTRAINT `FK_t_goods_brand` FOREIGN KEY (`supplierid`) REFERENCES `t_goods_supplier` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_brand` */

insert  into `t_goods_brand`(`id`,`name`,`content`,`supplierid`) values (3,'ffffff','ffff',11),(4,'fffff','sssss',5),(5,'aaaaa','bbbb',10),(6,'wwwwwww','ffffff',5),(7,'ddddd','',5),(8,'dddddd','',5),(9,'fafdaf','',5),(10,'fdafa','',5),(11,'fdafafa','',5),(12,'一见喜','一见喜品牌简介',5);

/*Table structure for table `t_goods_image` */

DROP TABLE IF EXISTS `t_goods_image`;

CREATE TABLE `t_goods_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `goodsid` int(11) NOT NULL,
  `skuid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_t_goods_image` (`goodsid`),
  KEY `FK_t_goods_image2` (`skuid`),
  CONSTRAINT `FK_t_goods_image` FOREIGN KEY (`goodsid`) REFERENCES `t_goods` (`id`),
  CONSTRAINT `FK_t_goods_image2` FOREIGN KEY (`skuid`) REFERENCES `t_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_image` */

insert  into `t_goods_image`(`id`,`url`,`goodsid`,`skuid`) values (1,'upload/5.jpg',3,1),(3,'upload/6.jpg',5,2),(4,'upload/7.jpg',3,3),(5,'upload/8.jpg',3,4),(6,'upload/9.jpg',3,5),(7,'upload/5.jpg',20,9),(8,'upload/6.jpg',20,10);

/*Table structure for table `t_goods_pro` */

DROP TABLE IF EXISTS `t_goods_pro`;

CREATE TABLE `t_goods_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `typeid` int(11) NOT NULL COMMENT '所属类目id',
  PRIMARY KEY (`id`),
  KEY `FK_t_goods_pro` (`typeid`),
  CONSTRAINT `FK_t_goods_pro` FOREIGN KEY (`typeid`) REFERENCES `t_goods_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_pro` */

insert  into `t_goods_pro`(`id`,`name`,`typeid`) values (2,'CPU',5),(3,'硬盘',1),(4,'内存',5),(5,'显示器',5),(6,'鼠标',1),(7,'键盘',1),(8,'lkjlkj',2),(9,'颜色',5),(10,'尺寸',5);

/*Table structure for table `t_goods_pro_val` */

DROP TABLE IF EXISTS `t_goods_pro_val`;

CREATE TABLE `t_goods_pro_val` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `proid` int(11) NOT NULL COMMENT '商品属性id',
  `skuid` int(11) NOT NULL COMMENT '商品id',
  `value` varchar(255) NOT NULL COMMENT '值',
  PRIMARY KEY (`id`),
  KEY `FK_t_goods_pro_val` (`proid`),
  KEY `FK_t_goods_pro_val1` (`skuid`),
  CONSTRAINT `FK_t_goods_pro_val` FOREIGN KEY (`proid`) REFERENCES `t_goods_pro` (`id`),
  CONSTRAINT `FK_t_goods_pro_val1` FOREIGN KEY (`skuid`) REFERENCES `t_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_pro_val` */

insert  into `t_goods_pro_val`(`id`,`proid`,`skuid`,`value`) values (6,9,9,'蓝'),(7,10,9,'10cm'),(8,9,10,'黄'),(9,10,10,'20cm'),(10,9,11,'蓝'),(11,10,11,'30cm'),(12,9,12,'蓝'),(13,10,12,'50cm'),(14,9,13,'黄'),(15,10,13,'30cm'),(16,2,14,'a1'),(17,4,14,'a2'),(18,5,14,'a3'),(19,9,14,'红'),(20,10,14,'1cm'),(21,2,15,'a1'),(22,4,15,'b1'),(23,5,15,'c1'),(24,9,15,'黄'),(25,10,15,'10cm'),(26,2,16,'a2'),(27,4,16,'b2'),(28,5,16,'c1'),(29,9,16,'蓝'),(30,10,16,'20cm');

/*Table structure for table `t_goods_sku` */

DROP TABLE IF EXISTS `t_goods_sku`;

CREATE TABLE `t_goods_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `num` int(11) NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `goodsid` int(11) NOT NULL COMMENT '商品id',
  `code` varchar(255) NOT NULL COMMENT '特征量编码',
  PRIMARY KEY (`id`),
  KEY `FK_t_goods_sku` (`goodsid`),
  CONSTRAINT `FK_t_goods_sku` FOREIGN KEY (`goodsid`) REFERENCES `t_goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_sku` */

insert  into `t_goods_sku`(`id`,`num`,`price`,`goodsid`,`code`) values (1,123,'22.30',3,'56'),(2,95,'33.00',5,'77'),(3,44444,'555555.00',3,'66666'),(4,3333,'2222.00',3,'11111'),(5,343,'232.00',3,'323'),(6,454,'454.00',3,'4542'),(7,6666,'77777.00',3,'24535'),(8,55,'43.00',3,'343'),(9,2,'1.00',20,'01'),(10,2,'2.00',20,'02'),(11,12,'12.00',20,'000'),(12,12,'3.00',20,'ff'),(13,1,'1.00',20,'1'),(14,1,'12.00',22,'112501'),(15,1,'13.00',22,'112502'),(16,2,'14.00',22,'112503');

/*Table structure for table `t_goods_stock` */

DROP TABLE IF EXISTS `t_goods_stock`;

CREATE TABLE `t_goods_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ttime` datetime NOT NULL COMMENT '时间',
  `batch` varchar(255) DEFAULT NULL COMMENT '批次',
  `skuid` int(11) NOT NULL COMMENT '特征id',
  `num` int(11) NOT NULL COMMENT '数量',
  PRIMARY KEY (`id`),
  KEY `FK_t_goods_stock` (`skuid`),
  CONSTRAINT `FK_t_goods_stock` FOREIGN KEY (`skuid`) REFERENCES `t_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_stock` */

insert  into `t_goods_stock`(`id`,`ttime`,`batch`,`skuid`,`num`) values (1,'2016-11-07 15:12:16','',1,6),(2,'2016-11-07 15:13:28','',4,56),(3,'2016-11-08 10:35:27','',1,6),(4,'2016-11-08 10:35:47','',1,7),(5,'2016-11-08 10:58:02','',1,7),(6,'2016-11-08 11:06:27','',1,11),(7,'2016-11-08 11:13:48','',1,77),(8,'2016-11-08 11:17:57','',1,7),(9,'2016-11-08 11:22:14','',1,8),(10,'2016-11-08 11:53:58','',1,7),(11,'2016-11-08 11:54:45','',1,7),(12,'2016-11-08 12:04:53','',1,9),(13,'2016-11-08 14:29:43','',1,7),(14,'2016-11-08 14:44:34','',1,6),(15,'2016-11-08 14:44:48','',1,43),(16,'2016-11-08 15:19:59','',1,66),(17,'2016-11-08 17:44:06','',2,89);

/*Table structure for table `t_goods_supplier` */

DROP TABLE IF EXISTS `t_goods_supplier`;

CREATE TABLE `t_goods_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT '供应商名称',
  `brief` text COMMENT '供应商简介',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_supplier` */

insert  into `t_goods_supplier`(`id`,`name`,`brief`) values (5,'liupc','aaaaa1533'),(6,'liupcc','dddd'),(10,'liupcd','sssss'),(11,'ddd','aaa');

/*Table structure for table `t_goods_type` */

DROP TABLE IF EXISTS `t_goods_type`;

CREATE TABLE `t_goods_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) NOT NULL COMMENT '类型名称',
  `pid` int(11) NOT NULL COMMENT '上级类型',
  `meno` varchar(255) DEFAULT NULL COMMENT '备注',
  `isparent` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_t_goods_type` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_type` */

insert  into `t_goods_type`(`id`,`name`,`pid`,`meno`,`isparent`) values (1,'食品',0,'123',1),(2,'汽车',0,'123',1),(3,'果冻',1,'123',1),(4,'标致',2,'123',0),(5,'棉被',0,'003',0),(6,'鲜',1,NULL,1);

/*Table structure for table `t_order` */

DROP TABLE IF EXISTS `t_order`;

CREATE TABLE `t_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userid` int(11) NOT NULL COMMENT '用户id',
  `address` varchar(512) NOT NULL COMMENT '收货详细地址',
  `ordertime` datetime NOT NULL COMMENT '下单时间',
  `logisticsnum` varchar(255) DEFAULT NULL COMMENT '物流编号',
  `logistics` varchar(255) DEFAULT NULL COMMENT '物流商家',
  `state` int(11) NOT NULL COMMENT '订单状态（1、未支付2、支付未发货3、支付已发货未收货、4收货）',
  `name` varchar(255) NOT NULL COMMENT '收货人姓名',
  `phone` varchar(255) NOT NULL COMMENT '收货人电话',
  `totalprice` decimal(10,2) DEFAULT NULL,
  `memo` text,
  `ordernum` varchar(255) DEFAULT NULL COMMENT '订单号',
  `postalCode` varchar(255) DEFAULT NULL COMMENT '邮编',
  `provinceName` varchar(255) DEFAULT NULL COMMENT '省',
  `cityName` varchar(255) DEFAULT NULL COMMENT '市',
  PRIMARY KEY (`id`),
  KEY `FK_t_order` (`userid`),
  CONSTRAINT `t_order_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `t_order` */

insert  into `t_order`(`id`,`userid`,`address`,`ordertime`,`logisticsnum`,`logistics`,`state`,`name`,`phone`,`totalprice`,`memo`,`ordernum`,`postalCode`,`provinceName`,`cityName`) values (1,3,'啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊','2016-11-04 11:30:34','32233','23223',1,'2332','23232','11.00',NULL,NULL,NULL,NULL,NULL),(7,1,'福建','2016-11-30 10:53:29',NULL,NULL,1,'lm','15750845026','25.00','备注备注备注备注备注备注备注备注备注备注备注备注','25148047440728725',NULL,NULL,NULL),(8,1,'福建','2016-11-30 15:10:19',NULL,NULL,1,'lm','15750845026','25.00','','89148048981921989',NULL,NULL,NULL),(9,1,'福建','2016-11-30 15:28:12',NULL,NULL,4,'lm','15750845026','2.00','','30148049089269730',NULL,NULL,NULL),(10,1,'福建','2016-11-30 19:07:05',NULL,NULL,0,'lm','15750845026','4.00','','41148050402566841',NULL,NULL,NULL),(11,1,'福建','2016-11-30 20:28:19',NULL,NULL,1,'lm','15750845026','4.00','','57148050889919657',NULL,NULL,NULL),(12,1,'','2016-12-09 16:47:49',NULL,NULL,1,'','','28.00','','03148127326933203',NULL,NULL,NULL);

/*Table structure for table `t_order_detail` */

DROP TABLE IF EXISTS `t_order_detail`;

CREATE TABLE `t_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orderid` int(11) NOT NULL COMMENT '订单id',
  `skuid` int(11) NOT NULL COMMENT '商品sku',
  `num` int(11) NOT NULL COMMENT '商品数量',
  `price` decimal(10,2) NOT NULL COMMENT '商品单价',
  `totalprice` decimal(10,2) NOT NULL COMMENT '商品总价',
  PRIMARY KEY (`id`),
  KEY `FK_t_order_detail` (`orderid`),
  KEY `FK_t_order_detail2` (`skuid`),
  CONSTRAINT `FK_t_order_detail` FOREIGN KEY (`orderid`) REFERENCES `t_order` (`id`),
  CONSTRAINT `FK_t_order_detail2` FOREIGN KEY (`skuid`) REFERENCES `t_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `t_order_detail` */

insert  into `t_order_detail`(`id`,`orderid`,`skuid`,`num`,`price`,`totalprice`) values (1,7,16,1,'14.00','14.00'),(2,7,9,2,'1.00','2.00'),(3,7,3,3,'3.00','9.00'),(4,8,16,1,'14.00','14.00'),(5,8,9,2,'1.00','2.00'),(6,8,3,3,'3.00','9.00'),(7,9,9,2,'1.00','2.00'),(8,10,9,2,'2.00','4.00'),(9,11,2,2,'2.00','2.00'),(10,12,16,1,'14.00','14.00'),(11,12,16,1,'14.00','14.00');

/*Table structure for table `t_reply` */

DROP TABLE IF EXISTS `t_reply`;

CREATE TABLE `t_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skey` varchar(255) NOT NULL,
  `reply` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_reply` */

/*Table structure for table `t_system` */

DROP TABLE IF EXISTS `t_system`;

CREATE TABLE `t_system` (
  `id` int(11) NOT NULL COMMENT 'id',
  `skey` varchar(255) NOT NULL COMMENT 'key',
  `sysvalue` text COMMENT 'sysvalue',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_system` */

/*Table structure for table `t_token` */

DROP TABLE IF EXISTS `t_token`;

CREATE TABLE `t_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accessToken` varchar(1024) NOT NULL COMMENT 'token',
  `expiresIn` int(11) NOT NULL COMMENT '有效期',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_token` */

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '11',
  `openid` varchar(255) NOT NULL COMMENT 'openid',
  `regtime` datetime DEFAULT NULL COMMENT '注册时间',
  `pid` int(11) DEFAULT NULL COMMENT '上级用户',
  `money` decimal(10,2) NOT NULL COMMENT '可提现财富金额',
  PRIMARY KEY (`id`),
  KEY `FK_t_user` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`openid`,`regtime`,`pid`,`money`) values (1,'111',NULL,0,'1111.00'),(2,'22',NULL,0,'22.00'),(3,'22222',NULL,1,'22222.00'),(4,'111',NULL,1,'1111.00'),(5,'33333',NULL,3,'2222.00'),(6,'2222',NULL,3,'2222.00');

/*Table structure for table `t_withdraw_cash` */

DROP TABLE IF EXISTS `t_withdraw_cash`;

CREATE TABLE `t_withdraw_cash` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(255) DEFAULT NULL,
  `cashtime` datetime NOT NULL COMMENT '提现时间',
  `cashnum` varchar(255) NOT NULL COMMENT '提现编号',
  `money` decimal(10,2) NOT NULL COMMENT '提现金额',
  `userid` int(11) NOT NULL COMMENT '提现人员',
  `state` int(11) NOT NULL COMMENT '提现状态',
  PRIMARY KEY (`id`),
  KEY `FK_t_withdraw_cash` (`userid`),
  CONSTRAINT `t_withdraw_cash_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_withdraw_cash` */

insert  into `t_withdraw_cash`(`id`,`username`,`cashtime`,`cashnum`,`money`,`userid`,`state`) values (1,NULL,'2016-12-01 15:35:21','1212122121','1.00',1,1),(2,NULL,'2016-12-01 15:35:47','12121','4.00',1,1),(3,NULL,'2016-12-02 10:39:11','96148064635154996','12.00',1,0),(9,NULL,'2016-12-02 11:18:53','53148064873399653','333.00',1,0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
