-- 집합 연산자
-- 서로 다른 쿼리 결과의 행들을 하나로 결합, 비교, 차이를 구할 수 있게 해 주는 연산자
-- UNION(합집합 중복x), UNION ALL(합집합 중복 o), INTERSECT(교집합), MINUS(차집합)
-- 위 아래 column 개수와 데이터 타입이 정확히 일치해야 합니다.

-- UNION -> 중복 데이터를 허용하지 않음. 자동으로 정렬이 일어남(첫번쨰 컬럼 기준 default)

SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE hire_date LIKE '04%'
UNION
SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE department_id = 20;

SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL
SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE department_id = 20;

SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE department_id = 20;
SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE department_id = 20;


SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE hire_date LIKE '04%'
MINUS
SELECT 
	EMPLOYEES.EMPLOYEE_ID, FIRST_name 
FROM employees
WHERE department_id = 20;