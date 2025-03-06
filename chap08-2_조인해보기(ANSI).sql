-- 이너(내부) 조인 : 겹치는 값만 출력

SELECT 
	e.FIRST_NAME,
	e.DEPARTMENT_ID,
	d.DEPARTMENT_NAME
FROM employees e
JOIN DEPARTMENTS d -- 이너조인이 기본값이라 그냥 조인으로 쓰면 자동으로 이너조인
ON e.DEPARTMENT_ID  = d.DEPARTMENT_ID 
WHERE e.DEPARTMENT_ID = 50;


SELECT 
	e.FIRST_NAME,
	e.DEPARTMENT_ID,
	d.DEPARTMENT_NAME
FROM employees e
LEFT OUTER JOIN DEPARTMENTS d -- 이너조인이 기본값이라 그냥 조인으로 쓰면 자동으로 이너조인
ON e.DEPARTMENT_ID  = d.DEPARTMENT_ID 
WHERE e.DEPARTMENT_ID = 50;

--각 매니저가 담당하는 사원의 명수
-- 매니저 아이디, 매니저 이름, 사원수
SELECT
	e.MANAGER_ID , e.FIRST_NAME, count(*)
FROM EMPLOYEES e
GROUP BY MANAGER_ID ;