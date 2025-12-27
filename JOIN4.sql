CREATE TABLE VENDEDORES(    
    Codigo NUMBER,
    Nombre VARCHAR2(20),
    Apellido1 VARCHAR2(20),
    Apellido2 VARCHAR2(20),
    Estudios VARCHAR2(20),
    Fecha_Alta DATE,
    Cod_Jefe NUMBER,
    Salario NUMBER,
    CONSTRAINT Vendedores_Codigo_pk PRIMARY KEY (Codigo));

ALTER TABLE Vendedores
ADD CONSTRAINT Vendedores_Jefe_fk FOREIGN KEY (Cod_Jefe) REFERENCES Vendedores(Codigo);

INSERT INTO Vendedores VALUES (1,'Juan','Perez','Perez','Informática','22-JAN-2010',NULL,1250);
INSERT INTO Vendedores VALUES (2,'Ana','Garcia','Sanchez','Turismo','23-APR-2011',1,1050);
INSERT INTO Vendedores VALUES (3,'Juan Pedro','Larra','Alvarez','Informática','12-FEB-2011',1,1675);
INSERT INTO Vendedores VALUES (4,'Irene','Vazquez','Pedrosa','Empresariales','15-JUL-2009',2,1350);
INSERT INTO Vendedores VALUES (5,'Alberto','Tena','Orozco','Informática','22-NOV-2010',3,2250);
INSERT INTO Vendedores VALUES (6,'Enrique','Moreno','García','Empresariales','29-MAR-2011',3, 1100);

CREATE TABLE PRODUCTOS(
    Codigo_P NUMBER,
    Nombre VARCHAR2(30),
    Descripcion VARCHAR2(100),
    Precio NUMBER,
    Stock NUMBER,
    Cantidad_Minima NUMBER,
    CONSTRAINT Productos_Codigo_pk PRIMARY KEY (Codigo_P));

INSERT INTO Productos VALUES (1001,'Memoria Ram','Memoria RAM de 8 GB',252,10,5);
INSERT INTO Productos VALUES (1002,'Disco Duro','Disco Duro ACER 320GB',36,12,7);
INSERT INTO Productos VALUES (1003,'Memoria SD','Kingston Tarjeta de memoria flash - 2 GB',5,15,10);
INSERT INTO Productos VALUES (1004,'Tarjeta Gráfica','Gigabyte GV N460OC',150,8,5);

CREATE TABLE VENTAS(
    Codigo_Venta NUMBER,
    Codigo_Producto NUMBER,
    Codigo_Vendedor NUMBER,
    Fecha_Venta DATE,
    Cantidad_Producto NUMBER,
    Precio_Total NUMBER,
    CONSTRAINT Ventas_Codigo_pk PRIMARY KEY (Codigo_Venta,Codigo_Producto),
    CONSTRAINT Ventas_Producto_fk FOREIGN KEY (Codigo_Producto)
        REFERENCES PRODUCTOS (Codigo_P),
    CONSTRAINT Ventas_Vendedor_fk FOREIGN KEY (Codigo_Vendedor) REFERENCES VENDEDORES(Codigo));

INSERT INTO VENTAS VALUES (1,1001,2,'30-MAY-2011',1,474);
INSERT INTO VENTAS VALUES (1,1002,2,'30-MAY-2011',2,474);
INSERT INTO VENTAS VALUES (1,1004,2,'30-MAY-2011',1,474);
INSERT INTO VENTAS VALUES (2,1002,2,'29-JUN-2010',3,108);
INSERT INTO VENTAS VALUES (3,1002,1,'28-OCT-2010',1,191);
INSERT INTO VENTAS VALUES (3,1003,1,'28-OCT-2010',1,191);
INSERT INTO VENTAS VALUES (3,1004,1,'28-OCT-2010',1,191);
INSERT INTO VENTAS VALUES (4,1002,5,'31-DEC-2010',3,258);
INSERT INTO VENTAS VALUES (4,1004,5,'31-DEC-2010',1,258);

/*1. Muestra el código y nombre de todos los productos que han sido vendidos 4 filas*/
SELECT DISTINCT p.Nombre, p.Codigo_P
FROM PRODUCTOS p INNER JOIN VENTAS v ON p.Codigo_P = v.Codigo_Producto;

/*2. Muestra el código y nombre de todos los productos que se han vendido cuyo precio está
en el rango [50-150] 1 fila*/
SELECT DISTINCT p.Nombre, p.Codigo_P
FROM PRODUCTOS p INNER JOIN VENTAS v ON p.Codigo_P = v.Codigo_Producto
WHERE p.precio BETWEEN 50 AND 150;


/*3. Muestra el nombre de todos los vendedores que han vendido algún producto y cuya fecha
de alta fue en alguno de los meses de verano (Junio, Julio o Agosto) 0 filas*/
SELECT DISTINCT p.nombre, v.Fecha_Alta 
FROM PRODUCTOS p INNER JOIN VENDEDORES v ON P.Codigo_P = v.Codigo
WHERE TO_CHAR (v.Fecha_Alta, 'MM') IN ('06','07','08');

/*4. Muestra el nombre de todos los vendedores cuyo nombre comienza con la misma letra
que el nombre de su jefe. 1 fila*/
SELECT DISTINCT V.Nombre AS "Nombre", J.Nombre AS "Nombre jefe"
FROM Vendedores V 
INNER JOIN Vendedores J ON V.Cod_Jefe=J.Codigo
WHERE LOWER(SUBSTR(V.Nombre,1,1)) = LOWER (SUBSTR(J.Nombre,1,1));

/*5. Muestra el nombre de todos los vendedores y el nombre de su jefe. 5 filas*/
SELECT DISTINCT V.Nombre AS "Nombre", J.Nombre AS "Nombre jefe"
FROM Vendedores V 
INNER JOIN Vendedores J ON V.Cod_Jefe = J.Codigo;

/*6. Muestra todos los vendedores que tienen un salario superior al vendedor Alberto 0 filas*/
SELECT DISTINCT v.nombre
FROM vendedores v 
JOIN Vendedores a ON v.Salario > a.salario
WHERE lower(a.nombre) = 'alberto';

/*7. Muestra aquellos vendedores cuyo jefe ha vendido algún producto. 3 filas*/
SELECT DISTINCT V.Nombre AS "Nombre"
FROM Vendedores V 
INNER JOIN Vendedores J ON V.Cod_Jefe = J.Codigo
INNER JOIN ventas ve ON J.Codigo = ve.Codigo_Vendedor
WHERE ve.Codigo_Venta IS NOT NULL; 

/*8. Muestra aquellos vendedores que tienen un jefe que estudió Informática 4 filas*/
SELECT DISTINCT V.Nombre AS "Nombre"
FROM Vendedores V 
INNER JOIN Vendedores J ON V.Cod_Jefe = J.Codigo
WHERE j.estudios = 'Informática';

/*9. Muestra aquellos productos cuyo precio es superior al del producto que tiene código 8. 0
filas*/
SELECT p.NOMBRE
FROM PRODUCTOS p 
INNER JOIN productos a ON P.precio > a.precio
WHERE a.codigo_p = 8;

/*10. Muestra aquellos productos que no han sido vendidos 0 filas*/
SELECT P.NOMBRE
FROM PRODUCTOS p 
INNER JOIN VENTAS v ON p.codigo_p = v.Codigo_Producto
WHERE V.Codigo_Venta IS NULL;

/*11. Muestra el nombre de todos los vendedores junto al nombre del producto que han
vendido (Mostrar todos los vendedores hayan vendido o no productos) 12 filas*/
SELECT V.NOMBRE, P.NOMBRE
FROM VENDEDORES v 
LEFT JOIN VENTAS ve ON VE.Codigo_Vendedor = v.codigo
INNER JOIN PRODUCTOS p ON p.codigo_p = ve.Codigo_Producto;
