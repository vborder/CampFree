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
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (1, 'admin', 'admin', 'admin', 1, '2020-01-11T07:32:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (2, 'outlier', 'outlier', 'user', 1, '2020-03-12T08:32:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (3, 'sgoodman', 'sgoodman', 'user', 1, '2020-03-13T09:22:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (4, 'radmax', 'radmax', 'user', 1, '2020-02-14T10:12:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (5, 'gijane', 'armyjane', 'user', 1, '2020-03-15T11:52:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (6, 'dobberman', 'dobberman', 'user', 1, '2020-02-16T13:42:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `state`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (1, 'CO', 'Colorado');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (2, 'AL', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (3, 'AK', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (4, 'AZ', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (5, 'AR', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (6, 'CA', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (7, 'CT', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (8, 'DE', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (9, 'FL', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (10, 'GA', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (11, 'HI', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (12, 'ID', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (13, 'IL', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (14, 'IN', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (15, 'IA', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (16, 'KS', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (17, 'KY', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (18, 'LA', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (19, 'ME', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (20, 'MD', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (21, 'MA', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (22, 'MI', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (23, 'MN', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (24, 'MS', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (25, 'MO', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (26, 'MT', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (27, 'NE', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (28, 'NV', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (29, 'NH', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (30, 'NJ', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (31, 'NM', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (32, 'NY', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (33, 'NC', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (34, '34', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (35, 'OH', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (36, 'OK', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (37, 'OR', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (38, 'PA', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (39, 'RI', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (40, 'SC', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (41, 'SD', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (42, 'TN', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (43, 'TX', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (44, 'UT', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (45, 'VT', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (46, 'VA', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (47, 'WA', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (48, 'WV', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (49, 'WI', NULL);
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (50, 'WY', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `person`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (1, 'adminguy@gmail.com', 'Steven', 'Pinker', '1', 1, 1, 'Just a camper trying to find great sites');
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (2, 'msadwell@gmail.com', 'Malcom', 'Sadwell', '2', 2, 1, 'Exploring an alternative lifestyle');
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (3, 'breakinggood@gmail.com', 'Jimmy', 'McGill', '3', 3, 1, 'I like to get away from it all when I can');
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (4, 'maxrota@gmail.com', 'Max', 'Rockatansky', '4', 4, 1, 'I like to live the DISPERSED way whenever I can to prepre for the apocalypse');
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (5, 'sweave@hotmail.com', 'Sigourney', 'Weaver', '5', 5, 1, 'Dispersed camping reminds me a lot of my time in the military');
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (6, 'bdobbs@gmail.com', 'Bob', 'Dobbs', '6', 6, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `campsite`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (1, 'Ute Creek', 'Colorado', 37.76053, -107.34258, 1, 1, '2020-05-27T08:12:00', 1, 'https://www.pexels.com/photo/six-camping-tents-in-forest-699558/');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (2, 'Youngs Creek Reservoir', 'Colorado', 39.044479, -107.918747, 1, 2, '2020-04-15T010:22:00', 1, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (3, 'South Sandy', 'Alabama', 32.99349, -87.4912, 1, 3, '2020-03-01T07:32:00', 2, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (4, 'Barbour', 'Alabama', 31.994413, -85.453735, 1, 4, '2020-03-02T07:42:00', 2, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (5, '48 Mile Pond', 'Alaska', 64.996343, -146.221376, 1, 5, '2020-03-08T07:52:00', 3, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (6, '224 George Parks Hwy', 'Alaska', 63.540637, -148.806493, 1, 5, '2020-03-22T07:02:00', 3, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (7, 'Young Road FR512 South', 'Arizona', 34.28276, -110.85795, 1, 2, '2020-03-03T09:12:00', 4, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (8, 'Agua Fria NM - Bloody Basin Road', 'Arizona', 34.232881, -112.021196, 1, 4, '2020-03-03T10:22:00', 4, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (9, 'Woolum Camping Area', 'Arkansas', 35.971295, -92.885251, 1, 2, '2020-03-03T07:32:00', 5, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (10, 'Bear Creek', 'Arkansas', 35.66917, -93.23378, 1, 4, '2020-03-04T07:42:00', 5, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (11, 'Old Station', 'California', 40.589191, -121.539539, 1, 3, '2020-03-05T07:12:00', 6, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (12, 'Aikens Creek West Campground', 'California', 41.228918, -123.654428, 1, 2, '2020-03-06T07:12:00', 6, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (13, 'Foxwoods Resort and Casino', 'Connecticut', 41.473915, -71.960828, 1, 1, '2020-03-11T07:12:00', 7, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (14, 'Redden State Forest', 'Delaware', 38.735557, -75.40226, 1, 2, '2020-03-12T08:12:00', 8, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (15, 'Royal Farms', 'Delaware', 39.43885, -75.7479, 1, 4, '2020-03-13T08:12:00', 8, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (16, 'Alafia River Corridor', 'Florida', 27.87277, -82.11621, 1, 3, '2020-03-14T08:12:00', 9, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (17, 'Grasshopper Pond', 'Florida', 29.130385, -81.618435, 1, 3, '2020-03-12T08:12:00', 9, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (18, 'Woody Gap', 'Georgia', 34.677713, -83.999732, 1, 4, '2020-03-13T08:12:00', 10, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (19, 'Concord Hunt Camp', 'Georgia', 33.290993, -83.806229, 1, 1, '2020-03-14T08:12:00', 10, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (20, 'Hale O Lono', 'Hawaii', 21.086963, -157.24901, 1, 4, '2020-03-16T08:12:00', 11, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (21, '33 Mile', 'Idaho', 45.023238, -115.92864, 1, 3, '2020-03-17T08:12:00', 12, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (22, 'Baker Creek Camping Area', 'Idaho', 43.768377, -114.562593, 1, 5, '2020-03-18T08:12:00', 12, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (23, 'Shawnee Forest - Gullet Ridge', 'Illinois', 37.427639, -88.535713, 1, 2, '2020-03-19T10:12:00', 13, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (24, 'Kaolin Pit Pond', 'Illinois', 37.512442, -89.304523, 1, 5, '2020-03-20T10:12:00', 13, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (25, 'Berry Ridge Road', 'Indiana', 39.063778, -89.304523, 1, 5, '2020-03-20T10:12:00', 14, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (26, 'Buzzard Roost Recreation Area', 'Indiana', 38.1215, -86.4639, 1, 1, '2020-03-22T10:12:00', 14, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (27, 'Beaver Roadside Park', 'Iowa', 42.471381, -92.770188, 1, 4, '2020-03-23T10:12:00', 15, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (28, 'Cedar River', 'Iowa', 42.06851, -91.783696, 1, 4, '2020-03-24T10:12:00', 15, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (29, 'Bourbon State Fishing Lake', 'Kansas', 37.796513, -95.068082, 1, 2, '2020-03-25T10:12:00', 16, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (30, 'Neosho State Fishing Lake', 'Kansas', 37.422293, -95.196819, 1, 2, '2020-03-26T010:12:00', 16, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (31, 'Chimney Top Rock Road', 'Kentucky', 37.82137, -83.615586, 1, 1, '2020-03-27T10:12:00', 17, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (32, 'Hattie Park', 'Kentucky', 38.84717, -84.7782, 1, 1, '2020-03-28T10:12:00', 17, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (33, 'Attakapas WMMA', 'Louisiana', 29.879585, -91.456039, 1, 5, '2020-03-29T10:12:00', 18, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (34, 'Boeuf WMA - Tempelton Bend', 'Louisiana', 32.139331, -91.970526, 1, 5, '2020-03-30T10:12:00', 18, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (35, 'Ashland Boat Launch', 'Maine', 46.632347, -68.416637, 1, 6, '2020-03-31T10:12:00', 19, NULL);
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (36, 'Chain of Ponds', 'Maine', 45.335733, -70.659587, 1, 6, '2020-04-01T10:12:00', 19, NULL);

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

