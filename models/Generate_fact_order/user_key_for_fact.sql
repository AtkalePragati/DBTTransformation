with Dim_User as(
select * from {{ ref('dim_user') }}
),
stag_order as(
    select * from {{ ref('src_stg_order') }}
)
select USER_KEY
from stag_order ord, Dim_user du 
where ord.OWNERID=du.USER_ID AND 
            ( (ord.EFFECTIVEDATE between to_date(du.EFFECTIVE_FROM) and to_date(du.EFFECTIVE_TO)) or
                 ( ord.EFFECTIVEDATE <= to_date(du.EFFECTIVE_FROM) )   
            )