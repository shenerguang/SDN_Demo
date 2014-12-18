-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 05 月 18 日 14:54
-- 服务器版本: 5.5.35
-- PHP 版本: 5.4.6-1ubuntu1.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `meshsr`
--

-- --------------------------------------------------------

--
-- 表的结构 `flowEntry`
--

CREATE TABLE IF NOT EXISTS `flowEntry` (
  `flowEntryID` int(11) NOT NULL,
  `flowID` int(11) NOT NULL,
  `flowSeqNum` int(11) NOT NULL,
  `dpid` char(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tableID` int(11) NOT NULL,
  `entryID` int(11) NOT NULL,
  `inPort` int(11) NOT NULL,
  `outPort` int(11) NOT NULL,
  `meterID` int(11) NOT NULL,
  `meterValue` int(11) NOT NULL,
  PRIMARY KEY (`flowEntryID`),
  KEY `dpid` (`dpid`),
  KEY `inPort` (`inPort`),
  KEY `outPort` (`outPort`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `meshsr_connection`
--

CREATE TABLE IF NOT EXISTS `meshsr_connection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flow_info` varchar(50) NOT NULL DEFAULT '',
  `connect_info` text NOT NULL,
  `des` text NOT NULL,
  `control_node` text NOT NULL,
  KEY `ID` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- 表的结构 `meshsr_node`
--

CREATE TABLE IF NOT EXISTS `meshsr_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` char(16) NOT NULL,
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `des` varchar(255) NOT NULL DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1683 ;

-- --------------------------------------------------------

--
-- 表的结构 `phyLink`
--

CREATE TABLE IF NOT EXISTS `phyLink` (
  `phyLinkID` int(11) NOT NULL AUTO_INCREMENT,
  `srcPort` int(11) NOT NULL,
  `dstPort` int(11) NOT NULL,
  PRIMARY KEY (`phyLinkID`),
  KEY `srcPort` (`srcPort`),
  KEY `dstPort` (`dstPort`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- 表的结构 `ports`
--

CREATE TABLE IF NOT EXISTS `ports` (
  `portID` int(11) NOT NULL AUTO_INCREMENT,
  `dpid` char(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ethX',
  `MAC` varchar(20) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '00:00:00:00:00:00',
  `number` int(11) NOT NULL,
  PRIMARY KEY (`portID`),
  KEY `dpid` (`dpid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

-- --------------------------------------------------------

--
-- 表的结构 `serverNIC`
--

CREATE TABLE IF NOT EXISTS `serverNIC` (
  `serNICID` char(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FFFFFFFFFFFFFFFF',
  `peer` int(11) NOT NULL,
  `MAC` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`serNICID`),
  KEY `peer` (`peer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `switches`
--

CREATE TABLE IF NOT EXISTS `switches` (
  `dpid` char(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dpid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- 限制导出的表
--

--
-- 限制表 `flowEntry`
--
ALTER TABLE `flowEntry`
  ADD CONSTRAINT `flowEntry_ibfk_1` FOREIGN KEY (`inPort`) REFERENCES `ports` (`portID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `flowEntry_ibfk_2` FOREIGN KEY (`outPort`) REFERENCES `ports` (`portID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `flowEntry_ibfk_3` FOREIGN KEY (`dpid`) REFERENCES `switches` (`dpid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `phyLink`
--
ALTER TABLE `phyLink`
  ADD CONSTRAINT `phyLink_ibfk_1` FOREIGN KEY (`srcPort`) REFERENCES `ports` (`portID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `phyLink_ibfk_2` FOREIGN KEY (`dstPort`) REFERENCES `ports` (`portID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `ports`
--
ALTER TABLE `ports`
  ADD CONSTRAINT `ports_ibfk_1` FOREIGN KEY (`dpid`) REFERENCES `switches` (`dpid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `serverNIC`
--
ALTER TABLE `serverNIC`
  ADD CONSTRAINT `serverNIC_ibfk_1` FOREIGN KEY (`peer`) REFERENCES `ports` (`portID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
