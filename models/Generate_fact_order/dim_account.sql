{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key = 'ACCOUNT_ID',
        merge_update_columns = ['ACCOUNT_HOLDER_NAME','BILLING_CITY','PHONE_NO']
    )
}}
SELECT  1000+row_number() OVER (ORDER BY ACCOUNT_ID ) AS ACCOUNT_KEY ,ACCOUNT_ID,ACCOUNT_NUMBER,
        PHONE_NO ,ACCOUNT_HOLDER_NAME ,BILLING_CITY,SHIPPING_CITY
        from {{ ref('src_stg_account') }}

