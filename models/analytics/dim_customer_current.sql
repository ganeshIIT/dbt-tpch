{{
    config(
        materialized = 'table'
    )
}}
with customers as (

    select * from {{ ref('dim_customer') }} where to_date is null

),
final as (
    select 
        c.id,
        c.customer_hkey,
        c.customer_hdiff,
        c.customer_key,
        c.customer_name,
        c.customer_address,
        c.customer_nation_key,
        c.customer_nation_name,
        c.customer_region_key,
        c.customer_region_name,
        c.customer_phone_number,
        c.customer_account_balance,
        c.customer_market_segment_name,
        c.updated_at
    from
        customers c
)
select 
    f.*,
    {{ dbt_housekeeping() }}
from
    final f
order by
    f.customer_key