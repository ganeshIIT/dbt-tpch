{% snapshot ss_customer %}

{{
   config(
       unique_key='customer_hkey',
       strategy='check',
       check_cols=['customer_hdiff'],
   )
}}

select * from {{ ref('base_customer') }}

{% endsnapshot %}