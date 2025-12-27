-- EJERCICIO 1

DROP TABLE Profesores CASCADE CONSTRAINTS;
DROP TABLE Cursos CASCADE CONSTRAINTS;
DROP TABLE Alumnos CASCADE CONSTRAINTS;

CREATE TABLE Profesores(
	Nombre VARCHAR(20),
	Apellido1 VARCHAR(20),
	Apellido2 VARCHAR(20),
	DNI VARCHAR(9), 
	Direccion VARCHAR(100),
	Titulo VARCHAR(100),
	Gana NUMBER CONSTRAINT Profesores_Gana_nn NOT NULL,
	CONSTRAINT Profesores_Nombre_uu UNIQUE(Nombre, Apellido1,Apellido2),
	CONSTRAINT Profesores_DNI_pk PRIMARY KEY(DNI));

	CREATE TABLE Cursos(
	Nombre_Curso VARCHAR(50),
	Cod_Curso NUMBER,
	DNI_Profesor VARCHAR(9),
	Maximo_Alumnos NUMBER,
	Fecha_Inicio DATE,
	Fecha_Fin DATE,
	Num_Horas NUMBER CONSTRAINT Cursos_Horas_nn NOT NULL,
	CONSTRAINT Cursos_Nombre_Curso_uu UNIQUE(Nombre_Curso),
	CONSTRAINT Cursos_Cod_Curso_pk PRIMARY KEY(Cod_Curso),
	CONSTRAINT Cursos_Fechas_ck CHECK (Fecha_Inicio<Fecha_Fin),
	CONSTRAINT Cursos_Profesor_fk FOREIGN KEY(DNI_Profesor) 
	REFERENCES Profesores(DNI) ON DELETE CASCADE);

	CREATE TABLE Alumnos(
	Nombre VARCHAR(20),
	Apellido1 VARCHAR(20),
	Apellido2 VARCHAR(20),
	DNI VARCHAR(9), 
	Direccion VARCHAR(100),
	Sexo CHAR(1),
	Fecha_Nacimiento DATE,
	Curso NUMBER CONSTRAINT Alumnos_Curso_nn NOT NULL,
	CONSTRAINT Alumnos_Nombre_pk PRIMARY KEY(DNI),
	CONSTRAINT Alumnos_Sexo_ck CHECK (Sexo='H' OR Sexo='M'),
	CONSTRAINT Alumnos_Curso_fk FOREIGN KEY (Curso) 
	REFERENCES Cursos(Cod_Curso) ON DELETE CASCADE);

-- EJERCICIO 2
-- PROFESORES
    INSERT INTO Profesores 
        VALUES ('Juan','Arch','López',32432455,'Puerta Negra, 4','Ing. Informática',7500);

    INSERT INTO Profesores 
        VALUES ('María','Oliva','Rubio',43215643,'Juan Alfonso 32','Lda. Fil. Inglesa',5400);

-- CURSOS
    INSERT INTO Cursos 
        VALUES ('Inglés Básico',1,43215643,15,'01-NOV-00','22-DEC-00',120);
    
    INSERT INTO Cursos 
        VALUES ('Administración Linux',2,32432455,NULL,'01-SEP-00',NULL,80);

-- ALUMNOS    
    INSERT INTO Alumnos
        VALUES ('Lucas','Manilva','Lopéz',123523,'Alhamar 3','H','01-NOV-97',1);
    
    INSERT INTO Alumnos
        VALUES ('Antonia','López','Alcantara',2567567,'Maniquí 21','M',NULL,2);

    INSERT INTO Alumnos
        VALUES ('Manuel','Alcantara','Pedrós',3123689,'Julian 2',NULL,NULL,2);

    INSERT INTO Alumnos
        VALUES ('José','Pérez','Caballar',4896765,'Jarcha 5','H','03-FEB-1977',1);

-- EJERCICIO 3
    INSERT INTO Alumnos
        VALUES ('Sergio','Navas','Retal',134593,'C','H',NULL,1);


-- EJERCICIO 4
ALTER TABLE Profesores ADD (
    Edad NUMBER (2)
);

-- EJERCICIO 5
ALTER TABLE Profesores ADD (
    CONSTRAINT edad_constraint CHECK (Edad BETWEEN 18 AND 65)
);

UPDATE Cursos
	set Num_Horas =101
	WHERE Num_Horas<101;

ALTER TABLE Cursos ADD (
   CONSTRAINT MAX_curso_constraint CHECK (Maximo_Alumnos>=10),
    CONSTRAINT num_horas_constraint CHECK (Num_Horas>100)
);


-- EJERCICIO 6
ALTER TABLE Alumnos DROP CONSTRAINT Alumnos_Sexo_ck;

-- EJERCICIO 7
ALTER TABLE Alumnos ADD (
	CONSTRAINT Curso_Unique_ck UNIQUE (Curso)
); 
/* Esta mal porue aunque un alumno solo puede estar matriculado en un solo curso, la tabla 
 Alumnos se trata de varios, con lo cual se repetira el curso y no puede ser unico*/

--EJERCICIO 8
ALTER TABLE PROFESORES DROP CONSTRAINT Profesores_Gana_nn;

--EJERCICIO 9

ALTER TABLE CURSOS MODIFY FECHA_INICIO DATE NOT NULL;

-- EJERCICIO 10
ALTER TABLE Cursos DROP CONSTRAINT Cursos_Profesor_fk;

ALTER TABLE Profesores DROP CONSTRAINT Profesores_DNI_pk;

ALTER TABLE Profesores DROP CONSTRAINT Profesores_Nombre_uu;

ALTER TABLE Profesores ADD (
	CONSTRAINT Profesores_Multi_pk PRIMARY KEY (Nombre, Apellido1, Apellido2)
);

-- EJERCICIO 11
-- Dara error porque ña tabla de alumnos no tiene Titulo ni Gana
    INSERT INTO Alumnos (Nombre, Apellido1, Apellido2, DNI, Direccion, Titulo, Gana)
        VALUES ('Juan','Arch','López',32432455,'Puerta Negra, 4','Ing. Informática',NULL);

-- EJERCICIO 12
UPDATE Alumnos
	SET  Fecha_Nacimiento= '23-DEC-1976'
	WHERE Nombre='Antonia' AND Apellido1='López';

-- EJERCICIO 13
-- dara error porque no hay nigun curso de codigo 5
UPDATE Alumnos
	SET  CURSO= 5
	WHERE Nombre='Antonia' AND Apellido1='López';

-- EJERCICIO 14
-- no borra nada porqu no hay ningun profesor llamado Laura Jimenez
DELETE Profesores
	WHERE nombre='Laura' AND Apellido1='Jiménez';

--EJERCICIO 15
CREATE GLOBAL TEMPORARY TABLE NOMBRE_DE_ALUMNOS(
	NOMBRE_COMPLETO VARCHAR (62)
);
-- Solo concadeno el nombre y un apellido sin espacio porque si intento agregar mas me da error

INSERT INTO NOMBRE_DE_ALUMNOS (NOMBRE_COMPLETO)
	SELECT CONCAT (nombre,Apellido1) FROM Alumnos;