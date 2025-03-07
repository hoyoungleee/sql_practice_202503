/*
- NUMBER(2) -> 정수를 2자리까지 저장할 수 있는 숫자형 타입.
- NUMBER(5, 2) -> 정수부, 실수부를 합친 총 자리수 5자리, 소수점 2자리
- NUMBER -> 괄호를 생략할 시 (38, 0)으로 자동 지정됩니다.
- VARCHAR2(byte) -> 괄호 안에 들어올 문자열의 최대 길이를 지정. (4000byte까지)
- CLOB -> 대용량 텍스트 데이터 타입 (최대 4Gbyte)
- BLOB -> 이진형 대용량 객체 (이미지, 파일 저장 시 사용)
- DATE -> BC 4712년 1월 1일 ~ AD 9999년 12월 31일까지 지정 가능
- 시, 분, 초 지원 가능.
*/
CREATE TABLE DEPT
(
    dept_no NUMBER(2),
    dept_name VARCHAR2(14),
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

INSERT INTO DEPT
VALUES(30, '마케팅', '경기', sysdate, 30000000000000.38);

SELECT * FROM DEPT;

-- 컬럼 추가
ALTER TABLE DEPT
ADD dept_count NUMBER(3);

-- 컬럼명 변경
ALTER TABLE DEPT
RENAME COLUMN dept_count TO dept_count2;

-- 컬럼 수정
-- 만약 병경하고자 하는 컬럼에 데이터가 좋제하면 그에맞는 타입으로 변경해야함.
ALTER TABLE DEPT
MODIFY dept_count2 NUMBER(4);

-- 컬럼 삭제
ALTER TABLE DEPT
DROP COLUMN dept_bonus;

-- DDL(CREATE, ALTER, TRUNCATE, DROP)문은 롤백이 불가능함.
-- DML(INSERT, UPDATE, DELETE)문은 롤백이 가능함.
-- dml문 이후 ddl문을 실행하면 commit이 자동으로 들어가서 dml문은 롤백이 불가능함.
-- DCL(GRANT, REVOKE)문은 롤백이 가능함.
ROLLBACK;

-- 테이블 이름 변경
ALTER TABLE DEPT
RENAME TO DEPT2;

-- 테이블 삭제(구조는 남겨두고 내부데이터만 삭제)
TRUNCATE TABLE DEPT2;

SELECT * FROM DEPT2;

-- 테이블 삭제 (테이블 내의 모든 데이터가 삭제됨)
DROP TABLE DEPT2;