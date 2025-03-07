-- 계층형 쿼리 
-- START WITH : 계층의 첫 단계를 어디서 시작할 것인지의 대한 조건
-- CONNECT BY PRIOR 자식 = 부모  -> 순방향 탐색
-- CONNECT BY 자식 = PRIOR 부모  -> 역방향 탐색
-- ORDER SIBLINGS BY : 같은 레벨끼리의 정렬을 정함.
-- 게시물 댓글, 대댓글 처리시 사용가능


SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    MANAGER_ID
from employees;

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    MANAGER_ID,
    level, -- 계층 레벨을 나타내는 키워드
    SYS_CONNECT_BY_PATH(FIRST_NAME, '/') as path -- 계층 구조를 '/'로 구분하여 나타내는 함수
from employees
START WITH manager_id IS NULL -- 계층 구조를 최상위 관리자부터 시작한다.
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID -- 순방향 탐색. 한 직원의 manager_id가 다음 직원의 employee_id와 같다면 부모-자식 관계를 형성하겠다.
and LEVEL <= 2 -- 최대 2단계까지만 조회
ORDER SIBLINGS BY FIRST_NAME; -- 같은 레벨끼리 정렬

SELECT
    LEVEL,
    LPAD(' ', 2*(LEVEL-1)) || FIRST_NAME AS 조직인원,
    EMPLOYEE_ID,
    MANAGER_ID
from employees
START with employee_id = 107
CONNECT by employee_id = prior manager_id;

-- 102번 직원의 모든 부하직원 찾기
SELECT
    level,
    EMPLOYEE_ID,
    LPAD(' ', 2*(LEVEL-1)) || FIRST_NAME AS 조직인원,
    SALARY
from employees
START with employee_id = 102
CONNECT by prior employee_id = manager_id ;