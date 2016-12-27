-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table `tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `ativo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idtipo` INT(11) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(11) NULL,
  `datanascimento` DATE NULL,
  `email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `ativo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_tipo_usuario_idx` (`idtipo` ASC),
  CONSTRAINT `fk_usuario_tipo_usuario`
    FOREIGN KEY (`idtipo`)
    REFERENCES `tipo_usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `categoria_livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categoria_livro` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(255) NOT NULL,
  `ativo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livro` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idcategoria` INT(11) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `quantidade` INT(11) NOT NULL,
  `ativo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_livro_categoria_livro1_idx` (`idcategoria` ASC),
  CONSTRAINT `fk_livro_categoria_livro1`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `categoria_livro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `emprestimos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `emprestimo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idlivro` INT(11) NOT NULL,
  `idusuario` INT(11) NOT NULL,
  `dataretirada` DATE NOT NULL,
  `dataprevista` DATE NOT NULL,
  `datadevolucao` DATE NULL,
  `valoremprestimo` DOUBLE(10,2) NOT NULL,
  `valorpago` DOUBLE(10,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_emprestimos_livro1_idx` (`idlivro` ASC),
  INDEX `fk_emprestimos_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_emprestimos_livro1`
    FOREIGN KEY (`idlivro`)
    REFERENCES `livro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emprestimos_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `tipo_usuario`
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO `tipo_usuario` (`id`, `tipo`, `ativo`) VALUES (1, 'Administrador', 1);
INSERT INTO `tipo_usuario` (`id`, `tipo`, `ativo`) VALUES (2, 'Bibliotecário', 1);
INSERT INTO `tipo_usuario` (`id`, `tipo`, `ativo`) VALUES (3, 'Locatário', 1);
INSERT INTO `usuario` (`idtipo`, `nome`, `email`, `senha`, `ativo`) VALUES (1, 'Admin','admin@email.com','81dc9bdb52d04dc20036dbd8313ed055',1);

COMMIT;

