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

