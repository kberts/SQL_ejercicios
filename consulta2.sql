/*1.- Obtened los datos completos de los empleados. 107 filas*/
SELECT * FROM Employees;

/*2.- Y ahora los de los departamentos. 27 filas*/
SELECT * FROM Departments;

/*3.- Obtén el nombre y salario de los empleados. 107 filas*/
SELECT first_name, salary
FROM Employees;

/*4.- Hallar el nombre de los departamentos. 27 filas*/
SELECT Department_name
FROM Departments;

/*5.- Idem pero ordenados por el nombre. 27 filas*/
SELECT Department_name
FROM Departments
ORDER BY Department_name ASC;

/*6.- Obtener el nombre y empleo de los empleados, ordenado por salario.107 filas*/
SELECT first_name, Job_ID
FROM Employees
ORDER BY salary ASC;

/*7.- Idem pero ordenando ahora por empleo y salario. 107 filas*/
SELECT first_name, Job_ID
FROM Employees
ORDER BY  Employee_id, salary ASC;

/*8.- Idem pero ordenando inversamente por empleo y normalmente por salario. 107 filas*/
SELECT first_name, Job_ID
FROM Employees
ORDER BY  Employee_id DESC, salary ASC;

/*9.- Obtén los salarios y las comisiones de los empleados del departamento 30. 6 filas*/
SELECT salary, commission_pct
FROM Employees
WHERE Department_id = 30;

/*10.- Idem pero ordenando por comisión. 6 filas*/
SELECT salary, commission_pct
FROM Employees
WHERE Department_id = 30
ORDER BY commission_pct ASC;

/*11- Obtén las comisiones. Luego las distintas comisiones. 107 filas. 8 filas.*/
SELECT commission_pct
FROM Employees;

SELECT DISTINCT commission_pct
FROM Employees;

/*12.- Hallar las distintas comisiones y los nombres de los empleados. 99 filas*/
SELECT DISTINCT commission_pct, first_name
FROM Employees;

/*13.- Hallar los distintos salarios y empleados. 107 filas*/
SELECT DISTINCT salary, Employee_id
FROM Employees;

/*14.- Obtener las comisiones y los números de departamento posibles de la empresa, de
manera que no se repitan. 18 filas*/
SELECT DISTINCT commission_pct, Department_id
FROM Employees;

/*15.- Obtenga los nuevos salarios que resultarían de sumar a los empleados del departamento 30 una
gratificación de 1000 unidades monetarias. 6 filas*/
SELECT first_name AS nombre, salary+1000 AS salario_mas_gratificacion
FROM Employees
WHERE Department_id= 30;

/*16.- Idem pero obteniendo también el salario anterior. 6 filas*/
SELECT first_name AS nombre, salary AS salario, salary+1000 AS mas_gratificacion
FROM Employees
WHERE Department_id= 30;

/*17.- Hallar el salario y la comisión de los empleados cuyo número de empleado supera a 130. 176 filas*/
SELECT first_name, salary, commission_pct
FROM Employees
WHERE Employee_id > 130;

/*18.- Si dividimos los empleados en dos grupos, A y B, empezando los del grupo B en la letra J, obtén los
nombres y empleos de los del grupo B, por orden alfabético. 70 filas*/
SELECT first_name, Employee_id
FROM Employees
WHERE first_name LIKE 'J%'
ORDER BY first_name ASC;

/*19.- Obtener el salario, la comisión y el salario total de los empleados con comisión, ordenado por
número de empleado. 35 filas*/
SELECT salary, commission_pct, salary+commission_pct
FROM Employees
WHERE commission_pct IS NOT NULL
ORDER BY Employee_id ASC;

/*20.- Idem pero para los que no tienen comisión. 72 filas*/
SELECT salary, commission_pct, salary+commission_pct
FROM Employees
WHERE commission_pct IS NULL
ORDER BY Employee_id ASC;

/*21.- Hallar el nombre de los empleados que, teniendo un salario superior a 1000, tienen como manager al
empleado de código 7698.*/
SELECT first_name
FROM Employees
WHERE salary >1000 AND manager_id =7698;

/*22.- Hallar los empleados del departamento 10 cuyo nombre no contiene la cadena "LA". 1 empleado*/
SELECT first_name
FROM Employees
WHERE Department_id =10 AND first_name NOT LIKE '%LA%';

/*23.- Obtén los empleados que no son supervisados por ningún otro. 1 filas*/
SELECT first_name 
FROM Employees
WHERE manager_id IS NULL;

/*24.- Deseamos conocer el nombre y departamento de los empleados que no trabajan en el
departamento 10 y cuyo salario es superior a 8000, ordenados por la fecha de incorporación. 33 filas*/
SELECT first_name, Department_id
FROM Employees
WHERE Department_id <> 10 AND salary > 8000
ORDER BY hire_date ASC;

/*25.- Obtén información de los empleados cuyo nombre contiene exactamente cinco caracteres. 36 filas*/
SELECT *
FROM Employees
WHERE first_name LIKE '_____';

/*26.- Idem pero cuyos nombres contengan al menos cinco caracteres. 92 filas*/
SELECT *
FROM Employees
WHERE first_name LIKE '%_____%';

/*27.- Halla los datos de los empleados para los que, su nombre comienza por A y su salario es mayor que
10000, o, reciben comisión y trabajan en el departamento 30. 1 fila*/
SELECT *
FROM Employees
WHERE first_name LIKE 'A%' AND salary>10000 OR commission_pct IS NOT NULL AND Department_id =30 

/*28.- Intenta lograr los nombres y empleos de los empleados tales que su empleo acaba en "PROG" y su
nombre empieza por A. 1 fila*/
SELECT first_name, Job_ID
FROM Employees
WHERE first_name LIKE 'A%' AND Job_ID LIKE '%PROG'

/*29.- Halla los nombres de los empleados que tienen como máximo cinco caracteres en su nombre. 51 filas*/
SELECT *
FROM Employees
WHERE  LENGTH(first_name) <=5;

/*30- Halla el nombre y la fecha de contratación de los empleados que no son it_prog. 102 filas*/
SELECT first_name, hire_date
FROM Employees
WHERE LOWER(job_id) <>'it_prog';

/*31.- Ordena los empleados por su departamento y luego de manera descendente por su número. 107 filas*/
SELECT first_name
FROM Employees
ORDER BY Department_id ASC, Employee_id DESC;

/*32. Muestra el apellido y el salario incrementado en un 20% de todos los empleados. La primera columna
del resultado debe mostrarse como “Empleado”, y la segunda como “Nuevo Salario”. 107 filas*/
SELECT last_name "Empleado", salary+(salary*0.20) "Nuevo Salario"
FROM Employees;

/*33. Muestra el nombre de los empleados que no sean del departamento 60 con un salario menor de 6500 o
mayor de 8500. 80 filas*/
SELECT first_name||' '||last_name "nombre completo"
FROM Employees
WHERE Department_id <> 60 AND salary<6500 OR salary>8500;

/*34. Muestra el nombre de todos los empleados del departamento 60 y los del departamento 90 que tengan
un salario menor de 6500 o mayor que 9500. 8 filas*/
SELECT first_name, salary, Department_id
FROM Employees
WHERE Department_id IN (60,90) AND (salary<6500 OR salary>9500);

/*35. Muestra el nombre de los empleados contratatos antes de 1992. 0 filas*/
SELECT first_name
FROM Employees
WHERE hire_date < TO_DATE('01-01-1992','DD-MM-YYYY');

/*36. Muestra el nombre de los empleados cuyo nombre empiece por ‘D’ y termine en ‘d’. 4 filas*/
SELECT first_name
FROM Employees
WHERE first_name LIKE 'D%d';

/*37. Obtener una lista de los empleados cuyo nombre comience por ‘D’ o por ‘E’. 12 filas*/
SELECT first_name
FROM Employees
WHERE first_name LIKE 'D%'OR first_name LIKE 'E%';

/*38. Seleccionar todos los empleados de los departamentos 10 y 20 cuyo primer apellido empiece por S. 0
filas*/
SELECT *
FROM Employees
WHERE Department_id IN(10,20) AND last_name LIKE 'S%';


