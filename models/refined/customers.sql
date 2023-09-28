{{
    config(
        materialized = 'view'
    )
}}
with customers as (

    select * from {{ ref('ss_customer') }}

)
select 
    {{ dbt_utils.generate_surrogate_key(['c.customer_key','c.dbt_valid_from']) }} as id,
    c.customer_hkey,
    c.customer_hdiff,
    c.customer_key,
    c.customer_name,
    c.customer_address,
    c.nation_key,
    c.customer_phone_number,
    c.customer_account_balance,
    c.customer_market_segment_name,
    c.updated_at,
    c.dbt_updated_at,
    c.dbt_valid_from as from_date,
    nvl2(c.dbt_valid_to, dateadd('s',-1,c.dbt_valid_to), c.dbt_valid_to) as to_date
from customers c
order by
    c.customer_key, from_date