# 1

SELECT *,
       (SELECT customer_id 
        FROM orders 
        WHERE orders.id = order_details.order_id) AS customer_id
FROM order_details;

# 2

SELECT *
FROM order_details
WHERE order_id IN (SELECT id 
                   FROM orders 
                   WHERE shipper_id = 3);


# 3

SELECT order_id, AVG(quantity) AS average_quantity
FROM (SELECT * 
      FROM order_details 
      WHERE quantity > 10) AS filtered_details
GROUP BY order_id;


# 4

WITH temp AS (
    SELECT * 
    FROM order_details 
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS average_quantity
FROM temp
GROUP BY order_id;


# 5

DROP FUNCTION IF EXISTS divide;

DELIMITER //
CREATE FUNCTION divide(x FLOAT, y FLOAT) RETURNS FLOAT
DETERMINISTIC
BEGIN
    IF y = 0 THEN
        RETURN NULL;
    ELSE
        RETURN x / y;
    END IF;
END//
DELIMITER ;

SELECT quantity, divide(quantity, 3.0) AS one_third_quantity
FROM order_details;