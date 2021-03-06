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


