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
	m.MANAGER_ID ,m.FIRST_NAME , COUNT(e.EMPLOYEE_ID) 
FROM employees e
JOIN EMPLOYEES m
ON e.manager_id = m.employee_id
GROUP BY m.MANAGER_ID, m.FIRST_NAME;



/*SELECT 
	m.MANAGER_ID AS manager_id, 
	m.FIRST_NAME AS FIRST_NAME, 
	count(m.EMPLOYEE_ID) AS 사원수
FROM employees e
JOIN EMPLOYEES m
ON e.MANAGER_ID = m.EMPLOYEE_ID
GROUP BY m.EMPLOYEE_ID , m.FIRST_NAME ;*/

-- Natural Join
-- 동일한 이름을 갖는 컬럼들에 대해 자동으로 조인조건을 생성하는 기법입니다.
-- 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER JOIN을 수행합니다.
-- 조인되는 동일 이름의 컬럼은 타입이 같아야 하며,
-- ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안됩니다.
-- 조회하려는 컬럼에 *을 붙이면, 공통 컬럼은 한 번만 표기됩니다.

SELECT 
	e.employee_id, e.first_name,
	department_id, d.department_name
FROM employees e
NATURAL JOIN departments d;

-- USING JOIN
-- NATURAL JOIN과는 다르게, USING을 사용하면 원하는 컬럼에 대해서만 선택적 조인조건을
-- 부여할 수 있습니다.
-- USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 표기하시면 안됩니다.

SELECT 
	e.employee_id, e.first_name,
	department_id, d.department_name
FROM employees e
JOIN DEPARTMENTS  d USING(department_id);