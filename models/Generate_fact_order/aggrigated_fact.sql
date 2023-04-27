with source as(
select * from {{ ref('Fact_order') }}
),
aggrigated_fact as (
    select
    ACCOUNT_KEY ,DATE_KEY,
    sum(TOTALAMOUNT) as TOTALAMOUNT
from source
where TOTALAMOUNT >0
group by ACCOUNT_KEY,DATE_KEY
)
select * from aggrigated_fact