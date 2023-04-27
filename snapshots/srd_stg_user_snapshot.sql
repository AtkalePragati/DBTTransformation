{{
    config(
        materialized='ephemeral'
    )
}}

{% snapshot stg_user_ss %}
{{
    config(
      target_database='PC_DBT_DB',
      target_schema='TEMP',
      unique_key='USER_ID',
      strategy='check',
      check_cols=["U_LASTNAME","U_FIRSTNAME","EMAIL","PHONE_NO","CITY"]
    )
}}
select USER_ID,
    USER_NAME,
    U_LASTNAME,
    U_FIRSTNAME,
    EMAIL,
    PHONE_NO,
    CITY
 from {{ source('PC_DBT_DB', 'STG_USER') }}
{% endsnapshot %}

