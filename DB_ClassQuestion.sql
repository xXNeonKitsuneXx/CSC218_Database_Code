--How many project that person work on. Show FN, LN, Amount project
SELECT E.EMPNO, E.FIRSTNME, E.LASTNAME, COUNT(*) AS AMOUNT_PROJECT
FROM EMPLOYEE E, EMPPROJACT EP
WHERE E.EMPNO = EP.EMPNO
GROUP BY E.EMPNO, E.FIRSTNME, E.LASTNAME;

--Employee who is not Department manger
SELECT EMPNO, FIRSTNME, LASTNAME
FROM EMPLOYEE
EXCEPT
SELECT MGRNO, FIRSTNME, LASTNAME
FROM EMPLOYEE, DEPARTMENT
WHERE EMPNO = MGRNO

