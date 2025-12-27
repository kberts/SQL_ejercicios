/*1. Muestra el salario más alto, el más bajo, la suma y la media de los salarios de
los empleados. Etiqueta todas las columnas (Máximo, Mínimo, Suma, Media)
1 fila*/
SELECT MAX(salary) AS "Máximo", MIN(salary) AS "Mínimo", SUM(salary) AS "Suma", AVG(salary) AS "Media"
FROM EMPLOYEES;

/*2. Haz lo mismo que el ejercicio anterior pero mostrándolo para cada tipo de
trabajo. 19 filas*/
SELECT JOB_ID AS "trabajo",COUNT(salary) AS "Número",MAX(salary) AS "Máximo", MIN(salary) AS "Mínimo", SUM(salary) AS "Suma", AVG(salary) AS "Media"
FROM EMPLOYEES
GROUP BY JOB_ID;

/*3. Escribe una consulta que muestre cada uno de los trabajos y el número de
personas que desempeñan ese trabajo. 19 filas*/
SELECT JOB_ID AS "trabajo",COUNT(JOB_ID) AS "Número"
FROM EMPLOYEES
GROUP BY JOB_ID;

/*4. Determina el número de empleados que son managers, sin mostrar su
nombre 1 fila*/
SELECT COUNT (DISTINCT MANAGER_ID) AS "Cuenta"
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

/*5. Muestra el número de manager y el salario del empleado peor pagado para
ese manager. Excluye aquellos que no tienen manager y los grupos donde el
salario mínimo es menor que 1000. Ordena el resultado en orden
descendente de salario 18 filas*/
SELECT MANAGER_ID, MIN(salary)
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING AVG(salary) >1000
ORDER BY AVG(salary) DESC;

/*6. Escribe una consulta para mostrar el nombre del departamento, la ciudad de
localización del departamento, el número de empleados y el salario medio
para todos los empleados de ese departamento. Etiqueta las columnas como
Nombre, Ciudad, Numero de personas, Salario. 11 filas*/
SELECT d.department_name AS nombre, l.city as Ciudad, COUNT(e.employee_id) AS Num_Personas, TRUNC(AVG(e.salary),2) AS Salario_Medio
FROM departments d
    INNER JOIN employees e ON d.department_id = e.department_id
    INNER JOIN locations l ON d.location_id = l.location_id
GROUP BY d.department_name, l.city;