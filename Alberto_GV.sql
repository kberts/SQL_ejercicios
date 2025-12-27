--ELIMINACION DE TABLAS
DROP TABLE Clientes;
DROP TABLE Empleados;
DROP TABLE Pedidos;
DROP TABLE Detalle_Pedidos;
DROP TABLE Productos;
DROP TABLE Oficinas;
DROP VIEW ASIG_2022;
DROP VIEW AL_2022;


--PARTE 1
CREATE TABLE Clientes (
	Codigo VARCHAR (9) PRIMARY KEY,
	Nombre VARCHAR (15),
	Apellidos VARCHAR (30),
	Cod_empleado VARCHAR (9)
);

CREATE TABLE Empleados (
	Codigo VARCHAR (9) PRIMARY KEY,
	Nombre VARCHAR (15),
	Apellidos VARCHAR (30),
	Codigo_jefe VARCHAR (9),
	Puesto VARCHAR (9),
	Cod_oficina VARCHAR (9)
);

CREATE TABLE Pedidos (
	Cod_Pedido VARCHAR(9) PRIMARY KEY,
	Fecha_Entrega DATE,
	Estado VARCHAR (9),
	Cod_Cliente VARCHAR (9)
);

CREATE TABLE Detalle_Pedidos (
	Cod_Pedido VARCHAR(9) PRIMARY KEY,
	Cod_Producto VARCHAR (9),
	Cantidad NUMBER (4),
	Numero_Linea NUMBER (11)
);

CREATE TABLE Productos(
	Cod_Producto VARCHAR (9) PRIMARY KEY,
	Nombre VARCHAR(15),
	Proveedor VARCHAR(15)
);

CREATE TABLE Oficinas (
	Cod_oficina VARCHAR (9) PRIMARY KEY,
	Ciudad VARCHAR (15),
	Direccion VARCHAR (15)
); 

ALTER TABLE Clientes ADD(
	CONSTRAINTS Clien_Cod_Empleado_FK FOREIGN KEY (Cod_empleado)
		REFERENCES Empleados(Codigo)
);

ALTER TABLE Empleados ADD (
	CONSTRAINTS Emp_Codigo_jefe_CF FOREIGN KEY (Codigo_jefe) 
		REFERENCES Empleados(Codigo) ON DELETE CASCADE,
	CONSTRAINTS Emp_Codigo_ofi_CF FOREIGN KEY (Cod_oficina) 
		REFERENCES Oficinas(Cod_oficina) ON DELETE CASCADE
);

ALTER TABLE Pedidos ADD(
	CONSTRAINTS Pedidos_Cod_Cliente_FK FOREIGN KEY (Cod_Cliente)
		REFERENCES Clientes (Codigo)
);

ALTER TABLE Detalle_Pedidos ADD(
	CONSTRAINTS Det_Products_FK FOREIGN KEY (Cod_Producto) 
		REFERENCES Productos(Cod_Producto)
);

--PARTE 2
ALTER TABLE Pedidos ADD (
	Fecha_Pedido DATE DEFAULT SYSDATE
);

ALTER TABLE Clientes ADD (
	Ciudad VARCHAR (15)DEFAULT 'Cádiz'
);

ALTER TABLE Productos ADD (
	Stock NUMBER (2),
	PVP NUMBER (3,2)
);

--PARTE 3

ALTER TABLE Clientes MODIFY(
CONSTRAINTS nombre_Unico Nombre VARCHAR (15) UNIQUE
);

ALTER TABLE Productos ADD (
	CONSTRAINTS PVPCHECK CHECK (PVP>'999.98'
	OR PVP<'100.01')
);


--PARTE 4
CREATE VIEW ASIG_2022 AS
	SELECT Nombre, Num_horas, Creditos_ECTS
	FROM ASIGNATURAS 
	WHERE Creditos_ECTS ='5'
	WITH CHECK OPTION;
	
SELECT * FROM ASIG_2022;

--PARTE4

CREATE VIEW AL_2022 AS 
	SELECT Nombre, Apellidos, Direccion, CP
	FROM ALUMNOS
	WITH READ ONLY;
	
SELECT * FROM AL_2022;

--PARTE 6
CREATE INDEX Apellidos_Al
	ON ALUMNOS (Apellidos);

SELECT index_name, column_name
	FROM user_ind_columns
	WHERE table_name ='ALUMNOS';