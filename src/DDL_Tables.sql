/* <sc-table> DEMO_DB.DimSalesReason </sc-table> */
CREATE SET TABLE DEMO_DB.DimSalesReason,
	NO FALLBACK,
	NO BEFORE JOURNAL,
	NO AFTER JOURNAL,
	CHECKSUM = DEFAULT,
	DEFAULT MERGEBLOCKRATIO
	(
		EmployeeKey INTEGER NOT NULL,
		ParentEmployeeKey INTEGER,
		EmployeeNationalIDAlternateKey VARCHAR(15) CHARACTER SET LATIN NOT CASESPECIFIC,
		FirstName VARCHAR(50) CHARACTER SET UNICODE NOT CASESPECIFIC NOT NULL,
		NameStyle BYTEINT CHECK ( NameStyle  IN (0 ,1 ) ) NOT NULL,
		"Title" VARCHAR(50) CHARACTER SET UNICODE NOT CASESPECIFIC,
		HireDate DATE FORMAT 'yyyy-mm-dd',
		PayFrequency BYTEINT,
		BaseRate NUMBER(18,4),
		VacationHours SMALLINT,
		EmployeePhoto BLOB(2097088000),
		Weight NUMBER,
		SalesOrderLineNumber SMALLINT NOT NULL COMPRESS (1 ,2 ,3 ),
		SalesReasonKey INTEGER NOT NULL COMPRESS (1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10 ),
		EmailAddress VARCHAR(50) CHARACTER SET UNICODE NOT CASESPECIFIC COMPRESS USING TD_SYSFNLIB.TRANSUNICODETOUTF8 DECOMPRESS USING TD_SYSFNLIB.TRANSUTF8TOUNICODE,
		EnglishEducation VARCHAR(40) CHARACTER SET LATIN NOT CASESPECIFIC COMPRESS ('Bachelors','Partial College','High School','Graduate Degree','Partial High School'),
		EMPLOYMENT_PERIOD PERIOD(DATE) FORMAT 'YYYY-MM-DD',
		INTERVAL_YEAR_TYPE INTERVAL YEAR(2),
		INTERVAL_MONTH_TYPE INTERVAL MONTH(2),
		SALARY_AMOUNT DECIMAL(10,2) NOT NULL,
		TS TIMESTAMP(6),
	
PRIMARY KEY ( EmployeeKey ))
;


/* <sc-table> DEMO_DB.DimSalesReason2 </sc-table> */
CREATE SET TABLE DEMO_DB.DimSalesReason2 ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      SalesReasonKey INTEGER NOT NULL,
      SalesReasonAlternateKey INTEGER NOT NULL,
      SalesReasonName VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
      SalesReasonReasonType VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL, 
PRIMARY KEY ( SalesReasonKey ))
;


/* <sc-table> DEMO_DB.FactSalesQuota </sc-table> */
CREATE TABLE DEMO_DB.FactSalesQuota ,NO FALLBACK ,
    NO BEFORE JOURNAL,
    NO AFTER JOURNAL,
    CHECKSUM = DEFAULT,
    DEFAULT MERGEBLOCKRATIO
    (
     SalesQuotaKey INTEGER NOT NULL,
     EmployeeKey INTEGER NOT NULL,
     DateKey INTEGER NOT NULL,
     CalendarYear SMALLINT NOT NULL,
     CalendarQuarter BYTEINT NOT NULL,
     SalesAmountQuota NUMBER(18,4) NOT NULL,
     "Date" DATE FORMAT 'yyyy-mm-dd', 
PRIMARY KEY ( SalesQuotaKey ))
PARTITION BY COLUMN (CALENDARYEAR);
;


/* <sc-table> DEMO_DB.PERSON_EMPLOYMENT_PERIOD </sc-table> */
CREATE MULTISET TABLE DEMO_DB.PERSON_EMPLOYMENT_PERIOD ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      PERSON_ID INTEGER NOT NULL,
      EMPLOYMENT_PERIOD PERIOD(DATE) FORMAT 'YYYY-MM-DD')
PRIMARY INDEX ( PERSON_ID );

/* <sc-table> DEMO_DB.PERSON_EMPLOYMENT_PERIOD </sc-table> */
CREATE MULTISET VOLATILE TABLE DEMO_DB.TEMP_QUAL_TABLE, NO LOG 
AS 
(
SELECT
YR || '-' || SALE_MONTH (NAMED YEARMONTH),
CALENDARYEAR YR,
MONTHNUMBEROFYEAR AS SALE_MONTH,
SALESAMOUNT AS SALE_AMT
FROM
DEMO_DB.DIMDATE DD,
DEMO_DB.FACTINTERNETSALES FIS
WHERE FIS.ORDERDATEKEY = DD.DATEKEY
QUALIFY RANK() OVER (PARTITION BY YR ORDER BY SALESAMOUNT) = 1
)
WITH DATA
ON COMMIT PRESERVE ROWS;


/* <sc-table> DEMO_DB.FACTFINANCE_COPY_WITHOUT_DATA </sc-table> */
CREATE TABLE DEMO_DB.FACTFINANCE_COPY_WITHOUT_DATA 
AS DEMO_DB.FACTFINANCE
WITH NO DATA;


/* <sc-table> DEMO_DB.ACT_COUNT  </sc-table> */
CREATE MULTISET TABLE DEMO_DB.ACT_COUNT ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      ACT_COUNT INTEGER,
      LOCATION VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC)
PRIMARY INDEX ( ACT_COUNT );

/* <sc-table> DEMO_DB.EMPLOYEE  </sc-table> */
CREATE MULTISET TABLE DEMO_DB.EMPLOYEE ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      EMP_ID INTEGER TITLE 'Identifier',
      EMP_NAME VARCHAR(30) CHARACTER SET LATIN NOT CASESPECIFIC TITLE 'Full Name',
      EMP_PHONE VARCHAR(14) CHARACTER SET LATIN NOT CASESPECIFIC TITLE 'Phone Number')
PRIMARY INDEX ( EMP_ID );

/* <sc-table> DEMO_DB.EMPLOYEE_DUPE </sc-table> */
CREATE MULTISET TABLE DEMO_DB.EMPLOYEE_DUPE AS 
(SELECT * FROM DEMO_DB.EMPLOYEE) WITH DATA;	


/* <sc-table> DEMO_DB.INTERVAL_DATA_TYPE  </sc-table> */
CREATE SET TABLE DEMO_DB.INTERVAL_DATA_TYPE ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      INTERVAL_YEAR_TYPE INTERVAL YEAR(2),
      INTERVAL_MONTH_TYPE INTERVAL MONTH(2),
      INTERVAL_YEAR2MONTH_TYPE INTERVAL YEAR(2) TO MONTH,
      INTERVAL_DAY_TYPE INTERVAL DAY(2),
      INTERVAL_DAY2HOUR_TYPE INTERVAL DAY(2) TO HOUR,
      INTERVAL_DAY2MINUTE_TYPE INTERVAL DAY(2) TO MINUTE,
      INTERVAL_DAY2SECOND_TYPE INTERVAL DAY(2) TO SECOND(6),
      INTERVAL_HOUR_TYPE INTERVAL HOUR(2),
      INTERVAL_HOUR2MINUTE_TYPE INTERVAL HOUR(2) TO MINUTE,
      INTERVAL_HOUR2SECOND_TYPE INTERVAL HOUR(2) TO SECOND(6),
      INTERVAL_MINUTE_TYPE INTERVAL MINUTE(2),
      INTERVAL_MINUTE2SECOND_TYPE INTERVAL MINUTE(3) TO SECOND(3),
      INTERVAL_SECOND_TYPE INTERVAL SECOND(2,6))
PRIMARY INDEX ( INTERVAL_YEAR_TYPE );

/* <sc-table> DEMO_DB.EMPLOYEE_PERIOD  </sc-table> */
CREATE SET TABLE DEMO_DB.EMPLOYEE_PERIOD ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      EMPLOYEE_NUMBER INTEGER NOT NULL,
      MANAGER_EMPLOYEE_NUMBER INTEGER,
      DEPARTMENT_NUMBER INTEGER,
      JOB_CODE INTEGER,
      LAST_NAME CHAR(20) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
      FIRST_NAME VARCHAR(30) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
      SALARY_AMOUNT DECIMAL(10,2) NOT NULL,
      BIRTHDATE DATE FORMAT 'YYYY-MM-DD' NOT NULL,
      JOB_DURATION PERIOD(DATE) FORMAT 'YYYY-MM-DD' NOT NULL)
PRIMARY INDEX ( EMPLOYEE_NUMBER );


/* <sc-table> DEMO_DB.FLIGHTS </sc-table> */
CREATE SET TABLE DEMO_DB.FLIGHTS ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      DESTINATION VARCHAR(100) CHARACTER SET LATIN NOT CASESPECIFIC,
      SOURCE VARCHAR(100) CHARACTER SET LATIN NOT CASESPECIFIC,
      COST INTEGER)
PRIMARY INDEX ( DESTINATION );


/* <sc-table> DEMO_DB.PERSON_LOGIN </sc-table> */
CREATE MULTISET TABLE DEMO_DB.PERSON_LOGIN ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      PERSON_ID INTEGER NOT NULL,
      LOGIN_DTM TIMESTAMP(6) NOT NULL)
PRIMARY INDEX ( PERSON_ID );


/* <sc-table> DEMO_DB.TABLE1  </sc-table> */
CREATE SET TABLE DEMO_DB.TABLE_1 ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
         column1 INTERVAL HOUR(2),
         column2 INTEGER,
         column3 VARCHAR(10)
     );


/* <sc-table> DEMO_DB.table_1  </sc-table> */
CREATE TABLE DEMO_DB.table_macro1
(
  column1 BYTEINT,
  column2 SMALLINT,
  column3 SMALLINT
);


