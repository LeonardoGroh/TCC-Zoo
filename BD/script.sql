SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`especie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`especie` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`especie` (
  `idEspecie` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para cadastrar as especies do Zoo' ,
  `IN169` LONGTEXT NULL COMMENT 'Lei do IBAMA de como determinada especie deve ser cuidada' ,
  `nomeCien` VARCHAR(45) NOT NULL COMMENT 'Nome cientifico da especie' ,
  `nomePop` VARCHAR(45) NOT NULL COMMENT 'Nome popular, forma como as pessoas da região conhecem o animal' ,
  `Familia` VARCHAR(45) NOT NULL COMMENT 'Familia da especie\nExemplo: Cercopithecidae (Macacos do velho mundo)' ,
  `seguranca` INT NOT NULL COMMENT 'O nivel de perigo da especie para humanos, determinado pelo IBAMA na IN169\nEntre 1 a 4' ,
  PRIMARY KEY (`idEspecie`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recinto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Recinto` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Recinto` (
  `idRecinto` INT NOT NULL COMMENT 'Tabela para registrar os Recintos(jaulas) do Zoo' ,
  `planta` VARCHAR(45) NOT NULL COMMENT 'Estrudura do recinto,sera enviado uma imagem do PDF' ,
  `SegurancaRecinto` INT NOT NULL COMMENT 'Nivel de segurança dos animais que podem ficar no recinto' ,
  `Ativo` TINYINT(1)  NOT NULL COMMENT 'Define se o usuario nao pode mais acessar o software' ,
  PRIMARY KEY (`idRecinto`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Animal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Animal` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Animal` (
  `idAnimal` INT NOT NULL COMMENT 'Tabela para cadastrar os animais do Zoo.\nNesse campo é salvo o Numero dele no Zoo.' ,
  `Obs` TEXT NULL COMMENT 'Descreve as necesidades especiais do animal' ,
  `procedencia` VARCHAR(45) NOT NULL COMMENT 'Descreve de onde o animal veio' ,
  `entrada` DATE NULL COMMENT 'Data em que o animal entrou no Zoo' ,
  `idvet` INT NULL COMMENT 'ID da ficha veterinaria' ,
  `Sexo` CHAR NULL COMMENT 'Sexo do animal\nAlgumas vezes nao se sabe o sexo do animal,nesse caso o valor é NULL' ,
  `desfecho` VARCHAR(45) NULL COMMENT 'Descreve como o animal saio do Zoo' ,
  `desfechoData` DATE NULL COMMENT 'Data que o animal saio do Zoo' ,
  `idEspecie` INT NOT NULL COMMENT 'ID da especie do animal' ,
  `imagem` BLOB NULL COMMENT 'Foto do animal' ,
  `marcacao` VARCHAR(100) NOT NULL COMMENT 'Numero do animal do IBAMA' ,
  `Apelido` VARCHAR(45) NULL COMMENT 'Como os funcionarios chamam o animal' ,
  `idRecinto` INT NOT NULL COMMENT 'ID do recinto onde o animal se encontra' ,
  PRIMARY KEY (`idAnimal`) ,
  INDEX `fk_Animal_especie1_idx` (`idEspecie` ASC) ,
  INDEX `fk_Animal_Recinto1_idx` (`idRecinto` ASC) ,
  UNIQUE INDEX `marcacao_UNIQUE` (`marcacao` ASC) ,
  CONSTRAINT `fk_Animal_especie1`
    FOREIGN KEY (`idEspecie` )
    REFERENCES `mydb`.`especie` (`idEspecie` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Animal_Recinto1`
    FOREIGN KEY (`idRecinto` )
    REFERENCES `mydb`.`Recinto` (`idRecinto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`usuario` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para cadastrar os funcionarios do Zoo com acesso ao programa' ,
  `Nome` VARCHAR(100) NOT NULL COMMENT 'Nome do usuario' ,
  `CPF` VARCHAR(14) NOT NULL COMMENT 'CP do usuario' ,
  `Email` VARCHAR(45) NOT NULL COMMENT 'Email do usuario' ,
  `Senha` VARCHAR(45) NOT NULL COMMENT 'Senha do usuario codificada em MD5' ,
  `Tipo` CHAR NOT NULL COMMENT 'Nivel de acesso do usuario' ,
  `Ativo` CHAR NOT NULL COMMENT 'Define se o usuario cadastrado ainda possue acesso ao software' ,
  `Login` VARCHAR(20) NOT NULL COMMENT 'Login de acesso do usuario\n' ,
  PRIMARY KEY (`idUsuario`) ,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) ,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) ,
  UNIQUE INDEX `Login_UNIQUE` (`Login` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`usuario` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para cadastrar os funcionarios do Zoo com acesso ao programa' ,
  `Nome` VARCHAR(100) NOT NULL COMMENT 'Nome do usuario' ,
  `CPF` VARCHAR(14) NOT NULL COMMENT 'CP do usuario' ,
  `Email` VARCHAR(45) NOT NULL COMMENT 'Email do usuario' ,
  `Senha` VARCHAR(45) NOT NULL COMMENT 'Senha do usuario codificada em MD5' ,
  `Tipo` CHAR NOT NULL COMMENT 'Nivel de acesso do usuario' ,
  `Ativo` CHAR NOT NULL COMMENT 'Define se o usuario cadastrado ainda possue acesso ao software' ,
  `Login` VARCHAR(20) NOT NULL COMMENT 'Login de acesso do usuario\n' ,
  PRIMARY KEY (`idUsuario`) ,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) ,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) ,
  UNIQUE INDEX `Login_UNIQUE` (`Login` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`vet` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`vet` (
  `idvet` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para cadastrar os dados veterinarios de um animal\nÉ separada por anos' ,
  `fezes` CHAR NULL ,
  `vermifugo` VARCHAR(10) NULL ,
  `Ano` YEAR NOT NULL COMMENT 'Ano dos casos' ,
  `idAnimal` INT NOT NULL ,
  PRIMARY KEY (`idvet`) ,
  INDEX `fk_vet_Animal1` (`idAnimal` ASC) ,
  CONSTRAINT `fk_vet_Animal1`
    FOREIGN KEY (`idAnimal` )
    REFERENCES `mydb`.`Animal` (`idAnimal` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Obs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Obs` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Obs` (
  `idObs` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para cadastrar as ocorrencias do animal' ,
  `Obs` TEXT NOT NULL COMMENT 'Dados da ocorrrencia' ,
  `date` DATE NOT NULL COMMENT 'Data que occoreu' ,
  `idvet` INT NOT NULL COMMENT 'ID da ficha veterinaria' ,
  PRIMARY KEY (`idObs`) ,
  INDEX `fk_Obs_vet1_idx` (`idvet` ASC) ,
  CONSTRAINT `fk_Obs_vet1`
    FOREIGN KEY (`idvet` )
    REFERENCES `mydb`.`vet` (`idvet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recinto_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Recinto_log` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Recinto_log` (
  `idRecinto_log` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para controlar o historico de alterações na tabela \'Recinto\'' ,
  `planta` VARCHAR(45) NOT NULL ,
  `SegurancaRecinto` INT NOT NULL ,
  `ativo` TINYINT(1)  NOT NULL ,
  `tipo` VARCHAR(45) NOT NULL COMMENT 'Tipo de ação que a tabela recinto sofreu' ,
  `data` DATETIME NOT NULL COMMENT 'Data da alteração' ,
  `idRecinto` INT NULL COMMENT 'ID do recinto que sofreu a ação\n' ,
  `idUsuario` INT NOT NULL COMMENT 'ID do usuario que fez a ação' ,
  PRIMARY KEY (`idRecinto_log`) ,
  INDEX `fk_Recinto_log_Recinto1` (`idRecinto` ASC) ,
  INDEX `fk_Recinto_log_usuario1` (`idUsuario` ASC) ,
  CONSTRAINT `fk_Recinto_log_Recinto1`
    FOREIGN KEY (`idRecinto` )
    REFERENCES `mydb`.`Recinto` (`idRecinto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recinto_log_usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `mydb`.`usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`usuario_log` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`usuario_log` (
  `idUsuario_log` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para controlar o historico de alterações na tabela \'usuario\'\n' ,
  `Senha` VARCHAR(45) NOT NULL ,
  `Tipo` CHAR NOT NULL ,
  `Ativo` CHAR NOT NULL ,
  `TipoA` VARCHAR(45) NOT NULL COMMENT 'Tipo da ação que a tabela usuario sofreu' ,
  `data` DATETIME NOT NULL COMMENT 'Data da alteração' ,
  `nome` VARCHAR(100) NOT NULL ,
  `idUsuario` INT NULL COMMENT 'ID do usuario que fez a modificação' ,
  `Email` VARCHAR(45) NOT NULL ,
  `Login` VARCHAR(20) NOT NULL ,
  `CPF` VARCHAR(14) NOT NULL ,
  PRIMARY KEY (`idUsuario_log`) ,
  INDEX `fk_usuario_log_usuario1` (`idUsuario` ASC) ,
  CONSTRAINT `fk_usuario_log_usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `mydb`.`usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Animal_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Animal_log` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Animal_log` (
  `idAnimal_log` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para controlar o historico de alterações na tabela \'Animal\'\n' ,
  `Obs` TEXT NULL ,
  `procedencia` VARCHAR(45) NOT NULL ,
  `entrada` DATE NULL ,
  `idvet` INT NULL ,
  `Sexo` CHAR NULL ,
  `desfecho` VARCHAR(45) NULL ,
  `desfechoData` DATE NULL ,
  `idEspecie` INT NOT NULL ,
  `imagem` BLOB NULL ,
  `marcacao` VARCHAR(100) NOT NULL ,
  `Apelido` VARCHAR(45) NULL ,
  `idRecinto` INT NOT NULL ,
  `tipo` VARCHAR(45) NOT NULL COMMENT 'Tipo de ação que a tabela animal sofreu' ,
  `data` DATETIME NOT NULL COMMENT 'Data da alteração' ,
  `idAnimal` INT NULL COMMENT 'ID do animal que sofreu a ação' ,
  `idUsuario` INT NULL COMMENT 'ID do usuario que fez a ação' ,
  PRIMARY KEY (`idAnimal_log`) ,
  INDEX `fk_Animal_especie1_idx` (`idEspecie` ASC) ,
  INDEX `fk_Animal_Recinto1_idx` (`idRecinto` ASC) ,
  INDEX `fk_Animal_log_Animal1` (`idAnimal` ASC) ,
  INDEX `fk_Animal_log_usuario1` (`idUsuario` ASC) ,
  UNIQUE INDEX `marcacao_UNIQUE` (`marcacao` ASC) ,
  CONSTRAINT `fk_Animal_especie10`
    FOREIGN KEY (`idEspecie` )
    REFERENCES `mydb`.`especie` (`idEspecie` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Animal_Recinto10`
    FOREIGN KEY (`idRecinto` )
    REFERENCES `mydb`.`Recinto` (`idRecinto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Animal_log_Animal1`
    FOREIGN KEY (`idAnimal` )
    REFERENCES `mydb`.`Animal` (`idAnimal` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Animal_log_usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `mydb`.`usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`especie_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`especie_log` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`especie_log` (
  `idEspecie_log` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para controlar o historico de alterações na tabela \'especie\'' ,
  `IN169` LONGTEXT NULL ,
  `nomeCien` VARCHAR(45) NOT NULL ,
  `nomePop` VARCHAR(45) NOT NULL ,
  `Familia` VARCHAR(45) NOT NULL ,
  `seguranca` INT NOT NULL ,
  `tipo` VARCHAR(45) NOT NULL COMMENT 'Tipo de ação que a tabela especie sofreu' ,
  `data` DATETIME NOT NULL COMMENT 'Data da alteração' ,
  `idUsuario` INT NOT NULL COMMENT 'ID do usuario que fez a ação' ,
  `idEspecie` INT NULL COMMENT 'id da especie que sofreu a ação' ,
  PRIMARY KEY (`idEspecie_log`) ,
  INDEX `fk_especie_log_usuario1` (`idUsuario` ASC) ,
  INDEX `fk_especie_log_especie1` (`idEspecie` ASC) ,
  CONSTRAINT `fk_especie_log_usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `mydb`.`usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_especie_log_especie1`
    FOREIGN KEY (`idEspecie` )
    REFERENCES `mydb`.`especie` (`idEspecie` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vet_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`vet_log` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`vet_log` (
  `idvet_log` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para controlar o historico de alterações na tabela \'Vetl\'\n' ,
  `fezes` CHAR NULL ,
  `vermifugo` VARCHAR(10) NULL ,
  `Ano` YEAR NOT NULL ,
  `idAnimal` INT NOT NULL ,
  `tipo` VARCHAR(45) NOT NULL COMMENT 'Tipo de ação que a tabela vet sofreu' ,
  `data` DATETIME NOT NULL COMMENT 'Data da alteração' ,
  `idvet` INT NULL COMMENT 'ID da tabela que sofreu a alteração' ,
  `idUsuario` INT NOT NULL COMMENT 'ID do usuario que fez a alteração' ,
  PRIMARY KEY (`idvet_log`) ,
  INDEX `fk_vet_Animal1` (`idAnimal` ASC) ,
  INDEX `fk_vet_log_vet1` (`idvet` ASC) ,
  INDEX `fk_vet_log_usuario1` (`idUsuario` ASC) ,
  CONSTRAINT `fk_vet_Animal10`
    FOREIGN KEY (`idAnimal` )
    REFERENCES `mydb`.`Animal` (`idAnimal` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vet_log_vet1`
    FOREIGN KEY (`idvet` )
    REFERENCES `mydb`.`vet` (`idvet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vet_log_usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `mydb`.`usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Obs_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Obs_log` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Obs_log` (
  `idObs_log` INT NOT NULL AUTO_INCREMENT COMMENT 'Tabela para controlar o historico de alterações na tabela \'Obs\'' ,
  `Obs` TEXT NOT NULL ,
  `date` DATE NOT NULL ,
  `idvet` INT NOT NULL ,
  `tipo` VARCHAR(45) NOT NULL COMMENT 'Tipo de ação que a tabela Obs sofreu' ,
  `data` DATETIME NOT NULL COMMENT 'Data da alteração' ,
  `idObs` INT NULL COMMENT 'ID da obs qu sofreu a ação' ,
  `idUsuario` INT NOT NULL COMMENT 'ID do usuario que fez a ação' ,
  PRIMARY KEY (`idObs_log`) ,
  INDEX `fk_Obs_vet1_idx` (`idvet` ASC) ,
  INDEX `fk_Obs_log_Obs1` (`idObs` ASC) ,
  INDEX `fk_Obs_log_usuario1` (`idUsuario` ASC) ,
  CONSTRAINT `fk_Obs_vet10`
    FOREIGN KEY (`idvet` )
    REFERENCES `mydb`.`vet` (`idvet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Obs_log_Obs1`
    FOREIGN KEY (`idObs` )
    REFERENCES `mydb`.`Obs` (`idObs` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Obs_log_usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `mydb`.`usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
