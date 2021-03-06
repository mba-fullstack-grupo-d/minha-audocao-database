-- MySQL Script generated by MySQL Workbench
-- Sun Jul 18 21:52:24 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema minha-audocao
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `minha-audocao` ;

-- -----------------------------------------------------
-- Schema minha-audocao
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `minha-audocao` DEFAULT CHARACTER SET utf8 ;
USE `minha-audocao` ;

-- -----------------------------------------------------
-- Table `minha-audocao`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`endereco` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  `numero` INT NULL,
  `cep` INT NOT NULL,
  `bairro` VARCHAR(45) NULL,
  PRIMARY KEY (`idendereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `minha-audocao`.`instituicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`instituicao` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`instituicao` (
  `idinstituicao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(4000) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `imagem` VARCHAR(4000) NOT NULL,
  `idendereco` INT NOT NULL,
  PRIMARY KEY (`idinstituicao`),
  CONSTRAINT `fk_instituicao_endereco1`
    FOREIGN KEY (`idendereco`)
    REFERENCES `minha-audocao`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_instituicao_endereco1_idx` ON `minha-audocao`.`instituicao` (`idendereco` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `minha-audocao`.`pet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`pet` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`pet` (
  `idpet` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `especie` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(4000) NOT NULL,
  `adotado` TINYINT NOT NULL,
  `genero` VARCHAR(45) NULL,
  `idade` INT NULL,
  `idinstituicao` INT NOT NULL,
  `vacinado` TINYINT NOT NULL,
  `castrado` TINYINT NOT NULL,
  PRIMARY KEY (`idpet`),
  CONSTRAINT `fk_pet_instituicao`
    FOREIGN KEY (`idinstituicao`)
    REFERENCES `minha-audocao`.`instituicao` (`idinstituicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pet_instituicao_idx` ON `minha-audocao`.`pet` (`idinstituicao` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `minha-audocao`.`evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`evento` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`evento` (
  `idevento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(4000) NOT NULL,
  `idinstituicao` INT NOT NULL,
  `idendereco` INT NOT NULL,
  `imagem` VARCHAR(4000) NULL,
  PRIMARY KEY (`idevento`),
  CONSTRAINT `fk_evento_instituicao1`
    FOREIGN KEY (`idinstituicao`)
    REFERENCES `minha-audocao`.`instituicao` (`idinstituicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_endereco1`
    FOREIGN KEY (`idendereco`)
    REFERENCES `minha-audocao`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_evento_instituicao1_idx` ON `minha-audocao`.`evento` (`idinstituicao` ASC) VISIBLE;

CREATE INDEX `fk_evento_endereco1_idx` ON `minha-audocao`.`evento` (`idendereco` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `minha-audocao`.`data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`data` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`data` (
  `iddata` INT NOT NULL AUTO_INCREMENT,
  `idevento` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `hora_inicio` VARCHAR(100) NOT NULL,
  `hora_fim` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`iddata`),
  CONSTRAINT `fk_data_evento1`
    FOREIGN KEY (`idevento`)
    REFERENCES `minha-audocao`.`evento` (`idevento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_data_evento1_idx` ON `minha-audocao`.`data` (`idevento` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `minha-audocao`.`formulario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`formulario` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`formulario` (
  `idformulario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `obrigatorio` TINYINT NOT NULL,
  `ordem` INT NOT NULL,
  `idinstituicao` INT NOT NULL,
  PRIMARY KEY (`idformulario`),
  CONSTRAINT `fk_formulario_instituicao1`
    FOREIGN KEY (`idinstituicao`)
    REFERENCES `minha-audocao`.`instituicao` (`idinstituicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_formulario_instituicao1_idx` ON `minha-audocao`.`formulario` (`idinstituicao` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `minha-audocao`.`pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`pessoa` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`pessoa` (
  `idpessoa` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sobrenome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `imagem` VARCHAR(4000) NOT NULL,
  `idendereco` INT NULL,
  `telefone` VARCHAR(45) NULL,
  PRIMARY KEY (`idpessoa`),
  CONSTRAINT `fk_pessoa_endereco1`
    FOREIGN KEY (`idendereco`)
    REFERENCES `minha-audocao`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pessoa_endereco1_idx` ON `minha-audocao`.`pessoa` (`idendereco` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `minha-audocao`.`foto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`foto` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`foto` (
  `idfoto` INT NOT NULL AUTO_INCREMENT,
  `uri_foto` VARCHAR(4000) NOT NULL,
  `idpet` INT NOT NULL,
  PRIMARY KEY (`idfoto`),
  CONSTRAINT `fk_foto_pet1`
    FOREIGN KEY (`idpet`)
    REFERENCES `minha-audocao`.`pet` (`idpet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_foto_pet1_idx` ON `minha-audocao`.`foto` (`idpet` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `minha-audocao`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`users` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`users` (
  `username` VARCHAR(128) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `minha-audocao`.`authorities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `minha-audocao`.`authorities` ;

CREATE TABLE IF NOT EXISTS `minha-audocao`.`authorities` (
  `authority` VARCHAR(128) NOT NULL,
  `username` VARCHAR(128) NOT NULL,
  CONSTRAINT `fk_authorities_users1`
    FOREIGN KEY (`username`)
    REFERENCES `minha-audocao`.`users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_authorities_users1_idx` ON `minha-audocao`.`authorities` (`username` ASC) VISIBLE;

CREATE UNIQUE INDEX `authorities_unique` ON `minha-audocao`.`authorities` (`username` ASC, `authority` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
