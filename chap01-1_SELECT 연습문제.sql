

--1. 모든 사원의 사원번호, 이름, 입사일, 급여를 출력하세요.
SELECT
    employee_id as 사원번호,
    first_name as 이름,
    hire_date as 입사일,
    salary as 급여
from employees;

--2. 모든 사원의 이름과 성을 붙여 출력하세요. 열 별칭은 name으로 하세요.
SELECT
    first_name || ' ' || last_name as 이름
from employees;

--3. 50번 부서 사원의 모든 정보를 출력하세요.
SELECT
    *
from employees
WHERE DEPARTMENT_ID = 50;

--4. 50번 부서 사원의 이름, 부서번호, 직무아이디를 출력하세요.
SELECT
    first_name || ' ' || last_name as 이름, DEPARTMENT_ID , JOB_ID
from employees
WHERE DEPARTMENT_ID = 50;


--5. 모든 사원의 이름, 급여 그리고 300달러 인상된 급여를 출력하세요.
SELECT
    FIRST_NAME, SALARY, SALARY+300
from employees;

--6. 급여가 10000보다 큰 사원의 이름과 급여를 출력하세요.
SELECT
    FIRST_NAME, SALARY
from employees
WHERE SALARY > 10000;

--7. 보너스를 받는 사원의 이름과 직무, 보너스율을 출력하세요.
SELECT
    FIRST_NAME, JOB_ID, COMMISSION_PCT
from employees
WHERE COMMISSION_PCT is not null;

--8. 2003년도 입사한 사원의 이름과 입사일 그리고 급여를 출력하세요.(BETWEEN 연산자 사용)
SELECT
    FIRST_NAME, HIRE_DATE, SALARY
from employees
WHERE HIRE_DATE BETWEEN TO_DATE('2003-01-01', 'YYYY-MM-DD') AND TO_DATE('2003-12-31', 'YYYY-MM-DD');

--9. 2003년도 입사한 사원의 이름과 입사일 그리고 급여를 출력하세요.(LIKE 연산자 사용)
SELECT
    FIRST_NAME, HIRE_DATE, SALARY
from employees
WHERE TO_CHAR(HIRE_DATE) LIKE '%03';

--10. 모든 사원의 이름과 급여를 급여가 많은 사원부터 적은 사원 순서로 출력하세요.
SELECT
    FIRST_NAME, SALARY
from employees
order by SALARY DESC;

--11. 위 질의를 60번 부서의 사원에 대해서만 질의하세요. (컬럼: department_id)
SELECT
    FIRST_NAME, SALARY
from employees
WHERE DEPARTMENT_ID  = 60
order by SALARY DESC;

--12. 직무아이디가 IT_PROG 이거나, SA_MAN인 사원의 이름과 직무아이디를 출력하세요.
SELECT
    FIRST_NAME, JOB_ID
from employees
WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'SA_MAN'
--WHERE JOB_ID IN('IT_PROG', 'SA_MAN') 다항 연산자도 사용가능
order by SALARY DESC;

--13. Steven King 사원의 정보를 “Steven King 사원의 급여는 24000달러 입니다” 형식으로 출력하세요.

SELECT
    FIRST_NAME || ' ' || LAST_NAME || ' ' || '사원의 급여는' || ' ' ||  SALARY || '달러 ' || '입니다.'
from employees
WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King';


--14. 매니저(MAN) 직무에 해당하는 사원의 이름과 직무아이디를 출력하세요. (컬럼:job_id)
SELECT
    FIRST_NAME, JOB_ID
from employees
where job_id LIKE '%MAN';


--15. 매니저(MAN) 직무에 해당하는 사원의 이름과 직무아이디를 직무아이디 순서대로 출력하세요.
SELECT
    FIRST_NAME, JOB_ID
from employees
where job_id LIKE '%MAN'
ORDER BY JOB_ID;
