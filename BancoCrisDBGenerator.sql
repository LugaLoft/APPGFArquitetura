DROP SCHEMA IF EXISTS `bancocris`;
CREATE SCHEMA IF NOT EXISTS `bancocris` DEFAULT CHARACTER SET utf8;
USE `bancocris`;

CREATE TABLE IF NOT EXISTS `bancocris`.`Cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `CNPJ` VARCHAR(18) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC));

CREATE TABLE IF NOT EXISTS `bancocris`.`Grupo` (
  `idGrupo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idGrupo`));

CREATE TABLE IF NOT EXISTS `bancocris`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `CPF` VARCHAR(14) NOT NULL,
  `login` VARCHAR(20) NOT NULL,
  `senha` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC));

CREATE TABLE IF NOT EXISTS `bancocris`.`Subgrupo` (
  `idSubgrupo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idSubgrupo`));

CREATE TABLE IF NOT EXISTS `bancocris`.`Transacao` (
  `idTransacao` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `idGrupo` INT NOT NULL,
  `idSubgrupo` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `dataTransacao` DATETIME NOT NULL,
  `tipoTransacao` BINARY NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `dataPagamento` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idTransacao`),
  INDEX `fk_Transacao_cliente_idx` (`idcliente` ASC),
  INDEX `fk_Transacao_Grupo1_idx` (`idGrupo` ASC),
  INDEX `fk_Transacao_Usuario1_idx` (`idUsuario` ASC),
  INDEX `fk_Transacao_Subgrupo1_idx` (`idSubgrupo` ASC),
  CONSTRAINT `fk_Transacao_cliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `bancocris`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transacao_Grupo1`
    FOREIGN KEY (`idGrupo`)
    REFERENCES `bancocris`.`Grupo` (`idGrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transacao_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `bancocris`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transacao_Subgrupo1`
    FOREIGN KEY (`idSubgrupo`)
    REFERENCES `bancocris`.`Subgrupo` (`idSubgrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `bancocris`.`Grupo_has_Subgrupo` (
  `idGrupo` INT NOT NULL,
  `idSubgrupo` INT NOT NULL,
  PRIMARY KEY (`idGrupo`, `idSubgrupo`),
  INDEX `fk_Grupo_has_Subgrupo_Subgrupo1_idx` (`idSubgrupo` ASC),
  INDEX `fk_Grupo_has_Subgrupo_Grupo1_idx` (`idGrupo` ASC),
  CONSTRAINT `fk_Grupo_has_Subgrupo_Grupo1`
    FOREIGN KEY (`idGrupo`)
    REFERENCES `bancocris`.`Grupo` (`idGrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Grupo_has_Subgrupo_Subgrupo1`
    FOREIGN KEY (`idSubgrupo`)
    REFERENCES `bancocris`.`Subgrupo` (`idSubgrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO USUARIO (NOME, CPF, LOGIN, SENHA) VALUES ('Administrador do Sistema', '00000000000', 'admin', 'admin');