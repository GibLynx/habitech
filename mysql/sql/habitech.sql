-- Database HabiTech
-- ----------------------
CREATE DATABASE `HabiTech`;
USE `HabiTech`;

-- User habitech; Password h@b173ch
-- ----------------------
CREATE USER 'habitech' IDENTIFIED BY 'h@b173ch';
GRANT ALL ON * TO `habitech`;

-- Table Appliance
-- ----------------------
CREATE TABLE IF NOT EXISTS `Appliance` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR (30) NOT NULL,
    PRIMARY KEY (`id`)
);

-- Table Schedule
-- ----------------------
CREATE TABLE IF NOT EXISTS `Schedule` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `appliance_id` INT NOT NULL,
    `when` DATETIME NOT NULL,
    `action` BIT(1) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`appliance_id`) REFERENCES Appliance(`id`)
);
