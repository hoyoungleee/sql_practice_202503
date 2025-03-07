/*
view는 제한적인 자료만 보기 위해 사용하는 가상 테이블의 개념입니다.
뷰는 기본 테이블로 유도된 가상 테이블이기 때문에
필요한 컬럼만 저장해 두면 관리가 용이해 집니다.
뷰는 가상테이블로 실제 데이터가 물리적으로 저장된 형태는 아닙니다.
뷰를 통해서 데이터에 접근하면 원본 데이터는 안전하게 보호될 수 있습니다.
*/
-- 유저 권한 보기
SELECT * FROM user_sys_privs;

-- 단순뷰: 하나의 테이블을 이용해서 생성된 뷰
-- 뷰의 컬럼명은 함수 호출문, 연산식 등 가상 표현식이면 안됩니다!

SELECT
    employee_id,
    first_name || ' ' ||last_name,
    job_id,
    salary
FROM employees
where department_id = 60;


CREATE VIEW view_emp AS (
    SELECT
        employee_id,
        first_name || ' ' ||last_name as full_name, -- 가상 표현식은 별칭을 사용해야 합니다. 
        job_id,
        salary
    FROM employees
    where department_id = 60
);

SELECT * FROM view_emp;

-- 복합뷰 : 두개 이상의 테이블을 조인해서 필요한 데이터만 생성한 뷰
-- 복잡한 쿼리를 반복사용하지 않고 빠른 조회를 위해 사용. (생산성 증가)

CREATE VIEW view_emp_dept_job AS(

    SELECT
        e.EMPLOYEE_ID, 
        e.FIRST_NAME || ' ' || e.LAST_NAME AS FULL_NAME,
        d.DEPARTMENT_NAME,
        j.JOB_TITLE
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
order by employee_id;

SELECT * FROM view_emp_dept_job;

-- 뷰의 수정 (CREATE OR REPLACE VIEW)
-- 동일 이름으로 해당 구문으 사용하면 데이터가 변경되면서 새롭게 생성되고,
-- 기존에 존재 하지 않았다면 새로  CREATE 구문으로 생성됩니다.
CREATE OR REPLACE VIEW view_emp_dept_job AS(

    SELECT
        e.EMPLOYEE_ID, 
        e.FIRST_NAME || ' ' || e.LAST_NAME AS FULL_NAME,
        d.DEPARTMENT_NAME,
        j.JOB_TITLE,
        e.SALARY
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
order by employee_id;

SELECT 
    JOB_TITLE,
    avg(SALARY) as AVG
FROM view_emp_dept_job
GROUP BY JOB_TITLE
ORDER BY AVG DESC;

-- 뷰의 삭제 (DROP VIEW)
-- 뷰를 삭제하면 뷰의 정의가 사라지고, 뷰를 통해 조회한 데이터도 사라집니다.
drop view view_emp;

/*
VIEW에 INSERT가 일어나는 경우 실제 테이블에도 반영이 됩니다.
그래서 VIEW의 INSERT, UPDATE, DELETE에는 많은 제약 사항이 따릅니다.
원본 테이블이 NOT NULL인 경우 VIEW에 INSERT가 불가능합니다.
VIEW에서 사용하는 컬럼이 가상열인 경우에도 안됩니다.
*/


-- 가상의 컬럼(full_name)을 사용하여 insert 하면 에러가 발생합니다.
INSERT INTO VIEW_EMP_DEPT_JOB
VALUES(300, 'test', 'test', 'test', 10000);

-- JOIN된 뷰(복합 뷰)의 경우에는 한번에 삽입할 수 없습니다.
INSERT INTO VIEW_EMP_DEPT_JOB
(EMPLOYEE_ID, DEPARTMENT_NAME , JOB_TITLE, SALARY)
VALUES(300,  'test', 'test', 10000);

INSERT INTO VIEW_EMP
(EMPLOYEE_ID,JOB_ID, SALARY)
VALUES(300, 'test', 10000);

DELETE FROM VIEW_EMP_DEPT_JOB
WHERE EMPLOYEE_ID = 107;

-- with check option -> 조건 제약 컬럼
-- 뷰를 생성할 때 사용한 조건 컬럼은 뷰를 통해서 변경할 수 없게 해주는 키워드
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
-- 읽기 전용 뷰 -> SELECT만 허용, DML 연산을 막음
WITH READ ONLY;

SELECT * FROM view_emp_test;

UPDATE VIEW_EMP_TEST
SET DEPARTMENT_ID = 100
WHERE EMPLOYEE_ID = 107;