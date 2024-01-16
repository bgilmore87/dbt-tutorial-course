WITH products AS (
	SELECT
		product_id,
		department as product_department,
		cost as product_cost,
		retail_price as product_retail_price

	FROM {{ ref('stg_ecommerce__products') }}
)

SELECT

	--IDs
	order_items.order_id,
	order_items.order_item_id,
	order_items.user_id,
	order_items.product_id,

	--Order Item data
	order_items.item_sale_price,

	--Product Data
	products.product_department,
	products.product_cost,
	products.product_retail_price,

	--Calculated fields
	order_items.item_sale_price - products.product_cost as item_profit,
	products.product_retail_price - order_items.item_sale_price as item_discount

FROM {{ ref('stg_ecommerce__order_items') }} as order_items
left join products on order_items.product_id = products.product_id