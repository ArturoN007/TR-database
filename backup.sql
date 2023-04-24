/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.24-MariaDB : Database - senati_mat
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`senati_mat` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `senati_mat`;

/*Table structure for table `cargos` */

DROP TABLE IF EXISTS `cargos`;

CREATE TABLE `cargos` (
  `idcargo` int(11) NOT NULL AUTO_INCREMENT,
  `cargo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idcargo`),
  UNIQUE KEY `uk_cargo_cargos` (`cargo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `cargos` */

insert  into `cargos`(`idcargo`,`cargo`) values 
(4,'Asist. Academico'),
(3,'Asist. Administrativ'),
(6,'Coordinardor CIS'),
(5,'Cordinador ETIA'),
(1,'Instructor'),
(2,'Jefe de centro');

/*Table structure for table `carreras` */

DROP TABLE IF EXISTS `carreras`;

CREATE TABLE `carreras` (
  `idcarrera` int(11) NOT NULL AUTO_INCREMENT,
  `idescuela` int(11) NOT NULL,
  `carrera` varchar(100) NOT NULL,
  PRIMARY KEY (`idcarrera`),
  UNIQUE KEY `uk_carrera_car` (`carrera`),
  KEY `fk_idescuela_car` (`idescuela`),
  CONSTRAINT `fk_idescuela_car` FOREIGN KEY (`idescuela`) REFERENCES `escuelas` (`idescuela`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

/*Data for the table `carreras` */

insert  into `carreras`(`idcarrera`,`idescuela`,`carrera`) values 
(1,1,'Diseño Gráfico Digital'),
(2,1,'Ingeniería de Software con IA'),
(3,1,'Cyberseguridad'),
(4,2,'Administración de empresas'),
(5,2,'Administración Industrial'),
(6,2,'Prevencionista de Riesgo'),
(7,3,'Soldador Universal'),
(8,3,'Mecánico de mantenimiento'),
(9,3,'Soldador estructuras metálicas');

/*Table structure for table `colaboradores` */

DROP TABLE IF EXISTS `colaboradores`;

CREATE TABLE `colaboradores` (
  `idcolaborador` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(40) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `idcargo` int(11) NOT NULL,
  `idsede` int(11) NOT NULL,
  `telefono` char(12) NOT NULL,
  `tipocontrato` char(1) NOT NULL,
  `cv` varchar(100) DEFAULT NULL,
  `direccion` varchar(40) NOT NULL,
  `fecharegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaupdate` datetime DEFAULT NULL,
  `estado` char(1) DEFAULT '1',
  PRIMARY KEY (`idcolaborador`),
  KEY `fk_idcargo_colab` (`idcargo`),
  KEY `fk_idsede_colab` (`idsede`),
  CONSTRAINT `fk_idcargo_colab` FOREIGN KEY (`idcargo`) REFERENCES `cargos` (`idcargo`),
  CONSTRAINT `fk_idsede_colab` FOREIGN KEY (`idsede`) REFERENCES `sedes` (`idsede`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `colaboradores` */

insert  into `colaboradores`(`idcolaborador`,`apellidos`,`nombres`,`idcargo`,`idsede`,`telefono`,`tipocontrato`,`cv`,`direccion`,`fecharegistro`,`fechaupdate`,`estado`) values 
(2,'Palomino','Ericka',2,1,'966589781','P',NULL,'Pueblo nuevo','2023-04-24 08:09:50',NULL,'1'),
(3,'Pachas','Melany',3,2,'96691378','C',NULL,'algun lugar','2023-04-24 08:11:00',NULL,'1');

/*Table structure for table `escuelas` */

DROP TABLE IF EXISTS `escuelas`;

CREATE TABLE `escuelas` (
  `idescuela` int(11) NOT NULL AUTO_INCREMENT,
  `escuela` varchar(50) NOT NULL,
  PRIMARY KEY (`idescuela`),
  UNIQUE KEY `uk_escuela_esc` (`escuela`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `escuelas` */

insert  into `escuelas`(`idescuela`,`escuela`) values 
(2,'Administración'),
(1,'ETI'),
(3,'Metal mecánica');

/*Table structure for table `estudiantes` */

DROP TABLE IF EXISTS `estudiantes`;

CREATE TABLE `estudiantes` (
  `idestudiante` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(40) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `tipodocumento` char(1) NOT NULL DEFAULT 'D',
  `nrodocumento` char(8) NOT NULL,
  `fechanacimiento` date NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `idsede` int(11) NOT NULL,
  `fotografia` varchar(100) DEFAULT NULL,
  `fecharegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaupdate` datetime DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idestudiante`),
  UNIQUE KEY `uk_nrodocumento_est` (`tipodocumento`,`nrodocumento`),
  KEY `fk_idcarrera_est` (`idcarrera`),
  KEY `fk_idsede_est` (`idsede`),
  CONSTRAINT `fk_idcarrera_est` FOREIGN KEY (`idcarrera`) REFERENCES `carreras` (`idcarrera`),
  CONSTRAINT `fk_idsede_est` FOREIGN KEY (`idsede`) REFERENCES `sedes` (`idsede`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `estudiantes` */

insert  into `estudiantes`(`idestudiante`,`apellidos`,`nombres`,`tipodocumento`,`nrodocumento`,`fechanacimiento`,`idcarrera`,`idsede`,`fotografia`,`fecharegistro`,`fechaupdate`,`estado`) values 
(2,'Ochoa','Fiorella','D','77778888','2000-10-10',4,2,NULL,'2023-04-24 08:09:31',NULL,'1'),
(3,'Perez','Roxana','D','88881111','2001-03-03',7,3,NULL,'2023-04-24 08:09:31',NULL,'1'),
(4,'Quintana','Tania','D','33334444','2001-05-05',9,4,NULL,'2023-04-24 08:09:31',NULL,'1'),
(5,'Francia Minaya','Jhon','D','12345678','1984-09-20',5,1,NULL,'2023-04-24 08:10:29',NULL,'1'),
(6,'Munayco','José','D','77779999','1999-09-20',3,2,NULL,'2023-04-24 08:10:29',NULL,'1'),
(7,'Prada','Teresa','C','01234567','2002-09-25',3,2,NULL,'2023-04-24 08:10:29',NULL,'1');

/*Table structure for table `sedes` */

DROP TABLE IF EXISTS `sedes`;

CREATE TABLE `sedes` (
  `idsede` int(11) NOT NULL AUTO_INCREMENT,
  `sede` varchar(40) NOT NULL,
  PRIMARY KEY (`idsede`),
  UNIQUE KEY `uk_sede_sde` (`sede`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sedes` */

insert  into `sedes`(`idsede`,`sede`) values 
(4,'Ayacucho'),
(1,'Chincha'),
(3,'Ica'),
(2,'Pisco');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(20) NOT NULL,
  `claveacceso` varchar(80) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_usuario_user` (`usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`usuario`,`claveacceso`,`estado`) values 
(1,'Arturo','$2y$10$4/SKPSG560wnUzmZ/EBB/um6VP7CjXEP3Ts9fHumwxbCN.vQ7iwIi','1');

/* Procedure structure for procedure `spu_cargos_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cargos_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargos_listar`()
BEGIN
	SELECT * FROM cargos ORDER BY 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_carreras_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_carreras_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_carreras_listar`(IN _idescuela INT)
BEGIN
	SELECT idcarrera, carrera 
		FROM carreras
		WHERE idescuela = _idescuela;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_colaboradores_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_colaboradores_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_colaboradores_eliminar`(IN _idcolaborador INT)
BEGIN
	DELETE FROM colaboradores
	WHERE idcolaborador = _idcolaborador;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_colaboradores_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_colaboradores_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_colaboradores_listar`()
BEGIN
	SELECT COLB.idcolaborador,
			 COLB.apellidos,COLB.nombres,
			 COLB.telefono,
			 CARG.cargo,SED.sede,
			 COLB.tipocontrato,COLB.cv,
			 COLB.direccion
	FROM colaboradores COLB
	INNER JOIN cargos CARG ON CARG.idcargo = COLB.idcargo
	INNER JOIN sedes SED ON SED.idsede = COLB.idsede
	WHERE COLB.estado ='1';
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_colaboradores_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_colaboradores_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_colaboradores_registrar`(
	IN apellidos_ 		VARCHAR(40),
	IN nombres_			VARCHAR(40),
	IN telefono_ 		CHAR(12),
	IN idcargo_  		INT,
	IN idsede_ 			INT,
	IN tipocontrato_ 	CHAR(1),
	IN direccion_ 		VARCHAR(40),
	IN cv_ 				VARCHAR(100)
)
BEGIN
	IF cv_ = '' THEN 
		SET cv_ = NULL;
	END IF;
	
	INSERT INTO colaboradores
	(apellidos, nombres, idcargo, idsede, telefono, tipocontrato, direccion, cv)VALUES
	(apellidos_, nombres_, idcargo_, idsede_, telefono_, tipocontrato_, direccion_, cv_);
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_cv_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cv_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cv_eliminar`(IN idcolaborador_ INT)
BEGIN
	SELECT cv FROM colaboradores WHERE idcolaborador = idcolaborador_;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_escuelas_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_escuelas_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_escuelas_listar`()
BEGIN 
	SELECT * FROM escuelas ORDER BY 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_estudiantes_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_estudiantes_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_estudiantes_eliminar`(IN idestudiante_ INT)
BEGIN
	DELETE FROM estudiantes
	WHERE idestudiante = idestudiante_;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_estudiantes_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_estudiantes_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_estudiantes_listar`()
BEGIN
	SELECT	EST.idestudiante,
				EST.apellidos, EST.nombres,
				EST.tipodocumento, EST.nrodocumento,
				EST.fechanacimiento,
				ESC.escuela,
				CAR.carrera,
				SED.sede,
				EST.fotografia
		FROM estudiantes EST
		INNER JOIN carreras CAR ON CAR.idcarrera = EST.idcarrera
		INNER JOIN sedes SED ON SED.idsede = EST.idsede
		INNER JOIN escuelas ESC ON ESC.idescuela = CAR.idescuela
		WHERE EST.estado = '1';
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_estudiantes_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_estudiantes_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_estudiantes_registrar`(
	IN _apellidos 			VARCHAR(40),
	IN _nombres 			VARCHAR(40),
	IN _tipodocumento		CHAR(1),
	IN _nrodocumento		CHAR(8),
	IN _fechanacimiento	DATE,
	IN _idcarrera 			INT,
	IN _idsede 				INT,
	IN _fotografia 		VARCHAR(100)
)
BEGIN
	-- Validar el contenido de _fotografia
	IF _fotografia = '' THEN 
		SET _fotografia = NULL;
	END IF;

	INSERT INTO estudiantes 
	(apellidos, nombres, tipodocumento, nrodocumento, fechanacimiento, idcarrera, idsede, fotografia) VALUES
	(_apellidos, _nombres, _tipodocumento, _nrodocumento, _fechanacimiento, _idcarrera, _idsede, _fotografia);
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_fotografia_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_fotografia_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fotografia_eliminar`(IN idestudiante_ INT)
BEGIN
	SELECT fotografia FROM estudiantes WHERE idestudiante = idestudiante_;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_sedes_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_sedes_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_sedes_listar`()
BEGIN
	SELECT * FROM sedes ORDER BY 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuario_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuario_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuario_login`(IN _usuario VARCHAR(30))
BEGIN
	SELECT 	idusuario, usuario, claveacceso
	FROM usuarios
	WHERE usuario = _usuario AND estado = '1';
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
