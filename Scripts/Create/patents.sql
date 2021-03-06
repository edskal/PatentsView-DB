-- --------------------------------------------------------
-- Host:                         
-- Server version:               5.6.21-log - MySQL Community Server (GPL)
-- Server OS:                    Linux
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table patent_20141201.application
CREATE TABLE IF NOT EXISTS `application` (
  `id` varchar(36) NOT NULL,
  `patent_id` varchar(20) NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`,`patent_id`),
  KEY `patent_id` (`patent_id`),
  KEY `app_idx1` (`type`,`number`),
  KEY `app_idx2` (`date`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.assignee
CREATE TABLE IF NOT EXISTS `assignee` (
  `id` varchar(36) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `name_first` varchar(64) DEFAULT NULL,
  `name_last` varchar(64) DEFAULT NULL,
  `organization` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.claim
CREATE TABLE IF NOT EXISTS `claim` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `text` text,
  `dependent` int(11) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_claim_sequence` (`sequence`),
  CONSTRAINT `claim_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.cpc_current
CREATE TABLE IF NOT EXISTS `cpc_current` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `section_id` varchar(10) DEFAULT NULL,
  `subsection_id` varchar(20) DEFAULT NULL,
  `group_id` varchar(20) DEFAULT NULL,
  `subgroup_id` varchar(20) DEFAULT NULL,
  `category` varchar(36) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `subsection_id` (`subsection_id`),
  KEY `group_id` (`group_id`),
  KEY `subgroup_id` (`subgroup_id`),
  KEY `ix_cpc_current_sequence` (`sequence`),
  CONSTRAINT `cpc_current_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `cpc_current_ibfk_2` FOREIGN KEY (`subsection_id`) REFERENCES `cpc_subsection` (`id`),
  CONSTRAINT `cpc_current_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `cpc_group` (`id`),
  CONSTRAINT `cpc_current_ibfk_4` FOREIGN KEY (`subgroup_id`) REFERENCES `cpc_subgroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.cpc_group
CREATE TABLE IF NOT EXISTS `cpc_group` (
  `id` varchar(20) NOT NULL,
  `title` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.cpc_subgroup
CREATE TABLE IF NOT EXISTS `cpc_subgroup` (
  `id` varchar(20) NOT NULL,
  `title` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.cpc_subsection
CREATE TABLE IF NOT EXISTS `cpc_subsection` (
  `id` varchar(20) NOT NULL,
  `title` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.foreigncitation
CREATE TABLE IF NOT EXISTS `foreigncitation` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  CONSTRAINT `foreigncitation_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.inventor
CREATE TABLE IF NOT EXISTS `inventor` (
  `id` varchar(36) NOT NULL,
  `name_first` varchar(64) DEFAULT NULL,
  `name_last` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.ipcr
CREATE TABLE IF NOT EXISTS `ipcr` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `classification_level` varchar(20) DEFAULT NULL,
  `section` varchar(20) DEFAULT NULL,
  `ipc_class` varchar(20) DEFAULT NULL,
  `subclass` varchar(20) DEFAULT NULL,
  `main_group` varchar(20) DEFAULT NULL,
  `subgroup` varchar(20) DEFAULT NULL,
  `symbol_position` varchar(20) DEFAULT NULL,
  `classification_value` varchar(20) DEFAULT NULL,
  `classification_status` varchar(20) DEFAULT NULL,
  `classification_data_source` varchar(20) DEFAULT NULL,
  `action_date` date DEFAULT NULL,
  `ipc_version_indicator` date DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_ipcr_sequence` (`sequence`),
  KEY `ix_ipcr_action_date` (`action_date`),
  KEY `ix_ipcr_ipc_version_indicator` (`ipc_version_indicator`),
  CONSTRAINT `ipcr_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.lawyer
CREATE TABLE IF NOT EXISTS `lawyer` (
  `id` varchar(36) NOT NULL,
  `name_first` varchar(64) DEFAULT NULL,
  `name_last` varchar(64) DEFAULT NULL,
  `organization` varchar(64) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.location
CREATE TABLE IF NOT EXISTS `location` (
  `id` varchar(128) NOT NULL,
  `city` varchar(128) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_location_country` (`country`),
  KEY `dloc_idx2` (`city`,`state`,`country`),
  KEY `dloc_idx1` (`latitude`,`longitude`),
  KEY `ix_location_state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.location_assignee
CREATE TABLE IF NOT EXISTS `location_assignee` (
  `location_id` varchar(128) DEFAULT NULL,
  `assignee_id` varchar(36) DEFAULT NULL,
  KEY `location_id` (`location_id`),
  KEY `assignee_id` (`assignee_id`),
  CONSTRAINT `location_assignee_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `location_assignee_ibfk_2` FOREIGN KEY (`assignee_id`) REFERENCES `assignee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.location_inventor
CREATE TABLE IF NOT EXISTS `location_inventor` (
  `location_id` varchar(128) DEFAULT NULL,
  `inventor_id` varchar(36) DEFAULT NULL,
  KEY `location_id` (`location_id`),
  KEY `inventor_id` (`inventor_id`),
  CONSTRAINT `location_inventor_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `location_inventor_ibfk_2` FOREIGN KEY (`inventor_id`) REFERENCES `inventor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.mainclass
CREATE TABLE IF NOT EXISTS `mainclass` (
  `id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.mainclass_current
CREATE TABLE IF NOT EXISTS `mainclass_current` (
  `id` varchar(20) NOT NULL,
  `title` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.otherreference
CREATE TABLE IF NOT EXISTS `otherreference` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `text` text,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  CONSTRAINT `otherreference_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.patent
CREATE TABLE IF NOT EXISTS `patent` (
  `id` varchar(20) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `abstract` text,
  `title` text,
  `kind` varchar(10) DEFAULT NULL,
  `num_claims` int(11) DEFAULT NULL,
  `filename` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pat_idx1` (`type`,`number`),
  KEY `pat_idx2` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.patent_assignee
CREATE TABLE IF NOT EXISTS `patent_assignee` (
  `patent_id` varchar(20) DEFAULT NULL,
  `assignee_id` varchar(36) DEFAULT NULL,
  KEY `patent_id` (`patent_id`),
  KEY `assignee_id` (`assignee_id`),
  CONSTRAINT `patent_assignee_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `patent_assignee_ibfk_2` FOREIGN KEY (`assignee_id`) REFERENCES `assignee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.patent_inventor
CREATE TABLE IF NOT EXISTS `patent_inventor` (
  `patent_id` varchar(20) DEFAULT NULL,
  `inventor_id` varchar(36) DEFAULT NULL,
  KEY `patent_id` (`patent_id`),
  KEY `inventor_id` (`inventor_id`),
  CONSTRAINT `patent_inventor_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `patent_inventor_ibfk_2` FOREIGN KEY (`inventor_id`) REFERENCES `inventor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.patent_lawyer
CREATE TABLE IF NOT EXISTS `patent_lawyer` (
  `patent_id` varchar(20) DEFAULT NULL,
  `lawyer_id` varchar(36) DEFAULT NULL,
  KEY `patent_id` (`patent_id`),
  KEY `lawyer_id` (`lawyer_id`),
  CONSTRAINT `patent_lawyer_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `patent_lawyer_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.rawassignee
CREATE TABLE IF NOT EXISTS `rawassignee` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `assignee_id` varchar(36) DEFAULT NULL,
  `rawlocation_id` varchar(128) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `name_first` varchar(64) DEFAULT NULL,
  `name_last` varchar(64) DEFAULT NULL,
  `organization` varchar(128) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `assignee_id` (`assignee_id`),
  KEY `rawlocation_id` (`rawlocation_id`),
  KEY `ix_rawassignee_sequence` (`sequence`),
  CONSTRAINT `rawassignee_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `rawassignee_ibfk_2` FOREIGN KEY (`assignee_id`) REFERENCES `assignee` (`id`),
  CONSTRAINT `rawassignee_ibfk_3` FOREIGN KEY (`rawlocation_id`) REFERENCES `rawlocation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.rawinventor
CREATE TABLE IF NOT EXISTS `rawinventor` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `inventor_id` varchar(36) DEFAULT NULL,
  `rawlocation_id` varchar(128) DEFAULT NULL,
  `name_first` varchar(64) DEFAULT NULL,
  `name_last` varchar(64) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `inventor_id` (`inventor_id`),
  KEY `rawlocation_id` (`rawlocation_id`),
  KEY `ix_rawinventor_sequence` (`sequence`),
  CONSTRAINT `rawinventor_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `rawinventor_ibfk_2` FOREIGN KEY (`inventor_id`) REFERENCES `inventor` (`id`),
  CONSTRAINT `rawinventor_ibfk_3` FOREIGN KEY (`rawlocation_id`) REFERENCES `rawlocation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.rawlawyer
CREATE TABLE IF NOT EXISTS `rawlawyer` (
  `uuid` varchar(36) NOT NULL,
  `lawyer_id` varchar(36) DEFAULT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `name_first` varchar(64) DEFAULT NULL,
  `name_last` varchar(64) DEFAULT NULL,
  `organization` varchar(64) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `lawyer_id` (`lawyer_id`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_rawlawyer_sequence` (`sequence`),
  CONSTRAINT `rawlawyer_ibfk_1` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyer` (`id`),
  CONSTRAINT `rawlawyer_ibfk_2` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.rawlocation
CREATE TABLE IF NOT EXISTS `rawlocation` (
  `id` varchar(128) NOT NULL,
  `location_id` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `loc_idx1` (`city`,`state`,`country`),
  KEY `ix_rawlocation_state` (`state`),
  KEY `ix_rawlocation_country` (`country`),
  CONSTRAINT `rawlocation_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.subclass
CREATE TABLE IF NOT EXISTS `subclass` (
  `id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.subclass_current
CREATE TABLE IF NOT EXISTS `subclass_current` (
  `id` varchar(20) NOT NULL,
  `title` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.temporary_update
CREATE TABLE IF NOT EXISTS `temporary_update` (
  `pk` varchar(36) NOT NULL,
  `update` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `ix_temporary_update_update` (`update`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.usapplicationcitation
CREATE TABLE IF NOT EXISTS `usapplicationcitation` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `application_id` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `kind` varchar(10) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_usapplicationcitation_application_id` (`application_id`),
  CONSTRAINT `usapplicationcitation_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.uspatentcitation
CREATE TABLE IF NOT EXISTS `uspatentcitation` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `citation_id` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `kind` varchar(10) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_uspatentcitation_citation_id` (`citation_id`),
  CONSTRAINT `uspatentcitation_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.uspc
CREATE TABLE IF NOT EXISTS `uspc` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `mainclass_id` varchar(20) DEFAULT NULL,
  `subclass_id` varchar(20) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `mainclass_id` (`mainclass_id`),
  KEY `subclass_id` (`subclass_id`),
  KEY `ix_uspc_sequence` (`sequence`),
  CONSTRAINT `uspc_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `uspc_ibfk_2` FOREIGN KEY (`mainclass_id`) REFERENCES `mainclass` (`id`),
  CONSTRAINT `uspc_ibfk_3` FOREIGN KEY (`subclass_id`) REFERENCES `subclass` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.uspc_current
CREATE TABLE IF NOT EXISTS `uspc_current` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `mainclass_id` varchar(20) DEFAULT NULL,
  `subclass_id` varchar(20) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `mainclass_id` (`mainclass_id`),
  KEY `subclass_id` (`subclass_id`),
  KEY `ix_uspc_current_sequence` (`sequence`),
  CONSTRAINT `uspc_current_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `uspc_current_ibfk_2` FOREIGN KEY (`mainclass_id`) REFERENCES `mainclass_current` (`id`),
  CONSTRAINT `uspc_current_ibfk_3` FOREIGN KEY (`subclass_id`) REFERENCES `subclass_current` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table patent_20141201.usreldoc
CREATE TABLE IF NOT EXISTS `usreldoc` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `rel_id` varchar(20) DEFAULT NULL,
  `doctype` varchar(64) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `kind` varchar(10) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `relationship` varchar(64) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_usreldoc_country` (`country`),
  KEY `ix_usreldoc_doctype` (`doctype`),
  KEY `ix_usreldoc_date` (`date`),
  KEY `ix_usreldoc_rel_id` (`rel_id`),
  KEY `ix_usreldoc_sequence` (`sequence`),
  KEY `ix_usreldoc_number` (`number`),
  CONSTRAINT `usreldoc_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
