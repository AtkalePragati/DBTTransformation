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
select ID,USER_KEY,ACCOUNT_KEY,DATE_KEY,TOTALAMOUNT from stag_order ord,Dim_User u,Dim_Account acc,Dim_Date d
where ord.OWNERID=u.USER_ID AND
    ord.ACCOUNTID=acc.ACCOUNT_ID AND
    ord.EFFECTIVEDATE= d.DATE

