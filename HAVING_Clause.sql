-- SELECT   expression
-- FROM     table-list/ relation
-- WHERE    condition   to filter the records
-- GROUP BY     column-list     to aggregate the records together
-- HAVING   condition of grouping by using aggregate to test the condition
-- ORDER BY     order the result

--1) Show the department that have at least 5 people.
SELECT WORKDEPT, count(*) AS People
FROM EMPLOYEE
GROUP BY WORKDEPT
HAVING count(*) >= 5;

--1.2) Show name of department.
SELECT DEPTNAME, WORKDEPT, count(*) AS NUMBER_OF_EMPLOYEES
FROM EMPLOYEE E, DEPARTMENT D
WHERE  E.WORKDEPT = D.DEPTNO
GROUP BY WORKDEPT, DEPTNAME
HAVING count(*) >= 5;

--2) Which department pay total salary of all employee more than half million dollars?
SELECT WORKDEPT, SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY WORKDEPT
HAVING SUM(SALARY) > 500000;

--2.2) Show name of department.
SELECT DEPTNAME, WORKDEPT, SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE E, DEPARTMENT D
WHERE  E.WORKDEPT = D.DEPTNO
GROUP BY WORKDEPT, DEPTNAME
HAVING SUM(SALARY) > 500000;

--3) Show name of employee who works more than 2 projects.
SELECT FIRSTNME, LASTNAME, COUNT(DISTINCT PROJNO) AS NUMBER_OF_PROJECT
FROM EMPLOYEE E, EMPPROJACT EP
WHERE E.EMPNO = EP.EMPNO
GROUP BY EP.EMPNO, FIRSTNME, LASTNAME
HAVING COUNT(DISTINCT PROJNO) > 2;

--3.2) Show name of employee who works more than 2 projects.
SELECT FIRSTNME, LASTNAME, COUNT(*) AS NUMBER_OF_ACTNO
FROM EMPLOYEE E, EMPPROJACT EP
WHERE E.EMPNO = EP.EMPNO
GROUP BY EP.EMPNO, FIRSTNME, LASTNAME
HAVING COUNT(*) > 2;

--4) How many people works on each project?
SELECT PROJNO, COUNT(*) AS NUMBER_OF_ACTNO
FROM EMPPROJACT EP
GROUP BY PROJNO;
-- This one just counting the number of actions, not people.
------------------------------------------------------------
SELECT PROJNO, COUNT(DISTINCT EMPNO) AS NUMBER_OF_PEOPLE
FROM EMPPROJACT EP
GROUP BY PROJNO;

--4.2) Show the project name that has at least 3 people working at.
SELECT P.PROJNO, PROJNAME, COUNT(DISTINCT EMPNO) AS NUMBER_OF_PEOPLE
FROM EMPPROJACT EP, PROJECT P
WHERE EP.PROJNO = P.PROJNO
GROUP BY P.PROJNO, P.PROJNAME
HAVING COUNT(DISTINCT EMPNO) >= 3;


--5) Show average salary of people who work on each project.
SELECT EP.PROJNO, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEE E, EMPPROJACT EP
WHERE E.EMPNO = EP.EMPNO
GROUP BY PROJNO;

--6) Show department number that pay at least $40000 to each employee.
SELECT WORKDEPT
FROM EMPLOYEE
GROUP BY WORKDEPT
HAVING MIN(SALARY) >= 40000;

--6.2) Show department number that pay women at least $40000 to each employee.
SELECT WORKDEPT
FROM EMPLOYEE
WHERE SEX = 'F'
GROUP BY WORKDEPT
HAVING MIN(SALARY) >= 40000;

--6.3) Show department name that pay women at least $40000 to each employee.
SELECT D.DEPTNAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE SEX = 'F' AND E.WORKDEPT = D.DEPTNO
GROUP BY D.DEPTNAME
HAVING MIN(SALARY) >= 40000;

-------- But this database have bad data --------
SELECT DEPTNO FROM DEPARTMENT WHERE DEPTNO LIKE 'A%';
SELECT WORKDEPT, FIRSTNME FROM EMPLOYEE WHERE WORKDEPT LIKE 'A01';

--7) Show department that pay at least 40000 and have at least 2 employees
SELECT E.WORKDEPT, D.DEPTNAME, MIN(E.SALARY) AS LOWEST_SALARY, COUNT(E.EMPNO) AS NUMBER_OF_EMPLOYEES,
                                MAX(E.SALARY) AS HIGHEST_SALARY, AVG(E.SALARY) AS AVG_SALARY
FROM EMPLOYEE E, DEPARTMENT D
WHERE D.DEPTNO = E.WORKDEPT
GROUP BY E.WORKDEPT, D.DEPTNAME
HAVING MIN(E.SALARY) >= 40000 OR COUNT(E.EMPNO) >= 2;