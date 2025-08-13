-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gerenciador_senai
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gerenciador_senai
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gerenciador_senai` DEFAULT CHARACTER SET utf8 ;
USE `gerenciador_senai` ;

-- -----------------------------------------------------
-- Table `gerenciador_senai`.`Escala_de_trabalho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciador_senai`.`Escala_de_trabalho` (
  `id_escala_de_trabalho` INT NOT NULL AUTO_INCREMENT,
  `horario_escala_de_trabalho` VARCHAR(220) NOT NULL,
  PRIMARY KEY (`id_escala_de_trabalho`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gerenciador_senai`.`Colaboladores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciador_senai`.`Colaboladores` (
  `id_colabolador` INT NOT NULL AUTO_INCREMENT,
  `nome_colaborador` VARCHAR(220) NOT NULL,
  `nivel_colaborador` ENUM('0', '1') NOT NULL,
  `Escala_de_trabalho_id_escala_de_trabalho` INT NOT NULL,
  PRIMARY KEY (`id_colabolador`),
  INDEX `fk_Colaboladores_Escala_de_trabalho_idx` (`Escala_de_trabalho_id_escala_de_trabalho` ASC),
  CONSTRAINT `fk_Colaboladores_Escala_de_trabalho`
    FOREIGN KEY (`Escala_de_trabalho_id_escala_de_trabalho`)
    REFERENCES `gerenciador_senai`.`Escala_de_trabalho` (`id_escala_de_trabalho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gerenciador_senai`.`tipo_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciador_senai`.`tipo_cursos` (
  `id_tipo_cursos` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo_curso` VARCHAR(220) NOT NULL,
  `tempo_aula_tipo_curso` INT NOT NULL,
  PRIMARY KEY (`id_tipo_cursos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gerenciador_senai`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciador_senai`.`Cursos` (
  `id_cursos` INT NOT NULL AUTO_INCREMENT,
  `nome_curso` VARCHAR(220) NOT NULL,
  `tipo_cursos_id_tipo_cursos` INT NOT NULL,
  PRIMARY KEY (`id_cursos`),
  INDEX `fk_Cursos_tipo_cursos1_idx` (`tipo_cursos_id_tipo_cursos` ASC),
  CONSTRAINT `fk_Cursos_tipo_cursos1`
    FOREIGN KEY (`tipo_cursos_id_tipo_cursos`)
    REFERENCES `gerenciador_senai`.`tipo_cursos` (`id_tipo_cursos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gerenciador_senai`.`Ambientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciador_senai`.`Ambientes` (
  `id_ambiente` INT NOT NULL AUTO_INCREMENT,
  `nome_ambiente` VARCHAR(220) NOT NULL,
  `num_ambiente` INT NOT NULL,
  PRIMARY KEY (`id_ambiente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gerenciador_senai`.`Turmas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciador_senai`.`Turmas` (
  `id_turma` INT NOT NULL AUTO_INCREMENT,
  `turma_nome` VARCHAR(45) NOT NULL,
  `ativo_turmas` ENUM('0', '1') NOT NULL,
  `Cursos_id_cursos` INT NOT NULL,
  `Horarios_id_horario` INT NOT NULL,
  `Ambientes_id_ambiente` INT NOT NULL,
  PRIMARY KEY (`id_turma`),
  INDEX `fk_Turmas_Cursos1_idx` (`Cursos_id_cursos` ASC),
  INDEX `fk_Turmas_Ambientes1_idx` (`Ambientes_id_ambiente` ASC),
  CONSTRAINT `fk_Turmas_Cursos1`
    FOREIGN KEY (`Cursos_id_cursos`)
    REFERENCES `gerenciador_senai`.`Cursos` (`id_cursos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turmas_Ambientes1`
    FOREIGN KEY (`Ambientes_id_ambiente`)
    REFERENCES `gerenciador_senai`.`Ambientes` (`id_ambiente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gerenciador_senai`.`Colaboladores_has_Turmas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gerenciador_senai`.`Colaboladores_has_Turmas` (
  `Colaboladores_id_colabolador` INT NOT NULL,
  `Turmas_id_turma` INT NOT NULL,
  PRIMARY KEY (`Colaboladores_id_colabolador`, `Turmas_id_turma`),
  INDEX `fk_Colaboladores_has_Turmas_Turmas1_idx` (`Turmas_id_turma` ASC),
  INDEX `fk_Colaboladores_has_Turmas_Colaboladores1_idx` (`Colaboladores_id_colabolador` ASC),
  CONSTRAINT `fk_Colaboladores_has_Turmas_Colaboladores1`
    FOREIGN KEY (`Colaboladores_id_colabolador`)
    REFERENCES `gerenciador_senai`.`Colaboladores` (`id_colabolador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colaboladores_has_Turmas_Turmas1`
    FOREIGN KEY (`Turmas_id_turma`)
    REFERENCES `gerenciador_senai`.`Turmas` (`id_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
