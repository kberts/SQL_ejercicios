drop table alumnos cascade constraints;
drop table profesores cascade constraints;
drop table cursos cascade constraints;
drop table manuales cascade constraints;
drop table oposiciones cascade constraints;
drop table matriculas cascade constraints;
drop table cursooposicion cascade constraints;
drop table cursomanual cascade constraints;

-- CREACION DE TABLAS
create table alumnos
(
 dni 		varchar2(9) constraint pk_alumnos primary key,
 nombre 	varchar2(20),
 apellido1 	varchar2(20),
 apellido2 	varchar2(20),
 direccion 	varchar2(30),
 sexo 		varchar2(1),
 fechanac 	date
);



create table profesores
(
 dni 		varchar2(9) constraint pk_profesores primary key,
 nombre 	varchar2(20),
 apellido1 	varchar2(20),
 apellido2 	varchar2(20),
 direccion 	varchar2(30),
 titulo 	varchar2(30),
 sueldo number(6)
);

create table cursos
(
 codigocurso varchar2(5) constraint pk_cursos primary key,
 nombrecurso varchar2(30),
 maxalumnos number(4),
 fechaini date,
 fechafin date,
 numhoras number(4),
 profesor varchar2(9) constraint fk_profesores references profesores
);

create table manuales
(
 referencia varchar2(6) constraint pk_manuales primary key,
 titulo varchar2(40),
 autor varchar2(30),
 fechapub date,
 precio number(4)
);

create table oposiciones
(
 codigo   varchar2(6) constraint pk_oposiciones primary key,
 nombre	 varchar2(30),
 fechaexamen date,
 organismo varchar2(30),
 plazas	 number(4),
 categoria varchar2(1) constraint cat_val check (categoria in ('A','B','C','D','E'))
);

create table matriculas
(
 dnialumno varchar2(9)  constraint fk_alumnos references alumnos,
 codcurso varchar2(5)  constraint fk_cursos references cursos,
 pruebaA number(2)  constraint pruebaA_val check (pruebaA between 0 and 50),
 pruebaB number(2) constraint pruebaB_val check (pruebaB between 0 and 50),
 tipo varchar2(7) constraint tipo_val check (tipo in ('Oficial','Libre')),
 inscripcion date,
 constraint pk_matriculas primary key (dnialumno, codcurso)
);

create table cursooposicion
(
 codcurso varchar2(5) constraint fk_cursos2 references cursos,
 codoposicion varchar2(6) constraint fk_oposicion references oposiciones,
 constraint pk_cursooposicion primary key(codcurso, codoposicion)
);

create table cursomanual
(
 codcurso varchar2(5) constraint fk_cursos3 references cursos,
 referencia varchar2(6) constraint fk_manuales references manuales,
 constraint pk_cursomanual primary key (codcurso, referencia)
);


-- INSERCION DE REGISTROS

-- ALUMNOS (dni, nombre, apellido1, apellido2, direccion, sexo, fechanac)

insert into alumnos
values('1111','Carlos','Puerta','Perez','c/ P�, 21','V','12/09/1989');

insert into alumnos
values('2222','Luisa','Sanchez','Donoso','c/ Sierpes, 1','M','12/05/1968');

insert into alumnos
values('3333','Eva','Ramos','Prieto','c/ Rueda, 31','M','12/04/1969');

insert into alumnos
values('4444','Luis','Paez','Garcia','c/ Martin Villa, 21','V','22/04/1979');

insert into alumnos
values('5555','Ana','Padilla','Torres','c/ Tetuan, 2','M','12/09/1970');

insert into alumnos
values('6666','Lola','Flores','Ruiz','c/ Real, 14','M','18/04/1970');

-- PROFESORES (dni, nombre, apellido1, apellido2, direccion, titulo, sueldo)

insert into profesores
values('111','Manuel','Lopez','Garcia','c/ Albeniz,12','Ingeniero de Caminos',2000);

insert into profesores
values('222','Luis','Perez','Sanchez','c/ Huelva, 1','Licenciado en Psicologia',1400);

insert into profesores
values('333','Ana','Garcia','Lopez','c/ Sevilla,2','Ingeniero de Caminos',2200);

insert into profesores
values('444','Eva','Parra','Ruiz','c/ Astoria,7','Licenciado en Derecho',1200);

insert into profesores
values('555','Federico','Flores','Alba','c/ Tarifa, 1','Ingeniero Inform�tico',2500);

insert into profesores
values('666','Alberto','Moreno','Rodriguez','c/ Parra, 2','Ingeniero de Caminos',2100);


-- CURSOS  (codigocurso,nombrecurso,maxalumnos,fechaini,fechafin,numhoras,profesor)

insert into cursos 
values('0001','Funci�n Publica',120,'03/05/09','30/06/09',400,'444');

insert into cursos
values('0002','Los chiquillos',180,'13/05/09','30/08/09',600,'222');

insert into cursos
values('0003','Puentes Atirantados',20,'03/12/08','30/06/09',800,'111');

insert into cursos
values('0004','Vida familiar de los presos',120,'03/05/09','30/06/09',400,'222');

insert into cursos
values('0005','La Constitucion',230,'03/05/09','30/06/09',100,'444');

insert into cursos
values('0006','Programaci�n Visual',80,'03/09/09','30/09/09',30,'555');

-- MANUALES (referencia, titulo, autor, fechapub, precio)

insert into manuales
values('M001', 'El Derecho', 'Garz�n', '12/05/06', 23);

insert into manuales
values('M002', 'C y PHP: lo mismo es', 'Joseph Sunday', '12/09/07', 12);

insert into manuales
values('M003', 'Los delincuentes y sus sentimientos', 'El Chori', '12/07/08', 16);

insert into manuales
values('M004', 'Las Administraciones Publicas', 'Ruiz', '12/07/07', 8);

insert into manuales
values('M005', 'Estatica y Dinamica', 'Calatrava', '02/05/05', 43);


insert into manuales
values('M006', 'Problemas irresolubles en JSP', 'John Tagua', '07/07/07', 25);


-- OPOSICIONES (codigo, nombre, fechaexamen, organismo, plazas, categoria)

insert into oposiciones
values('C-502','Maestros de Primaria','27/05/10','Consejeria Educacion', 1220, 'B');

insert into oposiciones
values('C-512','Funcionario de Prisiones','20/06/10','Consejeria Justicia', 120, 'C');

insert into oposiciones
values('C-522','Profesores de Inform�tica','27/06/09','Consejeria Educacion', 12, 'A');

insert into oposiciones
values('C-532','Jardineros del Estado','27/05/10','Ministerio Medio Ambiente', 10, 'D');

insert into oposiciones
values('C-542','Administrativos','27/05/10','Ayuntamiento DH', 12, 'C');

insert into oposiciones
values('C-552','Ingenieros del Ejercito','27/09/10','Ministerio Defensa', 120, 'A');


-- MATRICULAS

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('1111','0001',12,8,'Oficial','12/06/06');

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('1111','0005',18,5,'Oficial','12/07/06');

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('2222','0003',25,28,'Libre','12/08/06');

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('2222','0005',32,28,'Libre','12/09/06');

insert into matriculas (dnialumno, codcurso, pruebaA, tipo, inscripcion)
values('3333','0006',12,'Oficial','12/10/06');

insert into matriculas (dnialumno, codcurso, pruebaB, tipo, inscripcion)
values('4444','0006',18,'Oficial','12/11/06');

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('5555','0006',20,48,'Oficial','12/12/06');

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('5555','0002',32,38,'Libre','12/01/07');

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('5555','0003',11,18,'Oficial','12/02/07');

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('5555','0001',11,38,'Oficial','12/03/07');

insert into matriculas (dnialumno, codcurso, pruebaA, pruebaB, tipo, inscripcion)
values('5555','0005',42,48,'Oficial','12/04/07');

-- CURSOOPOSICION  (codcurso, codoposicion)

insert into cursooposicion
values('0001','C-502');

insert into cursooposicion
values('0001','C-512');

insert into cursooposicion
values('0001','C-522');

insert into cursooposicion
values('0001','C-532');

insert into cursooposicion
values('0001','C-542');

insert into cursooposicion
values('0001','C-552');

insert into cursooposicion
values('0002','C-502');

insert into cursooposicion
values('0003','C-552');

insert into cursooposicion
values('0004','C-512');

insert into cursooposicion
values('0006','C-522');

insert into cursooposicion
values('0005','C-502');

insert into cursooposicion
values('0005','C-512');

insert into cursooposicion
values('0005','C-522');

insert into cursooposicion
values('0005','C-532');

insert into cursooposicion
values('0005','C-542');

-- CURSOMANUAL

insert into cursomanual (codcurso, referencia)
values('0001','M001');

insert into cursomanual (codcurso, referencia)
values('0004','M001');

insert into cursomanual (codcurso, referencia)
values('0005','M001');

insert into cursomanual (codcurso, referencia)
values('0006','M002');

insert into cursomanual (codcurso, referencia)
values('0004','M003');

insert into cursomanual (codcurso, referencia)
values('0001','M004');

insert into cursomanual (codcurso, referencia)
values('0005','M004');

insert into cursomanual (codcurso, referencia)
values('0003','M005');

insert into cursomanual (codcurso, referencia)
values('0006','M006');

/*1.- Obtener un listado con los alumnos más jóvenes que 'Luisa Sánchez Donoso'. 5
filas*/
SELECT nombre, apellido1, apellido2 fechaNac
FROM Alumnos
WHERE fechaNac > (SELECT fechaNac from Alumnos where nombre like 'Luisa' and apellido1 = 'Sanchez' and apellido2 = 'Donoso');

/*2.- Obtener el nombre de los cursos en los que hay más alumnos matriculados que
en el curso más numeroso del profesor 'Manuel López García'. 2 filas*/
SELECT c.nombrecurso
FROM cursos c
JOIN matriculas m ON c.codigocurso = m.codcurso
GROUP BY c.codigocurso, c.nombrecurso
HAVING COUNT(*) > (
    SELECT MAX(cuenta_alumnos)
    FROM (
        SELECT COUNT(*) AS cuenta_alumnos
        FROM cursos cu
        JOIN profesores p ON cu.profesor = p.dni
        JOIN matriculas ma ON cu.codigocurso = ma.codcurso
        WHERE LOWER(p.nombre) = 'manuel'
          AND LOWER(p.apellido1) = 'lopez'
          AND LOWER(p.apellido2) = 'garcia'
        GROUP BY cu.codigocurso
    )
);

/*3.- Obtener el nombre completo de los profesores que impartan cursos con un
número de horas mayor que alguno de los cursos impartidos por el profesor
'Manuel López García'. 0 filas*/
SELECT NOMBRE ||' '|| APELLIDO1 ||' '|| APELLIDO2 
FROM PROFESORES P JOIN CURSOS C ON P.DNI = C.PROFESOR 
WHERE numHORAS > (SELECT numHORAS FROM PROFESORES P JOIN CURSOS C 
                                                    ON P.DNI = C.PROFESOR 
                                                    WHERE LOWER(NOMBRE) LIKE 'manuel' 
                                                    AND LOWER(apellido1) LIKE 'lopez' 
                                                    AND LOWER(apellido2) LIKE 'garcia');  

/*4.- Obtener el nombre y los apellidos de los alumnos que no se han matriculado
por libre en ningún curso. 4 filas*/
SELECT DISTINCT a.nombre, a.apellido1, a.apellido2
FROM Alumnos a
JOIN matriculas m ON a.dni = m.dniAlumno
WHERE tipo <>'Libre';

SELECT DISTINCT NOMBRE, APELLIDO1, apellido2
FROM Alumnos
WHERE dni IN (SELECT dniAlumno FROM matriculas WHERE LOWER(tipo) <> 'libre');

/*5.- Obtener nombre, apellidos, sueldo y título de aquellos profesores que tienen un
sueldo mayor que el de alguno de sus compañeros de titulación. 2 filas*/
SELECT DISTINCT p1.nombre AS NOMBRE, p1.apellido1 AS PRIMER_APELLIDO, p1.sueldo AS SUELDO, p1.titulo AS TITULACION
FROM profesores p1 
WHERE p1.sueldo > ANY (SELECT MIN(p2.sueldo) 
						FROM profesores p2 
						WHERE p1.titulo = p2.titulo )
GROUP BY p1.nombre, p1.apellido1, p1.sueldo, p1.titulo;

/*6.- Obtener el nombre y apellidos de los alumnos que solo se han presentado a una
de las pruebas en algún curso. 2 filas*/
SELECT nombre, apellido1, apellido2
FROM alumnos
WHERE dni IN (SELECT dnialumno
    				FROM matriculas
    				WHERE (pruebaa IS NULL AND pruebab IS NOT NULL) OR 
                        (pruebaa IS NOT NULL AND pruebab IS NULL));

/*7.- Obtener un listado con el nombre completo de los alumnos matriculados en el
curso 'Función Pública' junto con sus notas en ambas pruebas siempre que su
media entre las dos supere los 25 puntos. 0 filas*/
SELECT A.NOMBRE, A.APELLIDO1, A.APELLIDO2, M.pruebaa, m.pruebab 
FROM ALUMNOS A JOIN MATRICULAS M ON A.DNI = M.DNIALUMNO 
JOIN CURSOS C ON M.CODCURSO = C.CODIGOCURSO  
WHERE Lower(C.NOMBRECURSO) LIKE 'funcion publica' 
GROUP BY A.NOMBRE, A.APELLIDO1, A.APELLIDO2, M.pruebaa, m.pruebab
having avg (pruebaa + pruebab) > 25; 


/*8.-Nombre completo de los alumnos y puntuación media (entre las dos pruebas) de
aquellos que hayan sacado más de 20 puntos de media en el curso 'La
Constitución'. 2 filas*/
SELECT A.NOMBRE,A.APELLIDO1,A.APELLIDO2,AVG(pruebaa+pruebab)
FROM Alumnos A JOIN MATRICULAS M ON A.DNI=M.dniAlumno
JOIN CURSOS C ON M.CODCURSO= C.CODIGOCURSO
WHERE lower (C.NOMBRECURSO) LIKE 'la constitucion'
GROUP BY A.NOMBRE, A.APELLIDO1, A.APELLIDO2
HAVING AVG(pruebaa+pruebab)>20;

/*9.- Nombre del curso con más horas. 1 fila*/
SELECT NOMBRECURSO
FROM CURSOS
WHERE NUMHORAS =(SELECT MAX (NUMHORAS)
	            FROM CURSOS);

/*10.- Obtener el nombre completo de los alumnos junto con el curso y la nota
obtenida en la prueba 1 de aquellos que han obtenido la nota más alta en dicha
prueba en cada curso. 5 filas*/
SELECT a.nombre, a.apellido1, a.apellido2, c.nombrecurso, m.pruebaa
	FROM alumnos a 
	JOIN matriculas m ON a.dni = m.dnialumno
	JOIN cursos c ON m.codcurso = c.codigocurso
	WHERE m.pruebaa = (SELECT MAX(pruebaa) FROM matriculas WHERE codcurso = m.codcurso
	);	

/*11.- Nombre, apellidos y número de cursos de los profesores que imparten mayor
número de cursos. 2 filas*/

SELECT p.nombre, p.apellido1, p.apellido2, COUNT(c.codigocurso)
FROM profesores p
JOIN cursos c ON p.dni=c.profesor
GROUP BY p.nombre, p.apellido1, p.apellido2
HAVING COUNT(c.codigocurso)= (SELECT MAX(codigocurso) FROM cursos)

/*12.- Obtener el nombre y apellidos de los profesores que imparten cursos que
suman más horas que todos los cursos de 'Luis Pérez Sánchez'. 0 filas*/
SELECT p.nombre,p.apellido1,p.apellido2
FROM profesores p
JOIN cursos c ON p.dni = c.profesor
GROUP BY p.nombre, p.apellido1, p.apellido2
HAVING SUM(c.numhoras) > (SELECT SUM(c2.numhoras)
                         FROM cursos c2
                        JOIN profesores p2 ON c2.profesor = p2.dni
                        WHERE p2.nombre = 'Luis'
                        AND p2.apellido1 = 'Pérez'
                        AND p2.apellido2 = 'Sánchez');


/*13.- Obtener el nombre y los apellidos de los profesores que dan menos horas.*/
SELECT p.nombre,p.apellido1,p.apellido2
FROM Profesores p
JOIN cursos c On p.dni=c.profesor
WHERE numhoras=(SELECT MIN(numhoras)
                FROM cursos);
