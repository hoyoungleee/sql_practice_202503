-- 데이터 출력문
select * from employees;

SELECT 
    employee_id, 
    first_name, 
    last_name 
FROM 
    employees;
-- 컬럼을 조회하는 위치에서 산술 연산이 가능
SELECT 
    employee_id, 
    first_name, 
    last_name ,
    salary,
    salary + salary*0.1
FROM 
    employees;
-- alias(컬럼명, 테이블명의 이름을 변경해서 조회합니다.)
SELECT 
    first_name AS 이름, 
    last_name AS 성 ,
    salary AS 급여,
    salary + salary*0.1 as 성과포함급여
FROM 
    employees;
    
-- NULL 값의 확인 (숫자 0이나 공백과는 다른개념)
select
    department_id,
    commission_pct
from employees;

-- 문자열 붙이기
/*
오라클은 홑따옴표로 문자를 표현하고, 문자열 안에 홑따옴표 특수기호를
표현하고 싶다면 ''를 두 번 연속으로 쓰시면 됩니다.
문자열 연결기호는 || 입니다. 문자열의 덧셈 연산을 허용하지 않습니다.
*/
SELECT
	first_name || ' ' || last_name || '''s salary is $' || EMPLOYEES.SALARY  AS full_name
FROM employees;

SELECT DISTINCT
	department_id
FROM employees;