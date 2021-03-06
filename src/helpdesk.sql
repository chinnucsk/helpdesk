SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `helpdesk` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `helpdesk` ;

-- -----------------------------------------------------
-- Table `helpdesk`.`cl_user_right`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`cl_user_right` (
  `id` INT(11) NOT NULL ,
  `model` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `right_read` INT(11) NULL DEFAULT NULL ,
  `right_write` INT(11) NULL DEFAULT NULL ,
  `right_insert` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `right_delete` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`cl_users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`cl_users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `password` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `depart_id` INT(11) NULL DEFAULT NULL ,
  `full_name` VARCHAR(65) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `telephone` VARCHAR(65) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`comments`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`comments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `request_id` INT(11) NULL DEFAULT NULL ,
  `note` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `cl_user_id` INT(11) NULL DEFAULT NULL ,
  `depart_id` INT(11) NULL DEFAULT NULL ,
  `creation_time` DATETIME NULL DEFAULT NULL ,
  `change_time` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 45
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`counters`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`counters` (
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL ,
  `value` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`departs`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`departs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `note` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `creation_time` DATETIME NULL DEFAULT NULL ,
  `change_time` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`inbox`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`inbox` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `number` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL DEFAULT '' ,
  `smsdate` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `insertdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `text` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `phone` TINYINT(4) NULL DEFAULT NULL ,
  `processed` TINYINT(4) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`messages`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`messages` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `text` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `nickname` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `message_time` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`multipartinbox`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`multipartinbox` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `number` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL DEFAULT '' ,
  `smsdate` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `insertdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `text` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `phone` TINYINT(4) NULL DEFAULT NULL ,
  `processed` TINYINT(4) NOT NULL DEFAULT '0' ,
  `refnum` INT(8) NULL DEFAULT NULL ,
  `maxnum` INT(8) NULL DEFAULT NULL ,
  `curnum` INT(8) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`outbox`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`outbox` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `number` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL DEFAULT '' ,
  `processed_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `insertdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `text` VARCHAR(160) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `phone` TINYINT(4) NULL DEFAULT NULL ,
  `processed` TINYINT(4) NOT NULL DEFAULT '0' ,
  `error` TINYINT(4) NOT NULL DEFAULT '-1' ,
  `dreport` TINYINT(4) NOT NULL DEFAULT '0' ,
  `not_before` TIME NOT NULL DEFAULT '00:00:00' ,
  `not_after` TIME NOT NULL DEFAULT '23:59:59' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`requests`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`requests` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `cl_user_id` INT(11) NULL DEFAULT NULL ,
  `status` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `depart_id` INT(11) NULL DEFAULT NULL ,
  `id_worker` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `id_order` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `creation_time` DATETIME NULL DEFAULT NULL ,
  `worker_in_time` DATETIME NULL DEFAULT NULL ,
  `worker_out_time` DATETIME NULL DEFAULT NULL ,
  `close_time` DATETIME NULL DEFAULT NULL ,
  `change_time` DATETIME NULL DEFAULT NULL ,
  `note` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 39
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `helpdesk`.`tests`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `helpdesk`.`tests` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `int_test` INT(11) NULL DEFAULT NULL ,
  `str_test` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
  `date_test_time` DATETIME NULL DEFAULT NULL ,
  `depart_id` INT(11) NULL DEFAULT NULL ,
  `birth_date` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
