{{
    config(
        materialized='table'
    )
}}
SELECT  3000+row_number() OVER (ORDER BY DATE ) AS Date_key , DATE, YEAR, MONTH, DAY from {{ ref('src_stg_date') }}
