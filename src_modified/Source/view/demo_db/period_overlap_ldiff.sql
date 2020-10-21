/* <sc-view> DEMO_DB.PERIOD_OVERLAP_LDIFF </sc-view> */
REPLACE VIEW DEMO_DB.PERIOD_OVERLAP_LDIFF
AS 
LOCKING ROW FOR ACCESS
SELECT 'OVERLAP' FUNC, FIRST_NAME, LAST_NAME
FROM DEMO_DB.EMPLOYEE_PERIOD
WHERE JOB_DURATION OVERLAPS
PERIOD(DATE '2009-01-01', DATE '2010-09-24')
UNION ALL
SELECT 'LDIFF' FUNC, FIRST_NAME, LAST_NAME
FROM DEMO_DB.EMPLOYEE_PERIOD
WHERE INTERVAL(JOB_DURATION LDIFF PERIOD(DATE '2009-01-01', DATE '2010-09-24')) MONTH > 3 
UNION ALL
SELECT 'RDIFF' FUNC, FIRST_NAME, LAST_NAME
FROM DEMO_DB.EMPLOYEE_PERIOD
WHERE JOB_DURATION RDIFF PERIOD(DATE '2009-01-01', DATE '2010-09-24') IS NOT NULL;


