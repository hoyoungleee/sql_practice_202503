-- 오토커밋 활성화 여부
show AUTOCOMMIT;

-- 오토커밋 켜기
set AUTOCOMMIT on;

-- 오토커밋 끄기
set AUTOCOMMIT OFF;

SELECT * FROM EMPS;

INSERT INTO EMPS
VALUES (300, '춘식이', 'IT_PROG', sysdate);

DELETE FROM emps WHERE EMPLOYEE_ID = 300;

INSERT INTO EMPS
VALUES(301, '메롱이', '영업부', sysdate);

-- 보류중인 모든 데이터 변경사항을 취소 (폐기)
-- 직전 커밋 단계로 회귀(돌아가기) 및 트랜잭션 종료.
ROLLBACK;

SELECT * FROM  EMPS;

-- 세이브 포인트 생성
-- 롤백 포인트를 직접 이름을 붙여서 지정.
-- ANSI 표준 문법은 아니기 때문에 권장 되진 않음.
SAVEPOINT insert_choon;

ROLLBACK TO SAVEPOINT insert_choon;

-- 보류중인 모든 데이터 변경사항을 커밋(반영)
-- 커밋 후에는 어떠한 방법을 사용하더라도 되돌릴 수 없음.
COMMIT;

