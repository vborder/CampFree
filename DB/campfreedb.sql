-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema campfreedb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `campfreedb` ;

-- -----------------------------------------------------
-- Schema campfreedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `campfreedb` DEFAULT CHARACTER SET utf8 ;
USE `campfreedb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `role` VARCHAR(60) NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `state` ;

CREATE TABLE IF NOT EXISTS `state` (
  `id` INT NOT NULL,
  `abbr` VARCHAR(2) NOT NULL,
  `name` VARCHAR(60) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `person` ;

CREATE TABLE IF NOT EXISTS `person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `profile_image` VARCHAR(5000) NULL,
  `user_id` INT NOT NULL,
  `state_id` INT NOT NULL,
  `bio` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_person_user1_idx` (`user_id` ASC),
  INDEX `fk_person_state1_idx` (`state_id` ASC),
  CONSTRAINT `fk_person_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_state1`
    FOREIGN KEY (`state_id`)
    REFERENCES `state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campsite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campsite` ;

CREATE TABLE IF NOT EXISTS `campsite` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `location` TEXT NULL,
  `latitude` DECIMAL(9,6) NULL,
  `longitude` DECIMAL(9,6) NULL,
  `enabled` TINYINT NOT NULL DEFAULT '1',
  `creator_id` INT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `state_id` INT NOT NULL,
  `picture_url` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_campsite_person1_idx` (`creator_id` ASC),
  INDEX `fk_campsite_state1_idx` (`state_id` ASC),
  CONSTRAINT `fk_campsite_person1`
    FOREIGN KEY (`creator_id`)
    REFERENCES `person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campsite_state1`
    FOREIGN KEY (`state_id`)
    REFERENCES `state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment_date` DATETIME NOT NULL,
  `remark` TEXT NULL,
  `campsite_rating` INT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `campsite_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_campsite_idx` (`campsite_id` ASC),
  INDEX `fk_comment_person1_idx` (`person_id` ASC),
  CONSTRAINT `fk_comment_campsite`
    FOREIGN KEY (`campsite_id`)
    REFERENCES `campsite` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `picture` ;

CREATE TABLE IF NOT EXISTS `picture` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `campsite_id` INT NOT NULL,
  `image_url` VARCHAR(5000) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `creation_date` DATETIME NOT NULL,
  `person_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_picture_person1_idx` (`person_user_id` ASC),
  INDEX `fk_picture_campsite_idx` (`campsite_id` ASC),
  CONSTRAINT `fk_picture_campsite`
    FOREIGN KEY (`campsite_id`)
    REFERENCES `campsite` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picture_person1`
    FOREIGN KEY (`person_user_id`)
    REFERENCES `person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature` ;

CREATE TABLE IF NOT EXISTS `feature` (
  `id` INT NOT NULL,
  `name` VARCHAR(500) NOT NULL,
  `description` VARCHAR(5000) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campsite_has_feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campsite_has_feature` ;

CREATE TABLE IF NOT EXISTS `campsite_has_feature` (
  `campsite_id` INT NOT NULL,
  `feature_id` INT NOT NULL,
  PRIMARY KEY (`campsite_id`, `feature_id`),
  INDEX `fk_campsite_has_feature_feature1_idx` (`feature_id` ASC),
  INDEX `fk_campsite_has_feature_campsite1_idx` (`campsite_id` ASC),
  CONSTRAINT `fk_campsite_has_feature_campsite1`
    FOREIGN KEY (`campsite_id`)
    REFERENCES `campsite` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campsite_has_feature_feature1`
    FOREIGN KEY (`feature_id`)
    REFERENCES `feature` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS campfreeuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'campfreeuser'@'localhost' IDENTIFIED BY 'campfreeuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'campfreeuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (1, 'admin', 'admin', 'admin', 1, '2020-05-25T07:32:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `state`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (1, 'CO', 'Colorado');

COMMIT;


-- -----------------------------------------------------
-- Data for table `person`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (1, 'adminguy@gmail.com', 'Steven', 'Pinker', '1', 1, 1, 'Just a camper trying to find great sites');

COMMIT;


-- -----------------------------------------------------
-- Data for table `campsite`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (1, 'Ute Creek', 'Colorado', 37.76053, -107.34258, 1, 1, '2020-05-27T08:12:00', 1, 'https://www.pexels.com/photo/six-camping-tents-in-forest-699558/');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (1, '2020-05-26T06:14:00', 'This is one of my favorite spots.', 5, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `picture`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `picture` (`id`, `campsite_id`, `image_url`, `enabled`, `creation_date`, `person_user_id`) VALUES (1, 1, 'https://www.alltrails.com/trail/us/colorado/ute-creek-trail/photos', 1, '2020-05-27T010:12:00', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (1, 'restroom', 'clean restrooms here');

COMMIT;


-- -----------------------------------------------------
-- Data for table `campsite_has_feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `campsite_has_feature` (`campsite_id`, `feature_id`) VALUES (1, 1);

COMMIT;

