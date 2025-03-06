SELECT * FROM EMPLOYEES
WHERE last_name = 'King';

-- LIKE 연산자 (지정 문자열 포함 여부)

SELECT
    first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '03%'; -- 03으로 시작해라

SELECT
    first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%15'; -- 15로 끝나라

SELECT
    first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%'; -- 05가 포함됐나

SELECT
    first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '__05%'; -- 언더바로 앞자리수 지정

SELECT
    first_name, last_name, hire_date
FROM employees
WHERE commission_pct is null; -- null 조건

SELECT
    first_name, last_name, hire_date
FROM employees
WHERE commission_pct is not null; -- null 이 아닌 조건

SELECT
    *
FROM employees
WHERE (job_id = 'IT_PROG'
OR  job_id = 'FI_MGR')
AND salary >= 6000; -- AND연산자가 연산 순위가 빨라 근접한 조건과 AND 조건을 걸어 버림. 원치않은 결과 발생. 독립된 연산을 위해 괄호쳐서 연산 구분


-- 데이터의 정렬 ( ASC : 오름차순, DESC : 내림차순)

SELECT
    first_name, last_name, hire_date
FROM employees
order by hire_date;--아무것도 안쓰면 ASC 기본정렬


SELECT
    first_name, last_name, hire_date
FROM employees
order by hire_date DESC;

SELECT
    first_name,
    salary * 12 AS pay
from employees
order by pay DESC;