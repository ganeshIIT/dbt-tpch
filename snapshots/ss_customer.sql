{% snapshot ss_customer %}

{{
   config(
       unique_key='customer_hkey',
       strategy='timestamp',
       updated_at='updated_at',
   )
}}

select * from {{ ref('base_customer') }}

{% endsnapshot %}