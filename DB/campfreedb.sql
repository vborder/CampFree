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
  `description` VARCHAR(5000) NULL,
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
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (1, 'admin', '$2a$10$mRgGZXvX5bOZxEkoojcajuflgAYXSB9x1v.CJ8puIrQq12OtcBq5O', 'admin', 1, '2020-01-11T07:32:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (2, 'outlier', '$2a$10$jQvnReudo1FNuxLAYSibkOWxQHgZ1NxMjYG5jt5vMq5DGrBLP96Qm', 'user', 1, '2020-03-12T08:32:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (3, 'sgoodman', '$2a$10$9CnkfPVlewtTofMGCh7X8OYlpeRx3bNrCdfeVRSqZFYN16BibWwhq', 'user', 1, '2020-03-13T09:22:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (4, 'radmax', '$2a$10$ajXggAS/YzQAlomkQGWI/ezhv0DchsgrCkoyMlbyuhZ7jwuI1MnZi', 'user', 1, '2020-02-14T10:12:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (5, 'gijane', '$2a$10$ADA1QlFpjkaXQavAZoXY..JrFxl6/PyYW8fioXX3XiOgSxUKIYVS2', 'user', 1, '2020-03-15T11:52:00');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `enabled`, `creation_date`) VALUES (6, 'dobberman', '$2a$10$Ja48l6C9ziXYUAuZMHegwOi2mTr5pdieGrT4Qi7k.8cLN2gxqI.VK', 'user', 1, '2020-02-16T13:42:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `state`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (1, 'CO', 'Colorado');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (2, 'AL', 'Alabama');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (3, 'AK', 'Alaska');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (4, 'AZ', 'Arizona');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (5, 'AR', 'Arkansas');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (6, 'CA', 'California');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (7, 'CT', 'Connecticut');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (8, 'DE', 'Delaware');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (9, 'FL', 'Florida');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (10, 'GA', 'Georgia');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (11, 'HI', 'Hawaii');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (12, 'ID', 'Idaho');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (13, 'IL', 'Illinois');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (14, 'IN', 'Indiana');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (15, 'IA', 'Iowa');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (16, 'KS', 'Kansas');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (17, 'KY', 'Kentucky');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (18, 'LA', 'Louisiana');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (19, 'ME', 'Maine');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (20, 'MD', 'Maryland');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (21, 'MA', 'Massachusetts');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (22, 'MI', 'Michigan');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (23, 'MN', 'Minnesota');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (24, 'MS', 'Mississippi');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (25, 'MO', 'Missouri');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (26, 'MT', 'Montana');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (27, 'NE', 'Nebraska');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (28, 'NV', 'Nevada');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (29, 'NH', 'New Hampshire');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (30, 'NJ', 'New Jersey');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (31, 'NM', 'New Mexico');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (32, 'NY', 'New York');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (33, 'NC', 'North Carolina');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (34, 'ND', 'North Dakota');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (35, 'OH', 'Ohio');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (36, 'OK', 'Oklahoma');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (37, 'OR', 'Oregon');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (38, 'PA', 'Pennsylvania');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (39, 'RI', 'Rhode Island');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (40, 'SC', 'South Carolina');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (41, 'SD', 'South Dakota');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (42, 'TN', 'Tennesse');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (43, 'TX', 'Texas');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (44, 'UT', 'Utah');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (45, 'VT', 'Vermont');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (46, 'VA', 'Virginia');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (47, 'WA', 'Washington');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (48, 'WV', 'West Virginia');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (49, 'WI', 'Wisconsin');
INSERT INTO `state` (`id`, `abbr`, `name`) VALUES (50, 'WY', 'Wyoming');

COMMIT;


-- -----------------------------------------------------
-- Data for table `person`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (1, 'adminguy@gmail.com', 'Steven', 'Pinker', '1', 1, 1, 'Just a camper trying to find great sites');
INSERT INTO `person` (`id`, `email`, `first_name`, `last_name`, `profile_image`, `user_id`, `state_id`, `bio`) VALUES (2, 'msadwell@gmail.com', 'Malcom', 'Sadwell', 'https://previews.123rf.com/images/maridav/maridav1203/maridav120300062/12720689-young-man-hiking-smiling-happy-portrait-male-hiker-walking-in-forest-.jpg', 2, 1, 'Exploring an alternative lifestyle');
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
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (1, 'Ute Creek', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 37.76053, -107.34258, 1, 1, '2020-05-27T08:12:00', 1, 'https://3.bp.blogspot.com/-IwqSkVJQj3o/WX3fvaE-rAI/AAAAAAAAtac/CPgs79w1C4cFgiUAPAL4PY-1_6cq9XW-QCLcBGAs/s1600/Ute%2BCreek%2BCutoff%2B121.JPG');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (2, 'Youngs Creek Reservoir', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 39.044479, -107.918747, 1, 2, '2020-04-15T010:22:00', 1, 'https://www.fs.usda.gov/Internet/FSE_MEDIA/stelprd3807183.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (3, 'South Sandy', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 32.99349, -87.4912, 1, 3, '2020-03-01T07:32:00', 2, 'https://www.farmflip.com/photos/219376/south-sandy-road-tract-duncanville-tuscaloosa-county-alabama-219376-2AvzNC-XL.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (4, 'Barbour', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 31.994413, -85.453735, 1, 4, '2020-03-02T07:42:00', 2, 'https://www.rv-camping.org/wp-content/uploads/2015/07/CambridgeRVPark.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (5, '48 Mile Pond', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 64.996343, -146.221376, 1, 5, '2020-03-08T07:52:00', 3, 'http://akonthego.com/blog/wp-content/uploads/2014/09/DSCN0152-1024x768.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (6, '224 George Parks Hwy', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 63.540637, -148.806493, 1, 5, '2020-03-22T07:02:00', 3, 'https://media.arkansasonline.com/img/photos/2013/07/31/resized_99265-eagle-river-valley_38-17326_t800.JPG?90232451fbcadccc64a17de7521d859a8f88077d');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (7, 'Young Road FR512 South', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 34.28276, -110.85795, 1, 2, '2020-03-03T09:12:00', 4, 'https://thedyrt.imgix.net/photo/192480/media/arizona-valentine-ridge_b7bfc0a4e91d8394eb705ef34bb61c53.jpg?auto=format&fit=crop&ar=1%3A1&ixlib=ember-1.0.16');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (8, 'Agua Fria NM - Bloody Basin Road', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 34.232881, -112.021196, 1, 4, '2020-03-03T10:22:00', 4, 'https://upload.wikimedia.org/wikipedia/commons/2/21/Gillett-Agua_Fria_River.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (9, 'Woolum Camping Area', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 35.971295, -92.885251, 1, 2, '2020-03-03T07:32:00', 5, 'https://freecampsites.net/wp-content/uploads/2016/03/11825746_10207187870565817_6054971507284680666_n-800x600.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (10, 'Bear Creek', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 35.66917, -93.23378, 1, 4, '2020-03-04T07:42:00', 5, 'https://res.cloudinary.com/miles-extranet-dev/image/upload/w_400,h_300,c_fill,q_60/ArkansasSP/account_photos/34/7de183aef6340307ce5cbdc08825cd72_MississippiRiverSPBeaverPond2018-05KSJ_3530ps');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (11, 'Old Station', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 40.589191, -121.539539, 1, 3, '2020-03-05T07:12:00', 6, 'https://media2.trover.com/T/59961af288f1abd66900fefe/fixedw_large_2x.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (12, 'Aikens Creek West Campground', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 41.228918, -123.654428, 1, 2, '2020-03-06T07:12:00', 6, 'https://thedyrt.imgix.net/photo/177791/media/california-fish-lake_aaf68dcf339a9bebd86c873883a20008.jpg?ixlib=rb-3.1.1');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (13, 'Foxwoods Resort and Casino', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 41.473915, -71.960828, 1, 1, '2020-03-11T07:12:00', 7, 'https://www.casinocamper.com/media/reviews/photos/original/38/98/30/foxwoods-casino-4-1529273055.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (14, 'Redden State Forest', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 38.735557, -75.40226, 1, 2, '2020-03-12T08:12:00', 8, 'https://freecampsites.net/wp-content/uploads/2015/08/Cape1_2-800x600.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (15, 'Royal Farms', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 39.43885, -75.7479, 1, 4, '2020-03-13T08:12:00', 8, 'https://blog-assets.thedyrt.com/uploads/2019/04/pennsylvania-dingmans-campground_b8f9082d9161c456a5e45c063c370a36.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (16, 'Alafia River Corridor', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 27.87277, -82.11621, 1, 3, '2020-03-14T08:12:00', 9, 'https://cdn-assets.alltrails.com/fr/uploads/photo/image/26607627/extra_large_e3c2d0d1f3feebe9aa5054834ec38c58.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (17, 'Grasshopper Pond', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 29.130385, -81.618435, 1, 3, '2020-03-12T08:12:00', 9, 'https://freecampsites.net/wp-content/uploads/2019/09/ONF4-800x600.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (18, 'Woody Gap', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 34.677713, -83.999732, 1, 4, '2020-03-13T08:12:00', 10, 'https://whiteblaze.net/forum/vbg/files/2/3/7/0/9/woody_gap_camp.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (19, 'Concord Hunt Camp', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 33.290993, -83.806229, 1, 1, '2020-03-14T08:12:00', 10, 'https://freecampsites.net/wp-content/uploads/2014/09/ga_concordHC01-800x600.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (20, 'Hale O Lono', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 21.086963, -157.24901, 1, 4, '2020-03-16T08:12:00', 11, 'https://www.mauicamperrental.com/wp-content/uploads/2012/07/beach.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (21, '33 Mile', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 45.023238, -115.92864, 1, 3, '2020-03-17T08:12:00', 12, 'https://freecampsites.net/wp-content/uploads/2018/08/DBEC66CD-6C34-4FA8-A070-EA3CE8C6F75F.jpeg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (22, 'Baker Creek Camping Area', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 43.768377, -114.562593, 1, 5, '2020-03-18T08:12:00', 12, 'https://hipcamp-res.cloudinary.com/images/c_limit,f_auto,h_1200,q_60,w_1920/v1539977809/campground-photos/rmk2hquggcsnidhvzgyy/sawtooth-east-fork-baker-creek-campground.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (23, 'Shawnee Forest - Gullet Ridge', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 37.427639, -88.535713, 1, 2, '2020-03-19T10:12:00', 13, 'https://i.redd.it/l8ox6uwzvwry.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (24, 'Kaolin Pit Pond', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 37.512442, -89.304523, 1, 5, '2020-03-20T10:12:00', 13, 'https://freecampsites.net/wp-content/uploads/2018/08/0814181824.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (25, 'Berry Ridge Road', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 39.063778, -89.304523, 1, 5, '2020-03-20T10:12:00', 14, 'https://visitindiana.com/blog/wp-content/uploads/2019/08/campjellystone-Instagram-2581-ig-1839584189525960989_1741477019.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (26, 'Buzzard Roost Recreation Area', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 38.1215, -86.4639, 1, 1, '2020-03-22T10:12:00', 14, 'https://lh3.googleusercontent.com/proxy/1NLDbtru-j5Ug8C7cREvzC69Wh7xAIzT8OIOzioZRIVsRljh_ARqPCB-Y207xCpwiFIzl9ISpPsMRwQoLMdDYZivI4nFRARwtuI_qXFbFnyXwsjSozwGPEVOn0LaVEN0jLZEbOXbu3iDxT4');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (27, 'Beaver Roadside Park', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 42.471381, -92.770188, 1, 4, '2020-03-23T10:12:00', 15, 'https://media-cdn.tripadvisor.com/media/photo-s/05/07/e5/e7/roadside-park.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (28, 'Cedar River', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 42.06851, -91.783696, 1, 4, '2020-03-24T10:12:00', 15, 'https://www.hudsonvalleysojourner.com/wp-content/uploads/2016/07/Cedar-Rapids-Campgrounds-River-Trips-Tent-Sites.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (29, 'Bourbon State Fishing Lake', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 37.796513, -95.068082, 1, 2, '2020-03-25T10:12:00', 16, 'https://www.naturallyamazing.com/americasparks/10929.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (30, 'Neosho State Fishing Lake', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 37.422293, -95.196819, 1, 2, '2020-03-26T010:12:00', 16, 'https://cdn.outdoorhub.com/wp-content/uploads/sites/2/2012/05/STATE-FISHING-LAKES-OFFER-GREAT-MEMORIAL-DAY-OUTINGS_frontimagecrop.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (31, 'Chimney Top Rock Road', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 37.82137, -83.615586, 1, 1, '2020-03-27T10:12:00', 17, 'https://cdn.recreation.gov/public/images/84850.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (32, 'Hattie Park', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 38.84717, -84.7782, 1, 1, '2020-03-28T10:12:00', 17, 'https://provincialparkers.weebly.com/uploads/2/3/5/8/23587114/hattiescove1_orig.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (33, 'Attakapas WMMA', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 29.879585, -91.456039, 1, 5, '2020-03-29T10:12:00', 18, 'https://dtjew9b6f6zyn.cloudfront.net/wp-content/uploads/2017/06/sherburne.png');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (34, 'Boeuf WMA - Tempelton Bend', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 32.139331, -91.970526, 1, 5, '2020-03-30T10:12:00', 18, 'https://www.mossyoakproperties.com/images/properties/18756/Resized/18756148206.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (35, 'Ashland Boat Launch', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 46.632347, -68.416637, 1, 6, '2020-03-31T10:12:00', 19, 'https://sidecarhound.files.wordpress.com/2018/04/campsite2.jpg?w=748');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (36, 'Chain of Ponds', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 45.335733, -70.659587, 1, 6, '2020-04-01T10:12:00', 19, 'https://www.rangeley-maine.com/directory/wp-content/uploads/2014/05/10273133_242154102575016_535956728061527819_o.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (37, 'Deal Island WMA', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 38.175841, -75.910699, 1, 3, '2020-04-02T10:12:00', 20, 'https://dnr.maryland.gov/publiclands/PublishingImages/sg_campsite.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (38, 'E. A. Vaughn WMA', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 38.077881, -75.391628, 1, 3, '2020-04-03T10:12:00', 20, 'https://dtjew9b6f6zyn.cloudfront.net/wp-content/uploads/2016/05/14764283098_c91469f2da_o-700x393.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (39, 'Ashfield Lake', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 42.529324, -72.801974, 1, 4, '2020-04-04T10:12:00', 21, 'https://hipcamp-res.cloudinary.com/images/c_fill,f_auto,g_auto,h_220,q_60,w_320/v1470232628/campground-photos/spd3iid3ezjhoq53uj0t/wompatuck-wompatuck-campground.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (40, 'Blockhouse Campground', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 46.267239, -88.651428, 1, 2, '2020-04-05T10:12:00', 22, 'https://www.michigan.org/sites/default/files/uploads/2018/camping_porcupine%20mountains_pure%20michigan_0.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (41, 'High Rock Bay', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 47.426798, -87.714307, 1, 2, '2020-04-06T10:12:00', 23, 'https://www.planetware.com/photos-large/USMN/minnesota-superior-national-forest-fall-lake-campground.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (42, 'Airey Lake', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 30.688574, -89.060417, 1, 1, '2020-04-07T10:12:00', 24, 'https://nomadiclifestylemag.com/wp-content/uploads/2019/02/Miss1.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (43, 'Bienville WMA - FR 508', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 32.459441, -89.63847, 1, 1, '2020-04-08T10:12:00', 24, 'https://hipcamp-res.cloudinary.com/image/upload/c_fill,f_auto,g_auto:subject,h_300,q_auto,w_750/v1434056012/zu0zj6jx70txdfyh2tl6.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (44, 'Wrangler TH', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 36.89371, -90.549436, 1, 5, '2020-04-09T10:12:00', 25, 'https://mostateparks.com/sites/mostateparks/files/Roaring%20River%20camping.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (45, 'Wolf Creek Bend Conservation Area', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 39.930233, -95.195358, 1, 5, '2020-04-10T10:12:00', 25, 'https://mostateparks.com/sites/mostateparks/files/Wallace%20camping%203.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (46, 'Ruby River Reservoir', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 45.225639, -112.114965, 1, 3, '2020-04-11T10:12:00', 26, 'https://bigfork.org/wp-content/uploads/2018/03/bigfork-camping-576x1024.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (47, 'Abbot Bay', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 48.333851, -113.955965, 1, 3, '2020-04-12T10:12:00', 26, 'https://blog.visityellowstonecountry.com/wp-content/uploads/Camping_MTOBD.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (48, 'Blue River SRA', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 40.705338, -97.118417, 1, 4, '2020-04-13T10:12:00', 27, 'https://outdoornebraska.gov/wp-content/uploads/2018/05/rv4.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (49, 'Arcadia Diversion Dam', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 41.489951, -99.238243, 1, 4, '2020-04-14T10:12:00', 27, 'https://bloximages.newyork1.vip.townnews.com/omaha.com/content/tncms/assets/v3/editorial/a/b7/ab72d75b-4c86-58a8-8ec1-327f332f910e/5eb43dd2a6c45.image.jpg?resize=400%2C266');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (50, 'Gale River Loop Road', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 44.23984, -71.62009, 1, 2, '2020-04-15T10:12:00', 28, 'https://dtjew9b6f6zyn.cloudfront.net/wp-content/uploads/2018/08/Untitled-7.png');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (51, 'Jefferson Notch Road', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 44.314825, -71.364631, 1, 2, '2020-04-16T10:12:00', 28, 'https://dtjew9b6f6zyn.cloudfront.net/wp-content/uploads/2015/07/NV-Camp-Spot-6.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (52, 'White Mountain', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 44.147799, -71.110496, 1, 4, '2020-04-17T10:12:00', 29, 'https://blog-assets.thedyrt.com/uploads/2018/08/hancockNH.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (53, 'Old Cherry Mountain Road', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 44.283676, -71.466751, 1, 4, '2020-04-18T10:12:00', 29, 'https://www.planetware.com/wpimages/2019/05/new-hampshire-top-campgrounds-bear-brook-state-park.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (54, '127a Ski Apach', 'Cheese on toast port-salut jarlsberg chalk and cheese emmental st. agur blue cheese mozzarella cheese strings. Airedale cheesy grin.', 33.393552, -105.726513, 1, 1, '2020-04-19T10:12:00', 31, 'https://www.blm.gov/sites/blm.gov/files/nmrecactivityfocus1_photo1_550.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (55, 'Joe Skeens - El Malpais NCA', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 34.941908, -107.820155, 1, 1, '2020-04-20T10:12:00', 31, 'https://camping.campendium.com/wp-content/uploads/2017/05/oliver-lee-memorial-state-park-1.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (56, 'Allaben', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 42.109518, -74.350576, 1, 5, '2020-04-21T10:12:00', 32, 'https://cdn.newsday.com/polopoly_fs/1.19782461.1531403561!/httpImage/image.jpg_gen/derivatives/display_960/image.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (57, 'Chapel Pond', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 44.142588, -73.750566, 1, 5, '2020-04-22T10:12:00', 32, 'https://koa.com/content/campgrounds/newburgh/photos/4b3415ef-5617-4208-9452-aa8e8b4848cbphoto36ad55e4-3ae2-46f0-b7da-53f8de66b2e6.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (58, 'Yellow Gap ', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 35.38625, -82.68003, 1, 6, '2020-04-23T10:12:00', 33, 'https://townsquare.media/site/152/files/2016/07/Netting-in-tent.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (59, 'Huskins Branch Hunters Camp', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 35.087154, -83.86673, 1, 6, '2020-04-24T10:12:00', 33, 'https://www.tedderfield.com/wp-content/uploads/2017/06/Tedderfield-Conical-Mosquito-Net.w.small_.jpeg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (60, 'Audubon WMA', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 47.62574, -101.186278, 1, 4, '2020-04-25T10:12:00', 34, 'https://hipcamp-res.cloudinary.com/image/upload/c_fill,f_auto,h_300,q_60,w_300/v1456252848/campground-photos/ar3zeo4nh748mlsdgay1.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (61, 'Dogtown WMA', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 46.164106, -102.370517, 1, 4, '2020-04-26T10:12:00', 34, 'https://townsquare.media/site/505/files/2018/05/camping.jpg?w=980&q=75');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (62, 'Dorr OHV Trailhead', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 39.482675, -82.292444, 1, 2, '2020-04-27T10:12:00', 35, 'https://ohio.org/wp-content/uploads/2018/06/20180428_173621-1200x900.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (63, 'Hanging Rock', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 38.5807, -82.724234, 1, 2, '2020-04-28T10:12:00', 35, 'https://www.wksu.org/sites/wksu/files/styles/x_large/public/201907/randall_park_mall.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (64, 'Black Mesa Trailhead', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 36.957304, -102.956896, 1, 1, '2020-04-29T10:12:00', 36, 'https://media-cdn.tripadvisor.com/media/photo-s/0d/2f/ad/c0/campsite-on-honey-creek.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (65, 'Dahlonegah Park', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 35.748449, -94.664581, 1, 1, '2020-04-30T10:12:00', 36, 'https://kimnovak.me/pictures/ftworth/turnerfalls/images/05_turnerfalls.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (66, 'Rocky Butte', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 44.393448, -120.573678, 1, 3, '2020-05-01T10:12:00', 37, 'https://www.beachconnection.net/news/pacific_cove_palisade_camp.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (67, 'FR 960', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 43.09919, -122.07643, 1, 3, '2020-05-02T10:12:00', 37, 'https://centraloregondaily.com/wp-content/uploads/2020/05/Featured-image-size-template-no-background-2020-05-29T113549.979.png');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (68, 'Apache Springs / Dravo Landing', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 40.288929, -79.778169, 1, 6, '2020-05-03T10:12:00', 38, 'https://hipcamp-res.cloudinary.com/images/c_fill,f_auto,g_auto,h_220,q_60,w_320/v1500996973/campground-photos/p3xfj73evrtxgbmbboqp/allegheny-red-bridge-campground.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (69, 'Clarion Creek', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 41.36, -79.047222, 1, 6, '2020-05-04T10:12:00', 38, 'https://s3.amazonaws.com/crowdriff-media/full/e89126a9a4a5c3492aedf1ed823a0bc0da8af660063398a418903f8f64db09c0.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (70, 'Blackstone River Welcome Center', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 41.939495, -71.444541, 1, 6, '2020-05-05T10:12:00', 39, 'https://www.destination360.com/north-america/us/rhode-island/images/s/camping.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (71, 'Blackwell Bridge', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 34.833575, -83.174677, 1, 5, '2020-05-06T10:12:00', 40, 'https://images.tripleblaze.com/blog/wp-content/uploads/2009/01/beach-camping.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (72, 'Honey Hill Campground', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 33.174488, -79.561241, 1, 5, '2020-05-08T10:12:00', 40, 'https://lh3.googleusercontent.com/proxy/okrTIIC-_a0oaV7_NT47iHauxjZL5NfHjKlmXOGsou7G_5O_rbFlVCKp5i2qyQLvuS8jF3VkYohbyoGXCyk_gfUYqqDlykij55YNLwYhfWc');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (73, 'Badlands Overlook', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 43.890031, -102.226789, 1, 4, '2020-05-09T10:12:00', 41, 'https://www.planetware.com/photos-large/USSD/south-dakota-badlands-national-park-cedar-pass-campground.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (74, 'Orman Dam', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 44.73124, -103.72118, 1, 4, '2020-05-11T10:12:00', 41, 'https://campcdn.com/photos/1/0/1069/7407/low_res/timon-campground.JPG');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (75, 'Big Creek Primitive Campground', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 35.046342, -84.543606, 1, 3, '2020-05-12T10:12:00', 42, 'https://i.imgur.com/cHO3wnI.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (76, 'Little Stoney Creek Campground', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 36.313742, -82.072935, 1, 3, '2020-05-14T10:12:00', 42, 'https://i.redd.it/4xfwmv7f0p451.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (77, '186 Creek Crossing', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 26.503692, -97.489186, 1, 6, '2020-05-15T10:12:00', 43, 'https://i.redd.it/xhbjx4gdmop01.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (78, 'Blue Creek Bridge', 'Chalk and cheese mascarpone port-salut. Cheese slices cheddar the big cheese cut the cheese the big cheese port-salut gouda cauliflower cheese. Cheese triangles the big cheese swiss cheese and biscuits cheesecake hard cheese pecorino cottage cheese. Hard cheese cheesy grin blue castello parmesan pecorino queso paneer port-salut. Who moved my cheese.', 35.722618, -101.663863, 1, 6, '2020-05-18T10:12:00', 43, 'https://www.camperland.net/site/wp-content/uploads/2019/08/shutterstock_779868190-1000x675.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (79, 'Unicorn Ridge Campground', 'Blue castello cottage cheese hard cheese. Pecorino edam cream cheese danish fontina danish fontina monterey jack babybel fondue.', 40.029282, -111.281732, 1, 2, '2020-05-09T10:12:00', 44, 'https://camping.campendium.com/wp-content/uploads/2018/04/snow-canyon-state-park-1280x720.jpg');
INSERT INTO `campsite` (`id`, `name`, `location`, `latitude`, `longitude`, `enabled`, `creator_id`, `creation_date`, `state_id`, `picture_url`) VALUES (80, 'Soldiers Pass', 'Who moved my cheese cheesy feet cheese and wine bocconcini camembert de normandie brie red leicester bocconcini.', 40.181508, -111.952611, 1, 2, '2020-05-13T10:12:00', 44, 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSn7rjb6at5GKSb_OZFo4_AN4w0w-ROrieHqQ&usqp=CAU');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (1, '2020-05-26T06:14:00', 'This is one of my favorite spots.', 5, 1, 1, 1);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (2, '2020-04-02T06:14:00', 'Smelly cheese cheddar hard cheese. Cream cheese monterey jack fromage frais cheese and wine goat fondue manchego when the cheese comes out everybody\'s happy. ', 3, 1, 2, 2);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (3, '2020-04-03T07:14:00', 'Croque monsieur parmesan brie cauliflower cheese cheese slices airedale goat cut the cheese. ', 4, 1, 3, 3);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (4, '2020-04-04T08:14:00', 'Squirty cheese swiss the big cheese danish fontina rubber cheese macaroni cheese pepper jack feta. Parmesan roquefort feta squirty cheese.', 3, 1, 4, 4);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (5, '2020-04-05T09:14:00', 'Smelly cheese cheddar hard cheese. Cream cheese monterey jack fromage frais cheese and wine goat fondue manchego when the cheese comes out everybody\'s happy. ', 2, 1, 5, 5);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (6, '2020-04-06T10:14:00', 'Croque monsieur parmesan brie cauliflower cheese cheese slices airedale goat cut the cheese. ', 5, 1, 6, 6);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (7, '2020-04-07T06:14:00', 'Squirty cheese swiss the big cheese danish fontina rubber cheese macaroni cheese pepper jack feta. Parmesan roquefort feta squirty cheese.', 1, 1, 7, 1);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (8, '2020-04-08T07:14:00', 'Smelly cheese cheddar hard cheese. Cream cheese monterey jack fromage frais cheese and wine goat fondue manchego when the cheese comes out everybody\'s happy. ', 1, 1, 8, 2);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (9, '2020-04-09T08:14:00', 'Croque monsieur parmesan brie cauliflower cheese cheese slices airedale goat cut the cheese. ', 3, 1, 9, 3);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (10, '2020-04-11T06:14:00', 'Squirty cheese swiss the big cheese danish fontina rubber cheese macaroni cheese pepper jack feta. Parmesan roquefort feta squirty cheese.', 4, 1, 10, 6);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (11, '2020-04-12T06:14:00', 'Smelly cheese cheddar hard cheese. Cream cheese monterey jack fromage frais cheese and wine goat fondue manchego when the cheese comes out everybody\'s happy. ', 2, 1, 11, 4);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (12, '2020-04-13T06:14:00', 'Croque monsieur parmesan brie cauliflower cheese cheese slices airedale goat cut the cheese. ', 5, 1, 12, 4);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (13, '2020-04-14T06:14:00', 'Nice primitive site that has bear lockers at the sites for securing your food.', 4, 1, 2, 3);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (14, '2020-04-15T06:14:00', 'has three picnic tables, three tent pads and a group fire ring', 4, 1, 3, 3);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (15, '2020-05-14T06:14:00', 'Barebones, quiet but not much else going on here', 2, 1, 7, 2);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (16, '2020-05-06T06:14:00', 'Passenger cars and RVs can navigate the road, but it may be too challenging for some vehicles.', 3, 1, 1, 1);
INSERT INTO `comment` (`id`, `comment_date`, `remark`, `campsite_rating`, `enabled`, `campsite_id`, `person_id`) VALUES (17, '2020-05-11T06:14:00', 'First come, first served. Pit toilets, no drinking water or trash service.', 3, 1, 4, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `picture`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `picture` (`id`, `campsite_id`, `image_url`, `enabled`, `creation_date`, `person_user_id`) VALUES (1, 1, 'https://www.alltrails.com/trail/us/colorado/ute-creek-trail/photos', 1, '2020-05-27T010:12:00', 1);
INSERT INTO `picture` (`id`, `campsite_id`, `image_url`, `enabled`, `creation_date`, `person_user_id`) VALUES (2, 2, 'https://images.unsplash.com/photo-1519395612667-3b754d7b9086?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80', 1, '2020-04-11T010:12:00', 2);
INSERT INTO `picture` (`id`, `campsite_id`, `image_url`, `enabled`, `creation_date`, `person_user_id`) VALUES (3, 7, 'https://images.unsplash.com/photo-1487750404521-0bc4682c48c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80', 1, '2020-04-15T010:12:00', 2);
INSERT INTO `picture` (`id`, `campsite_id`, `image_url`, `enabled`, `creation_date`, `person_user_id`) VALUES (4, 12, 'https://images.unsplash.com/photo-1557292916-eaa52c7e5939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=746&q=80', 1, '2020-04-16T010:12:00', 2);
INSERT INTO `picture` (`id`, `campsite_id`, `image_url`, `enabled`, `creation_date`, `person_user_id`) VALUES (5, 23, 'https://images.unsplash.com/photo-1533575770077-052fa2c609fc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80', 1, '2020-04-18T010:12:00', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (1, '\'RV accessible\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (2, '\'Fishing\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (3, '\'Hiking\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (4, '\'Dog friendly\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (5, '\'Nearby bathrooms\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (6, '\'Geo-caching\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (7, '\'Fire rings\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (8, '\'Tent areas\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (9, '\'Kid friendly\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (10, '\'Rock climbing\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (11, '\'Waterfalls\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (12, '\'Lakes\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (13, '\'Rivers\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (14, '\'4X4 accessible only\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (15, '\'Passenger vehicle accessible\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (16, '\'Heavy wind area\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (17, '\'Orienting\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (18, '\'Natural swimming area\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (19, '\'Large family/Group areas\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (20, '\'Potable water\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (21, '\'Boat launch\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (22, '\'Nearby garbage receptacles\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (23, '\'Nearby town under 5 miles\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (24, '\'Nearby town under 10 miles\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (25, '\'Nearby town under 20 miles\'', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (26, '\'Good cell service\'', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `campsite_has_feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `campfreedb`;
INSERT INTO `campsite_has_feature` (`campsite_id`, `feature_id`) VALUES (1, 1);
INSERT INTO `campsite_has_feature` (`campsite_id`, `feature_id`) VALUES (2, 1);
INSERT INTO `campsite_has_feature` (`campsite_id`, `feature_id`) VALUES (2, 2);
INSERT INTO `campsite_has_feature` (`campsite_id`, `feature_id`) VALUES (2, 3);
INSERT INTO `campsite_has_feature` (`campsite_id`, `feature_id`) VALUES (2, 4);

COMMIT;

