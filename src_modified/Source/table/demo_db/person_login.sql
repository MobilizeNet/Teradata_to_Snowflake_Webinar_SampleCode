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


