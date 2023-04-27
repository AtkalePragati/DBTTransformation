{{
    config(
        materialized='table'
    )
}}

with Dim_User as(
select * from {{ ref('dim_user') }}
),
Dim_Account as(
select * from {{ ref('dim_account') }}
),
Dim_Date as(
select * from {{ ref('dim_date') }}
),
stag_order as(
    select * from {{ ref('src_stg_order') }}
)
select ID,USER_KEY,ACCOUNT_KEY,DATE_KEY,TOTALAMOUNT 
from stag_order ord,Dim_User du,Dim_Account acc,Dim_Date d
where 
    (   ord.OWNERID=du.USER_ID AND
            ( (ord.EFFECTIVEDATE between to_date(du.EFFECTIVE_FROM) AND to_date(du.EFFECTIVE_TO)) OR
                 ( ord.EFFECTIVEDATE <= to_date(du.EFFECTIVE_FROM) )   
            )
    
    )
    AND
        ord.ACCOUNTID=acc.ACCOUNT_ID 
    AND
        ord.EFFECTIVEDATE= d.DATE

