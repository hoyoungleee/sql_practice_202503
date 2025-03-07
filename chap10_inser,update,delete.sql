-- 테이블 구조 확인하기
DESC departments;

-- INSERT의 첫번쨰 방법 (모든컬럼 데이터를 한번에 지정해서 삽입)

-- 에러 -> 컬럼을 지정하지 않고 값만 주는 경우는 모든 값을 다줘야 한다.
INSERT INTO departments
VALUES (280, '개발부');

select * from departments;

-- INSERT의 두번째 방법 (직접 컬럼을 지정해서 저장, not null 컬럼 확인!)
INSERT INTO departments 
    (DEPARTMENT_ID, DEPARTMENT_NAME)
VALUES (301, '영업부');    

rollback; -- 실행시점을 다시 뒤로 되돌리는 키워드.

--사본 테이블 생성
-- 사본 테이블을 생성할 떄 그냥 생성하면 -> 조회된 데이터까지 복사
--- WHERE절에 false(1=2)를 주면 -> 테이블의 구조만 복사되고 데이터는 복사 x
-- 제약 조건은 복사되지 않습니다.
CREATE TABLE emps AS 
(
    SELECT employee_id, first_name, job_id, hire_date

    FROM employees -- 데이터까지 복사
    --FROM employees WHERE 1=2 무조건 거짓인 조건을 줘서 구조만 복사
);

select * from emps;

drop table emps; -- 테이블 삭제


-- INSERT (서브쿼리)
INSERT INTO EMPS
(
    SELECT employee_id, first_name, job_id, hire_date
    FROM employees
    WHERE DEPARTMENT_id = 50
);

--------------------------------

-- UPDATE
-- UPDATE 테이블명 SET 컬럼명 = 값 ... WHERE 누구를 수정할지(조건);
UPDATE EMPS
    set first_name = '춘식'
WHERE employee_id = 100; -- 조건 지정 안하면 대상이 테이블 전체가 됨.

select * from emps;

UPDATE EMPS
    set first_name = '야옹이',
    JOB_ID = '백수',
    hire_date = sysdate
WHERE employee_id = 100;

-- update 서브쿼리

UPDATE emps
    SET (job_id , hire_date) = 
    (
        SELECT job_id, hire_date
        FROM employees
        WHERE employee_id = 100
    )
WHERE employee_id = 101;
select * from emps;


-- DELETE
-- DELETE도 WHERE 지정하지 않으면 테이블 전체 행이 대상이 됩니다.
-- DELETE FROM 테이블명 WHERE 조건;

-- DELETE (서브쿼리)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT');
rollback;


