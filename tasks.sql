/*
Navicat MySQL Data Transfer

Source Server         : my_local
Source Server Version : 50511
Source Host           : 127.0.0.1:3306
Source Database       : taskmanager

Target Server Type    : MYSQL
Target Server Version : 50511
File Encoding         : 65001

Date: 2016-12-27 23:25:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `finished` bit(1) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tasks
-- ----------------------------
INSERT INTO `tasks` VALUES ('3', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('5', '2016-12-27 22:55:46', '22', '\0', '22');
INSERT INTO `tasks` VALUES ('7', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('9', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('11', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('13', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('15', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('17', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('19', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('21', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('23', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('25', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('27', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('29', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('31', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('33', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('35', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('37', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('39', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('41', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('43', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('45', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('47', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('49', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('51', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('53', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('55', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('57', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('59', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('61', '2016-12-27 22:55:51', '11', '\0', '11');
INSERT INTO `tasks` VALUES ('63', '2016-12-27 22:55:51', '11', '\0', '11');
