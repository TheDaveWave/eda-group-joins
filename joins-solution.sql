-- 1. Get all customers and their addresses.
SELECT "customers"."first_name", "customers"."last_name", 
array_agg("addresses"."street" ||', '|| "addresses"."city" ||', '|| "addresses"."state" ||', '|| "addresses"."zip")
AS "address"
FROM "addresses" JOIN "customers" ON "addresses"."customer_id" = "customers"."id"
GROUP BY "customers"."id";

-- 2. Get all orders and their line items (orders, quantity and products).
SELECT "orders"."id" AS "order_id", "line_items"."quantity", "products"."description"
FROM "orders"
JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
JOIN "products" ON "products"."id" = "line_items"."product_id";

-- 3. Which warehouses have cheetos?
SELECT "warehouse"."warehouse"
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" ON "warehouse_product"."product_id" = "products"."id"
WHERE "products"."description" = 'cheetos';

-- 4. Which warehouses have diet pepsi?
SELECT "warehouse"."warehouse"
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" ON "warehouse_product"."product_id" = "products"."id"
WHERE "products"."description" = 'diet pepsi';

-- 5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT array_agg(DISTINCT "c"."first_name" ||', '|| "c"."last_name") AS "customer_name",
count(*) AS "orders" 
FROM "customers" AS "c"
JOIN "addresses" AS "a" ON "c"."id" = "a"."customer_id"
JOIN "orders" AS "o" ON "a"."id" = "o"."address_id"
GROUP BY "a"."customer_id";

-- 6. How many customers do we have?
SELECT count("customers"."id") FROM "customers";

-- 7. How many products do we carry?
SELECT count(DISTINCT "products"."description") FROM "products";

-- 8. What is the total available on-hand quantity of diet pepsi?



--Stretch
-- 9. How much was the total cost for each order?

-- 10. How much has each customer spent in total?

-- 11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table.
-- It should say 0, not NULL (research coalesce).
