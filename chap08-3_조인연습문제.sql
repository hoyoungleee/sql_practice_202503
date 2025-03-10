/*
문제 1.
-EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
-EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서
각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 주석으로 작성)
*/

--106행
SELECT
    *
from employees e
INNER JOIN departments d
on e.department_id = d.department_id;

--107행
SELECT
    *
from employees e
LEFT OUTER JOIN departments d
on e.department_id = d.department_id;

--122행
SELECT
    *
from employees e
RIGHT OUTER JOIN departments d
on e.department_id = d.department_id;

--123행
SELECT
    *
from employees e
FULL OUTER JOIN departments d
on e.department_id = d.department_id;


/*
문제 2.
-EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
조건)employee_id가 200인 사람의 이름, department_name를 출력하세요
조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다
*/
SELECT
    e.FIRST_NAME || ' ' ||e.last_name , d.DEPARTMENT_NAME
from employees e
INNER JOIN departments d
on e.department_id = d.department_id
WHERE e.EMPLOYEE_ID = 200;


/*
문제 3.
-EMPLOYEES, JOBS테이블을 INNER JOIN하세요
조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
HINT) 어떤 컬럼으로 서로 연결되어 있는지 확인
*/
SELECT
    e.JOB_ID, j.JOB_TITLE
from employees e
INNER JOIN JOBS j
on e.job_id = j.JOB_ID
ORDER by e.job_id;

/*
문제 4.
--JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.
*/
SELECT
    *
from JOBS j
LEFT OUTER JOIN JOB_HISTORY jh
on j.JOB_ID = jh.JOB_ID;


/*
문제 5.
--Steven King의 부서명을 출력하세요.
*/

SELECT
    d.DEPARTMENT_NAME
FROM employees e
join departments d
on e.department_id = d.department_id
where first_name = 'Steven' AND last_name = 'King';

/*
문제 6.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요
*/

SELECT
    d.DEPARTMENT_NAME
FROM employees e
CROSS join departments d;

/*
문제 7.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름, 
급여, 부서명, 근무지를 출력하세요. (Alias를 사용)
*/

SELECT
    e.EMPLOYEE_ID AS 사원번호, e.FIRST_NAME as 이름 , e.SALARY AS 급여, d.DEPARTMENT_NAME AS 부서명, loc.STREET_ADDRESS AS 근무지
FROM employees e
join departments d
on e.department_id = d.department_id
join locations loc
on d.location_id = loc.location_id
where e.JOB_ID = 'SA_MAN';

/*
문제 8.
-- employees, jobs 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 
직원 정보만 출력하세요.
*/

SELECT
    e.*
from employees e
INNER JOIN JOBS j
on e.job_id = j.JOB_ID
where j.JOB_TITLE = 'Stock Manager' OR j.JOB_TITLE = 'Stock Clerk';


/*
문제 9.
-- departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용
*/
SELECT
    d.DEPARTMENT_ID,
    d.DEPARTMENT_NAME
FROM departments d
LEFT OUTER JOIN employees e
on d.department_id = e.department_id
group by d.department_id, d.DEPARTMENT_NAME
HAVING count(e.employee_id) = 0;


/*
문제 10. 
-join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.
*/

SELECT
    e1.EMPLOYEE_ID,e1.FIRST_NAME, e1.MANAGER_ID ,e2.first_name
from employees e1
join employees e2
on e1.manager_id = e2.employee_id;



/*
문제 11. 
-- EMPLOYEES 테이블에서 left join하여 관리자(매니저)id와, 매니저의 이름, 매니저의 급여 까지 출력하세요.
-- 매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 정렬하세요.
*/

SELECT
    e1.MANAGER_ID ,e2.first_name,e2.SALARY
from employees e1
left join employees e2
on e1.manager_id = e2.employee_id
where e1.MANAGER_ID is not null
group by e1.MANAGER_ID, e2.FIRST_NAME, e2.SALARY
ORDER by e2.SALARY desc;