--El script que nos ha dado
DROP TABLE Historial_Salarial CASCADE CONSTRAINTS;
DROP TABLE Historial_Laboral  CASCADE CONSTRAINTS;
DROP TABLE Trabajos CASCADE CONSTRAINTS;
DROP TABLE Estudios CASCADE CONSTRAINTS;
DROP TABLE Universidades CASCADE CONSTRAINTS;
DROP TABLE Departamentos CASCADE CONSTRAINTS;
DROP TABLE Empleados CASCADE CONSTRAINTS;

CREATE TABLE Empleados
(
	DNI NUMBER(8),
	Nombre VARCHAR(10) CONSTRAINT Empleados_Nombre_nn NOT NULL,
	Apellido1 VARCHAR(15),
	Apellido2 VARCHAR(15),
	Direcc1 VARCHAR(25),
	Direcc2 VARCHAR(20),
	Ciudad VARCHAR(20),
	Municipio VARCHAR(20),
	Cod_Postal VARCHAR(5),
	Sexo CHAR(1),
	Fecha_Nac DATE,
	CONSTRAINT Empleados_Sexo_ck CHECK (Sexo='H' OR Sexo='M'),
	CONSTRAINT Empleados_DNI_pk PRIMARY KEY(DNI)
);

CREATE TABLE Departamentos
(
	Dept_Cod NUMBER(5),
	Nombre_Dpto VARCHAR(30),
	Jefe NUMBER(5),
	Presupuesto NUMBER NOT NULL,
	Pres_Actual NUMBER,
	CONSTRAINT Departamentos_Nombre_uu UNIQUE (Nombre_Dpto),
	CONSTRAINT Departamentos_Dept_Cod_pk PRIMARY KEY(Dept_Cod),
	CONSTRAINT Departamentos_Jefe_fk FOREIGN KEY (Jefe)
	REFERENCES Departamentos (Dept_Cod)
);

CREATE TABLE Universidades
(
	Univ_Cod NUMBER(5),
	Nombre_Univ VARCHAR(25),
	Ciudad VARCHAR(20),
	Municipio VARCHAR(20),
	Cod_Postal NUMBER(5),
	CONSTRAINT Universidades_Univ_Cod_pk PRIMARY KEY (Univ_Cod)
);


CREATE TABLE Estudios
(
	Empleado_DNI NUMBER(8),
	Universidad NUMBER(5),
	Anyo NUMBER,
	Grado VARCHAR(3),
	Especialidad VARCHAR(20),
	CONSTRAINT Estudios_Empleado_DNI_pk PRIMARY KEY (Empleado_DNI, Anyo),
	CONSTRAINT Estudios_Universidad_fk FOREIGN KEY (Universidad) REFERENCES Universidades(Univ_Cod) ON DELETE CASCADE,
	CONSTRAINT Estudios_Empleado_DNI_fk FOREIGN KEY (Empleado_DNI) REFERENCES Empleados(DNI) ON DELETE CASCADE
);

CREATE TABLE Trabajos
(
	Codigo NUMBER(5),
	Nombre VARCHAR(20),
	Salario_Min NUMBER(2),
	Salario_Max NUMBER(2),
	CONSTRAINT Trabajos_Nombre_uu UNIQUE (Nombre),
	CONSTRAINT Trabajos_Codigo_pk PRIMARY KEY(Codigo)
);


CREATE TABLE Historial_Laboral
(
	Empleado_DNI NUMBER(8),
	Trabajo_Cod NUMBER(5),
	Fecha_Inicio DATE,
	Fecha_Fin DATE,
	Dpto_Cod NUMBER(5),
	Supervisor_DNI NUMBER(8),
	CONSTRAINT H_Labl_Empleado_pk PRIMARY KEY(Empleado_DNI,Fecha_Inicio),
	CONSTRAINT H_Labl_Fechas_ck CHECK (Fecha_Inicio<Fecha_Fin OR Fecha_Fin IS NULL),
	CONSTRAINT H_Labl_Empleado_fk FOREIGN KEY (Empleado_DNI) REFERENCES Empleados(DNI) ON DELETE CASCADE,
	CONSTRAINT H_Labl_Trabajo_Cod_fk FOREIGN KEY (Trabajo_Cod) REFERENCES Trabajos(Codigo) ON DELETE CASCADE,
	CONSTRAINT H_Labl_Dept_Cod_fk FOREIGN KEY (Dpto_Cod) REFERENCES Departamentos(Dept_Cod) ON DELETE CASCADE,
	CONSTRAINT H_Labl_Supervisor_fk FOREIGN KEY (Supervisor_DNI) REFERENCES Empleados(DNI) ON DELETE CASCADE
);

CREATE TABLE Historial_Salarial
(
	Empleado_DNI NUMBER(8),
	Salario NUMBER,
	Fecha_Comienzo DATE,
	Fecha_Fin DATE,
	CONSTRAINT Historial_Salarial_Empleado_pk PRIMARY KEY(Empleado_DNI,Fecha_Comienzo),
	CONSTRAINT Historial_Salarial_Empleado_fk FOREIGN KEY (Empleado_DNI) REFERENCES Empleados(DNI) ON DELETE CASCADE
);

--EJERCICIO 1

--empleados
INSERT INTO Empleados
	VALUES (12345678,'Jose Luis','Visbal','Simfonia','A/ Guaranai 26','Los 100 Acres','La suya','uno',52413,'H','20-DEC-00');

INSERT INTO Empleados (DNI, Nombre, Apellido1, Apellido2, Direcc1, Direcc2, Ciudad, Municipio, Cod_Postal, Sexo, Fecha_Nac)
	VALUES (87654321,'Sofia','Azucar','Moreno','A/ blanca','Cooperativa','Cadiz','Cadiz',41113,'M','13-NOV-91');

--departamentos
INSERT INTO Departamentos
	VALUES (34612,'Recursos humanos',34612,12000,10000);

INSERT INTO Departamentos (Dept_Cod, Nombre_Dpto, Jefe, Presupuesto, Pres_Actual)
	VALUES (27957,'Investigación Tecn.',27957,24000,17300);

--Universidad
INSERT INTO Universidades
	VALUES (51243,'San Felipe neri','Cadiz',12,11643);

INSERT INTO Universidades (Univ_Cod, Nombre_Univ, Ciudad, Municipio, Cod_Postal)
	VALUES (23836,'Safa Villoslada','Cadiz',58,22262);

--Estudios
INSERT INTO Estudios 
	VALUES (12345678,51243,2000,'1G','Gamer pro.');

INSERT INTO Estudios (Empleado_DNI, Universidad, Anyo, Grado, Especialidad)
	VALUES (87654321,23836,1996,'2G','especialidad');

--Trabajos
INSERT INTO Trabajos
	VALUES (96138,'Recursos Humanos',11,44);

INSERT INTO Trabajos (Codigo, Nombre, Salario_Min, Salario_Max)
	VALUES (70012,'Investigación Cul',22,77);

--Historial Laboral
INSERT INTO Historial_Laboral
	VALUES (12345678,96138,'10-DEC-10','11-DEC-11',34612,87654321);

INSERT INTO Historial_Laboral (Empleado_DNI, Trabajo_Cod, Fecha_Inicio, Fecha_Fin, Dpto_Cod, Supervisor_DNI)
	VALUES (87654321,70012,'03-FEB-5','01-MAY-09',27957,12345678);

--Historial Salarial
INSERT INTO Historial_Salarial
	VALUES (12345678,1200,'03-MAY-01','04-AUG-05');

INSERT INTO Historial_Salarial (Empleado_DNI,Salario,Fecha_Comienzo,Fecha_Fin)
	VALUES (87654321,1870,'06-FEB-07','12-FEB-05');

--EJERCICIO 2

--Empleados
ALTER TABLE Empleados DROP CONSTRAINT Empleados_Sexo_ck; 

ALTER TABLE Empleados ADD CONSTRAINT Empleados_Sexo_ck CHECK (Sexo='H' OR Sexo='M' OR Sexo='P');

INSERT INTO Empleados (Nombre, Apellido1, Apellido2,DNI,Sexo)
	VALUES ('Sergio','Palma','Entrena',111222,'P');

INSERT INTO Empleados (Nombre, Apellido1, Apellido2,DNI,Sexo)
	VALUES ('Lucia','Ortega','Plus',222333,NULL);

--Historial Laboral

INSERT INTO Historial_Laboral (Empleado_DNI, Trabajo_Cod, Fecha_Inicio, Fecha_Fin, Dpto_Cod, Supervisor_DNI)
	VALUES (111222,NULL,'16-JUN-1996',NULL,NULL,222333);

--Pregunta

UPDATE Historial_Laboral
	SET Supervisor_DNI= 999777
	WHERE Supervisor_DNI= 222333;

-- Da error porque mo existe en la direccion padre

