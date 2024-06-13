-- 변환함수
-- 형변환 함수
-- 데이터베이스는 자동 형변환을 제공해준다 (문자와 숫자, 문자와 날짜)
SELECT * FROM EMPLOYEES WHERE SALARY >= '20000'; -- 문자('20000')에서 숫자(20000)로 자동형변환이 일어남
SELECT * FROM EMPLOYEES WHERE HIRE_DAYE >= '08/01/01'; -- 문자('08/01/01')가 날짜(08/01/01) 형식으로 자동 형변환

-- 강제형변환
-- TO_CHAR -> 날짜를 문자로 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') AS 시간 FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD AM HH12:MI:SS') AS TIME FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY"년" MM"열" DD"일"') AS TIME FROM DUAL; -- 포맷값이 아닌 값을 쓰려면 쌍따옴표(" ")로 묶어준다

-- TO_CHAR -> 숫자를 문자로 
SELECT TO_CHAR(20000, '999999999') AS RESULT FROM DUAL; -- 9자리 숫자로 표현
SELECT TO_CHAR(20000, '099999999') AS RESULT FROM DUAL; -- 9자리 중 빈칸 0으로 채움
SELECT TO_CHAR(20000, '999') AS RESULT FROM DUAL; -- 자리수가 부족하면 #처리됨
SELECT TO_CHAR(20000.123, '99999.999') AS RESULT FROM DUAL; -- 정수 6자리, 실수 4자리
SELECT TO_CHAR(20000, '$999,999,999') AS RESULT FROM DUAL; -- $기호
SELECT TO_CHAR(20000, 'L999,999,999') AS RESULT FROM DUAL; -- 각 국 지역화폐기호

-- 오늘의 환율 1372.17원일 때, SALARY값을 원화로 표현
SELECT FIRST_NAME, TO_CHAR(SALARY * 1372.17, 'L999,999,999') AS 원화 FROM EMPLOYEES;

-- TO_DATE -> 문자를 날짜로
SELECT TO_DATE('2024-06-13', 'YYYY-MM-DD') AS 날짜 FROM DUAL; -- 날짜 모형에 맞춰서 정확히 적음
SELECT SYSDATE - TO_DATE('2024-06-13', 'YYYY-MM-DD') AS 날짜 FROM DUAL; -- 오늘 날짜에서 뺀 것
SELECT TO_DATE('2024년 06월 13일', 'YYYY"년" MM"월" DD"일"') FROM DUAL; -- 날짜 포맷 문자가 아니라면 쌍따옴표
SELECT TO_DATE('24-06-13 11시 30분 23초', 'YYYY-MM-DD HH"시" MI"분" SS"초"') FROM DUAL;

-- 2024년 06월 13일의 문자로 변환한다면?
SELECT TO_CHAR(TO_DATE('240613', 'YYMMDD'), 'YYYY"년" MM"월" DD"일"') FROM DUAL;

-- TO_NUMBER 문자를 숫자로
SELECT '4000' - 1000 FROM DUAL; -- 자동형변환
SELECT TO_NUMBER('4000') - 1000 FROM DUAL; -- 명시적변환 후 연산 ( 4000에서 1000을 뺌)

SELECT '$5,500' - 1000 FROM DUAL; -- 자동형변환 불가
SELECT TO_NUMBER('$5,500', '$999,999') - 1000 FROM DUAL; -- 숫자로 변경이 자동으로 불가능할 경우 명시적변환 후 연산

---------------------------------------------------------
-- NULL처리 함수
SELECT NVL(1000, 0), NVL(NULL, 0) FROM DUAL; -- 첫번째 NULL이 아니라서 1000, 두번째 NULL이라 0
SELECT NULL + 1000 FROM DUAL; -- NULL에 연산이 들어가도 NULL이 나옴

SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY*COMMISSION_PCT AS 최종급여 FROM EMPLOYEES;
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY*NVL(COMMISSION_PCT, 0) AS 최종급여 FROM EMPLOYEES; -- COMMISSION_PCT이

-- NVL2(대상값, 널이 아닌 경우, 널인 경우)
SELECT NVL2(300, 'NULL이 아닙니다', 'NULL입니다') FROM DUAL;
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, NVL2(COMMISSION_PCT, SALARY + SALARY + COMMISSION_PCT, SALARY) AS 최종급여 FROM EMPLOYEES; -- COMMISSION_PCT이 널이 아닌 경우 SALARY + SALARY + COMMISSION_PCT을, 널인 경우 SALARY 

-- COALESCE(값, 값, 값 ....) NULL이 아닌 첫번째 값을 반환시켜줌
SELECT COALESCE(1, 2, 3) FROM DUAL; -- 첫번째 값이 NULL이 아니여서 1이 출력
SELECT COALESCE(NULL, 2, 3, 4) FROM DUAL; -- NULL을 건너뛴 첫번째 값 2출력
SELECT COALESCE(NULL, NULL, 3, NULL) FROM DUAL; -- 3출력
SELECT COALESCE(COMMISSION_PCT, 0) FROM EMPLOYEES; -- NVL과 같음 (COMMISSION_PCT가 NULL이면 0을 찍음)

-- DECODE(대상값, 비교값, 결과값, 비교값, 결과값 .... ELSE문)
SELECT DECODE('A', 'A', 'A입니다') FROM DUAL; -- IF문
SELECT DECODE('X', 'A', 'A입니다', 'A가 아님') FROM DUAL; -- IF~ELSE구문
SELECT DECODE('B', 'A', 'A입니다'
                 , 'B', 'B입니다'
                 , 'C', 'C입니다'
                 , '전부 아닙니다') 
               FROM DUAL; -- ELSE IF구문
--
SELECT JOB_ID, DECODE(JOB_ID, 'IT_PROG', SALARY*1.1
                    , 'AD_VP', SALARY*1.2
                    , 'FI_MGR', SALARY*1.3
                    , SALARY) 
                    AS 급여 FROM EMPLOYEES;

-- CASE WHEN THEN ELSE END (SWITCH문과 비슷)
SELECT JOB_ID, 
       CASE JOB_ID WHEN 'IT_PROG' THEN SALARY * 1.1
                   WHEN 'AD_VP' THEN SALARY * 1.2
                   WHEN 'FI_MGR' THEN SALARY * 1.3
                   ELSE SALARY
       END AS 급여
FROM EMPLOYEES;

-- 비교에 대한 조건을 WHEN절에 쓸 수 있음
SELECT JOB_ID, 
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY*1.1
            WHEN JOB_ID = 'AD_VP' THEN SALARY*1.2
            WHEN JOB_ID = 'FI_MGR' THEN SALARY*1.3
            ELSE SALARY
       END AS 급여
FROM EMPLOYEES;

----------- 연습문제---------------------
--문제 1.
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
--조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다.
SELECT EMPLOYEE_ID AS 사원번호, 
       CONCAT(FIRST_NAME || ' ', LAST_NAME) AS 사원명, 
       HIRE_DATE AS 입사일자, 
       FLOOR((SYSDATE - HIRE_DATE) / 365) AS 근속년수 -- FLOOR말고 TRUNC도 사용 가능 
       FROM EMPLOYEES 
       WHERE FLOOR((SYSDATE - HIRE_DATE) / 365) > = 10 ORDER BY 근속년수 DESC;

--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘부장’ 
--120이라면 ‘과장’
--121이라면 ‘대리’
--122라면 ‘주임’
--나머지는 ‘사원’ 으로 출력합니다.
--조건 1) 부서가 50인 사람들을 대상으로만 조회합니다
--조건 2) DECODE구문으로 표현해보세요.
--조건 3) CASE구문으로 표현해보세요.
SELECT FIRST_NAME, MANAGER_ID, DECODE(MANAGER_ID, 100, '부장'
                                     , 120, '과장'
                                     , 121, '대리'
                                     , 122, '주임'
                                     , '사원') AS 직급
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

SELECT FIRST_NAME, MANAGER_ID, CASE MANAGER_ID WHEN 100 THEN '부장' 
                                               WHEN 120 THEN '과장' 
                                               WHEN 121 THEN '대리' 
                                               WHEN 122 THEN '주임'
                                               ELSE '사원' 
                                               END AS 직급
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

--문제 3. 
--EMPLOYEES 테이블의 이름, 입사일, 급여, 진급대상을 출력합니다.
--조건1) HIRE_DATE를 XXXX년XX월XX일 형식으로 출력하세요. 
--조건2) 급여는 커미션값이 퍼센트로 더해진 값을 출력하고, 1300을 곱한 원화로 바꿔서 출력하세요.
--조건3) 진급대상은 5년 마다 이루어 집니다. 근속년수가 5의 배수라면 진급대상으로 출력합니다.
        -- 근속년수를 구해서 -> MOD로 나머지를 구하고 -> DECODE를 이용해 진급대상 출력
--조건4) 부서가 NULL이 아닌 데이터를 대상으로 출력합니다.
SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS 이름, 
       TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') AS 입사일,
       TO_CHAR((SALARY + SALARY + NVL(COMMISSION_PCT, 0)) * 1300, 'L999,999,999') AS 급여, 
       FLOOR((SYSDATE - HIRE_DATE) / 365) AS 근속년수,
       DECODE(MOD(FLOOR((SYSDATE - HIRE_DATE)/ 365), 5), 0, '진급대상', '진급대상 아님') AS 진급대상
FROM EMPLOYEES WHERE DEPARTMENT_ID IS NOT NULL; 
