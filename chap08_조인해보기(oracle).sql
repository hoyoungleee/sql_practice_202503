/*
# 조인이란?

- 서로 다른 테이블 간에 설정된 관계가 결합하여
 1개 이상의 테이블에서 데이터를 조회하기 위해서 사용합니다.
 
- SELECT 컬럼리스트 FROM 조인대상이 되는 테이블 (1개 이상)
  WHERE 조인 조건 (오라클 조인 문법)
*/

-- employees 테이블의 부서 id와 일치하는 departments테이블의 부서 id를 찾아
-- 부서 이름을 조회하자.
SELECT 
	first_name,
	e.department_id,
	d.DEPARTMENT_NAME, 
	j.JOB_TITLE ,
	loc.CITY
FROM employees e, DEPARTMENTS d , JOBS j, LOCATIONS loc
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
AND e.JOB_ID = j.JOB_ID
AND d.LOCATION_ID = loc.LOCATION_ID
AND loc.CITY = 'Southlake'; -- 일반 조건은 조인 조건절 다음에 기입

-- 외부 조인
/*
상호 테이블간에 일치되는 값으로 연결되는 내부 조인과는 다르게
어느 한 테이블에 공통 값이 없더라도 해당 row들이 조회 결과에
모두 포함되는 조인을 말합니다.
*/