/*
# 서브쿼리 
: SQL 문장 안에 또다른 SQL을 포함하는 방식.
 여러 개의 질의를 동시에 처리할 수 있습니다.
 WHERE, SELECT, FROM 절에 작성이 가능합니다.

- 서브쿼리의 사용방법은 () 안에 명시함.
 서브쿼리절의 리턴행이 1줄 이하여야 합니다. where절에 = 얀신경우
- 서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 합니다. 
- 해석할 때는 서브쿼리절 부터 먼저 해석하면 됩니다.
*/

-- 이름이 Nancy인 사원보다 급여가 높은 사월을 조회하기

SELECT salary FROM EMPLOYEES 
WHERE first_name = 'Nancy'

SELECT first_name FROM EMPLOYEES 
WHERE salary > (SELECT salary FROM EMPLOYEES 
WHERE first_name = 'Nancy');

-- employee_id가 103번인 사람의 job_id랑 동일한 job_id를 가진사람을 조회
SELECT * FROM EMPLOYEES 
WHERE job_id = (SELECT EMPLOYEES.JOB_ID   FROM EMPLOYEES 
WHERE EMPLOYEES.EMPLOYEE_ID  = 103);



SELECT * FROM EMPLOYEES 
-- 다음 문장은 서브쿼리가 리턴하는 행이 여러 개라서 단일 행 연산자를 사용할 수 없습니다.
-- 단일 행 연산자: 주로 비교 연산자 (=, >, <, >=, <=, <>)를 사용하는 경우 하나의 행만 반환해야 합니다.
-- 이런 경우에는 다중 행 연산자를 사용해야 합니다.
WHERE job_id = (SELECT EMPLOYEES.JOB_ID   FROM EMPLOYEES 
WHERE EMPLOYEES.LAST_NAME   = 'King');

-- 다중행 연산자 (IN, ANY, ALL, EXIST)
-- IN : 조회된 목록의 어떤 값과 같은지를 비교.
-- ex) salary IN(200 ,300 ,400)
SELECT * FROM EMPLOYEES 
WHERE job_id IN (SELECT EMPLOYEES.JOB_ID   FROM EMPLOYEES 
WHERE EMPLOYEES.LAST_NAME   = 'King');

-- ANY, SOME : 값을 서브쿼리에 의해 리턴된 각각의 값과 비교해서
-- 하나라도 만족하면 조회 대상에 포함됩니다.
SELECT * FROM EMPLOYEES 
WHERE salary > ANY (SELECT salary FROM EMPLOYEES 
WHERE first_name = 'David');

-- ALL : 값을 서브쿼리에 의해 리턴된 각각의 값과 비교해서
-- 전부 다 잋리 해야 조회대상에 포함됩니다.
SELECT * FROM EMPLOYEES 
WHERE salary > ALL (SELECT salary FROM EMPLOYEES 
WHERE first_name = 'David');


-- EXISTS : 서브쿼리가 하나 이상의 행을 반환하면 참으로 간주.
-- job_history에 존재하는 직원이 employees에도 존재한다면 조회 대상에 포함.
-- 서브쿼리 내에서 jh에 있는 id와 e에 있는 id가 일치할 때마다 1이라는 값을 조회.
-- EXISTS 연산자가 1이 조회가 될때 데이터가 존재한다는 것을 판단하여
-- employees에서 해당 사원의 모든 컬럼을 조회.
SELECT * FROM EMPLOYEES e
WHERE EXISTS (SELECT 1 FROM job_history jh
			  WHERE  e.employee_id = jh.EMPLOYEE_ID);

/*
# 스칼라 서브쿼리 vs LEFT JOIN
a. 간단한 상황에서 사용하면 쿼리가 직관적이고 간결합니다.
b. 단일 값을 반환하는 서브쿼리에서 유용.
c. 대량 데이터가 아닌 경우나, 서브쿼리의 복잡도가 낮은 경우 적합.

1. 대량 데이터를 처리하거나, 여러 컬럼을 붙여야 할 때 유리합니다.
2. 여러 테이블을 한 번에 조인해야 할 경우.
3. 다중값 처리 및 중복 데이터가 있는 경우 성능상 좀 더 유리.
*/

-- 각 부서별 사원 수 뽑기( 부서명, 사원수)
SELECT
	d.DEPARTMENT_NAME ,
	count(e.employee_id) AS 사원수
FROM DEPARTMENTS  d
LEFT JOIN EMPLOYEES e
ON d.department_id = e.DEPARTMENT_ID 
GROUP BY d.DEPARTMENT_NAME
ORDER BY 사원수 DESC;

SELECT
	d.DEPARTMENT_NAME ,
	NVL((SELECT COUNT(employee_id) FROM EMPLOYEES e WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID GROUP BY e.DEPARTMENT_ID ), 0) AS 사원수
FROM DEPARTMENTS  d
ORDER BY 사원수 DESC;

-- FROM절 서브쿼리 (인라인 뷰)
-- 특정 테이블 전체가 아닌 SELECT를 통해 일부 데이터를 조회한 것을 가상 테이블로 사용하고 싶을 때.
-- 순번을 정해놓은 조회 자료를 범위를 지정해서 가지고 오는 경우.
SELECT
	rownum rn,
	tbl.*
FROM
(SELECT
	employee_id, first_name, salary
FROM EMPLOYEES
ORDER BY salary DESC) tbl;

SELECT
    *
FROM
    (SELECT
        ROWNUM AS rn, tbl.*
    FROM
        (SELECT 
            employee_id,first_name, salary
        FROM employees
        ORDER BY salary DESC) 
    tbl)
WHERE rn > 10 AND rn <= 20;

/*
가장 안쪽 SELECT 절에서 필요한 테이블 형식(인라인 뷰)을 생성.
바깥쪽 SELECT 절에서 ROWNUM을 붙여서 다시 조회
가장 바깥쪽 SELECT 절에서는 이미 붙어있는 ROWNUM의 범위를 지정해서 조회.

** SQL의 실행 순서
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/

SELECT
     FIRST_NAME, SALARY
FROM employees;

SELECT
	e.FIRST_NAME, e.SALARY, tbl.AVG_SALARY
FROM employees e
JOIN (SELECT
	DEPARTMENT_ID,
	TRUNC(AVG(SALARY), 0) as AVG_SALARY
FROM employees 
GROUP BY department_id) tbl
on e.department_id = tbl.department_id;

-- 부서별 최고 급여를 받는 직원을 조회해 주세요,.
-- 사원 이름 , 급여, 부서이름

/* SELECT
	e.FIRST_NAME, e.SALARY, tbl.DEPARTMENT_NAME
from employees e
join (
SELECT
	e.DEPARTMENT_ID,
	d.DEPARTMENT_NAME,
	MAX(SALARY) AS MAX_SALARY
FROM employees e
join departments d
on e.department_id = d.department_id
GROUP BY e.department_id, DEPARTMENT_NAME
) tbl
on e.department_id = tbl.department_id
where salary = tbl.max_salary
ORDER BY salary DESC; */


SELECT
	e.FIRST_NAME, e.SALARY, d.DEPARTMENT_NAME
from employees e
join
(
SELECT
	DEPARTMENT_ID,
	Max(SALARY) AS MAX_SALARY
from employees
GROUP BY department_id
) max_sal
ON e.department_id = max_sal.department_id
AND e.salary = max_sal.max_salary
join departments d
on e.department_id = d.department_id
ORDER BY salary DESC;