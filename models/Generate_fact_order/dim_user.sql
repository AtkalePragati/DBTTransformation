{{
    config(
        materialized='table'
    )
}}
with SNAPSHOT_TABLE AS (
SELECT  2000+row_number() OVER (ORDER BY USER_ID) AS user_key ,* FROM {{ ref('stg_user_ss') }}
),
Dim_User as ( 
    select USER_KEY,
USER_ID,
USER_NAME,
U_LASTNAME,
U_FIRSTNAME,
EMAIL,
PHONE_NO,
CITY,DBT_VALID_FROM
         AS EFFECTIVE_FROM ,DBT_VALID_TO AS EFFECTIVE_TO,
(CASE WHEN DBT_VALID_TO IS NULL THEN 'TRUE' ELSE 'FALSE' END) AS STATUS
          FROM SNAPSHOT_TABLE 

)
select * from Dim_User
