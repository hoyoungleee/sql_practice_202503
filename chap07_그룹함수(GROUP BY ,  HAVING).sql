-- 집계함수 AVG, MAX, MIN, SUM, COUNT
-- 여러 행을 묶어서 한 번에 함수를 적용

--그룹화를 하지않으면 그룹은 테이블 전체가 된다.
SELECT 
	AVG(EMPLOYEES.SALARY ),
	MAX(EMPLOYEES.SALARY ),
	MIN(EMPLOYEES.SALARY ),
	SUM(EMPLOYEES.SALARY ),
	COUNT(EMPLOYEES.SALARY )
FROM EMPLOYEES;

SELECT count(*) FROM EMPLOYEES ;
SELECT count(EMPLOYEES.FIRST_NAME ) FROM EMPLOYEES ;
SELECT count(EMPLOYEES.COMMISSION_PCT ) FROM EMPLOYEES ; -- count()는 NULL 세지 않음.
SELECT count(EMPLOYEES.MANAGER_ID ) FROM EMPLOYEES ;


-- 그룹함수는 단독적으로 사용할 떄는 테이블 전체가 그룹의 대상이 되지만
-- 일반 컬럼과 동시에 출력할 수 없습니다. 일반컬럼을 그룹화 해야 합니다.
SELECT 
	EMPLOYEES.DEPARTMENT_ID ,
	AVG(salary),
	COUNT(*)
FROM employees;

-- group by 절을 사용할 떄 group 절에 묶이지 않은 컬럼은 조회할 수 없습니다.
SELECT 
	job_id,
	EMPLOYEES.DEPARTMENT_ID ,
	AVG(salary),
	COUNT(*)
FROM employees
GROUP BY department_id;

-- group by 절 2개 이상 사용
SELECT 
	job_id,
	EMPLOYEES.DEPARTMENT_ID ,
	AVG(salary),
	COUNT(*)
FROM employees
GROUP BY department_id, EMPLOYEES.JOB_ID ;

-- GROUP BY를 통해 그룹화 할 때, 조건을 지정할 경우 HAVING을 사용.
-- WHERE은 일반 조건절. GROUP BY 보다 먼저 연산됨.
SELECT 
	EMPLOYEES.DEPARTMENT_ID ,
	SUM(salary),
	AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;

-- 부서 아이디가 50이상인 것들을 그룹화 시키고, 그룹급여 평균이
-- 5000 이상만 조회
SELECT 
	EMPLOYEES.DEPARTMENT_ID ,
	ROUND(AVG(salary)) AS 평균급여
FROM EMPLOYEES 
WHERE department_id >= 50
GROUP BY EMPLOYEES.DEPARTMENT_ID 
HAVING AVG(salary) >= 5000
ORDER BY 평균급여 desc;

/*
문제 1.
1-1. 사원 테이블에서 JOB_ID별 사원 수를 구하세요.
1-2. 사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
*/


/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.
(TO_CHAR() 함수를 사용해서 연도만 변환합니다. 그리고 그것을 그룹화 합니다.)
*/



/*
문제 3.
급여가 5000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
단 부서 평균 급여가 7000이상인 부서만 출력하세요.
*/




/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절사 하세요.
*/

