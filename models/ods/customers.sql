{{
    config(
        materialized = 'table'
    )
}}
with customers as (

    {{ current_version_snapshot(
           ss_ref=ref('ss_customer')
     ) }}
    --select * from {{ ref('base_customer') }}

)
select 
    c.customer_hkey,
    c.customer_hdiff,
    c.customer_key,
    c.customer_name,
    c.customer_address,
    c.nation_key,
    c.customer_phone_number,
    c.customer_account_balance,
    c.customer_market_segment_name,
    SS_LOAD_TS_UTC
from
    customers c
order by
    c.customer_key