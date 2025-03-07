-- 테이블 생성과 제약조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음. (필수값)
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK: 정의된 형식만 저장되도록 허용.

CREATE TABLE dept (
    dept_no NUMBER(2) CONSTRAINT dept_deptno_pk PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept_loca_locid_fk REFERENCES locations(location_id), 
    dept_bonus NUMBER(10) CONSTRAINT dept_bonus_ck CHECK(dept_bonus >= 100000),
    man_gender VARCHAR2(1) CONSTRAINT dept_gender_ck CHECK(man_gender IN ('M', 'F'))
);

DESC dept;
DROP TABLE dept;

-- 테이블 레벨 제약조건 (모든 열 선언 후 제약조건을 한번에 취하는 방식)
CREATE TABLE dept (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    man_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no), 
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 100000),
    CONSTRAINT man_gender_ck CHECK(man_gender IN('M', 'F'))
);

-- 외래키(foreign key)는 부모테이블(참조테이블)에 없는 값을 insert를 할 수 없음.
INSERT INTO dept VALUES(10, '하이', 1700, 1000000, 'M');

UPDATE DEPT
-- fk 제약조건을 위반하는 경우
-- 부모테이블에 없는 값을 참조하려고 할 때 발생
SET LOCA = 4000
WHERE DEPT_NO = 10;

UPDATE DEPT
SET DEPT_NO = 20 -- pk 제약조건을 위반하는 경우
WHERE DEPT_NO = 10;

UPDATE DEPT
SET DEPT_BONUS = 4000 -- check 제약조건을 위반하는 경우
WHERE DEPT_NO = 20;

SELECT * FROM dept;

-- 다른 테이블에서 나의 PK를 참조하고 있는 경우 삭제가 맘대로 안됩니다.
DELETE FROM LOCATIONS
WHERE LOCATION_ID = 1800;



-- 테이블 생성 이후 제약조건 추가 및 변경, 삭제
-- 제약조건은 추가, 삭제만 가능합니다. 변경은 안됩니다.
-- 변경하려면 삭제하고 새로운 내용으로 추가하면 됩니다.

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- PK 추가
ALTER TABLE dept2
ADD CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no);

-- UNIQUE 추가
ALTER TABLE dept2
ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

-- FK 추가
ALTER TABLE dept2
ADD CONSTRAINT dept2_loca_locid_fk 
FOREIGN KEY(loca) REFERENCES locations(location_id);

-- CHECK 추가
ALTER TABLE dept2
ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000);

ALTER TABLE dept2
ADD CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'));

-- NOT NULL은 열 수정 형태로 변경합니다.
ALTER TABLE dept2
MODIFY dept_bonus NUMBER(10) NOT NULL;

-- 제약조건 확인
SELECT * FROM user_constraints
WHERE table_name = 'DEPT';

-- 제약 조건 삭제 (제약조건 이름으로 -> 이름을 직접 짓지 않았다면 오라클 부여한)
ALTER TABLE dept DROP CONSTRAINT dept2_bonus_ck;

