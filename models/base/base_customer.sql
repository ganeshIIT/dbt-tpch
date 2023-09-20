{{
    config(
        materialized = 'ephemeral'
    )
}}

WITH
src_data as (
select
    c_custkey as customer_key,
    c_name as customer_name,
    c_address as customer_address,
    c_nationkey as nation_key,
    c_phone as customer_phone_number,
    c_acctbal{{ money() }} as customer_account_balance,
    c_mktsegment as customer_market_segment_name,
    c_comment as customer_comment
from
    {{ source('tpch', 'customer') }}
),

hashed as (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['customer_key']) }} as customer_hkey,
        {{ dbt_utils.generate_surrogate_key(
            ['customer_key', 
            'customer_name', 
            'customer_address', 
            'nation_key',
            'customer_phone_number', 
            'customer_account_balance', 
            'customer_market_segment_name']) 
        }} as customer_hdiff
        , * 
    FROM src_data
)
SELECT * FROM hashed