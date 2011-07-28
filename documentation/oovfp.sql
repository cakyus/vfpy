SET NAMES utf8;
SET foreign_key_checks = 0;
SET time_zone = 'SYSTEM';

DROP DATABASE IF EXISTS `oovfp`;
CREATE DATABASE `oovfp` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_bin */;
USE `oovfp`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `Username` char(32) collate latin1_bin NOT NULL,
  `Password` char(32) collate latin1_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;


