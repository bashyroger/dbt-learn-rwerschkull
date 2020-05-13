select 
o.order_id
,o.customer_id
,sum(p.amount) as total_amount
from {{ ref('stg_orders') }} o
LEFT outer join {{ ref('stg_payment')}} p
on o.order_id=p."orderID"
group by 1,2
