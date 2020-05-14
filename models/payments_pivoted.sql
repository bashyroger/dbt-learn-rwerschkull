{% set payment_methods = ["credit_card","coupon","gift_card","bank_transfer"] %}

with payments as (
    select * 
    from {{ ref('stg_payment') }}
), final as (
    select
        "orderID" as orderid, 
        {% for payment_method in payment_methods %}
        sum(case when "paymentMethod" = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount {{"," if not loop.last}}
        {% endfor %}
    from payments
    group by 1
)
select *
from final