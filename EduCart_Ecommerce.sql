-- ============================================================
--        EduCart – E-Commerce Order Management System
--              SQL Project | BCA Academic Submission
-- ============================================================
-- Database  : MySQL 8.0+
-- Author    : Sameer
-- Project   : EduCart – E-Commerce Order System
-- ============================================================

DROP DATABASE IF EXISTS educart;
CREATE DATABASE educart;
USE educart;

-- ============================================================
--  SECTION 1: SCHEMA – TABLE CREATION
-- ============================================================

-- 1. Customers
CREATE TABLE customers (
    customer_id     INT AUTO_INCREMENT PRIMARY KEY,
    full_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    phone           VARCHAR(15),
    city            VARCHAR(50),
    state           VARCHAR(50),
    joined_date     DATE NOT NULL,
    is_active       BOOLEAN DEFAULT TRUE
);

-- 2. Categories
CREATE TABLE categories (
    category_id     INT AUTO_INCREMENT PRIMARY KEY,
    category_name   VARCHAR(100) NOT NULL UNIQUE,
    description     VARCHAR(255)
);

-- 3. Sellers
CREATE TABLE sellers (
    seller_id       INT AUTO_INCREMENT PRIMARY KEY,
    seller_name     VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    city            VARCHAR(50),
    rating          DECIMAL(3,2) DEFAULT 0.00,
    joined_date     DATE NOT NULL
);

-- 4. Products
CREATE TABLE products (
    product_id      INT AUTO_INCREMENT PRIMARY KEY,
    product_name    VARCHAR(150) NOT NULL,
    category_id     INT NOT NULL,
    seller_id       INT NOT NULL,
    price           DECIMAL(10,2) NOT NULL,
    stock_qty       INT DEFAULT 0,
    is_available    BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (seller_id)   REFERENCES sellers(seller_id)
);

-- 5. Orders
CREATE TABLE orders (
    order_id        INT AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT NOT NULL,
    order_date      DATETIME NOT NULL,
    delivery_date   DATE,
    status          ENUM('Pending','Processing','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    total_amount    DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 6. Order Items
CREATE TABLE order_items (
    item_id         INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    product_id      INT NOT NULL,
    quantity        INT NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    subtotal        DECIMAL(10,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 7. Payments
CREATE TABLE payments (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL UNIQUE,
    payment_date    DATETIME NOT NULL,
    method          ENUM('UPI','Credit Card','Debit Card','Net Banking','COD') NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    status          ENUM('Paid','Pending','Failed','Refunded') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 8. Reviews
CREATE TABLE reviews (
    review_id       INT AUTO_INCREMENT PRIMARY KEY,
    product_id      INT NOT NULL,
    customer_id     INT NOT NULL,
    rating          TINYINT CHECK (rating BETWEEN 1 AND 5),
    review_text     TEXT,
    review_date     DATE NOT NULL,
    FOREIGN KEY (product_id)  REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================================
--  SECTION 2: SAMPLE DATA – INSERT STATEMENTS
-- ============================================================

-- Categories
INSERT INTO categories (category_name, description) VALUES
('Electronics',     'Gadgets, mobiles, laptops and accessories'),
('Books',           'Academic, fiction and non-fiction books'),
('Clothing',        'Men and women fashion and apparel'),
('Home & Kitchen',  'Furniture, cookware and home decor'),
('Sports',          'Fitness equipment and outdoor gear');

-- Sellers
INSERT INTO sellers (seller_name, email, city, rating, joined_date) VALUES
('TechZone India',      'techzone@gmail.com',    'Delhi',   4.50, '2021-03-10'),
('BookNest',            'booknest@gmail.com',    'Pune',    4.80, '2020-07-15'),
('FashionHub',          'fashionhub@gmail.com',  'Mumbai',  4.20, '2021-11-01'),
('HomeEssentials',      'homeess@gmail.com',     'Chennai', 4.60, '2022-01-20'),
('FitLife Store',       'fitlife@gmail.com',     'Noida',   4.35, '2022-05-05');

-- Customers
INSERT INTO customers (full_name, email, phone, city, state, joined_date) VALUES
('Aarav Sharma',    'aarav@gmail.com',    '9812345670', 'Lucknow',   'UP',        '2022-01-10'),
('Priya Verma',     'priya@gmail.com',    '9823456781', 'Kanpur',    'UP',        '2022-03-15'),
('Rohit Singh',     'rohit@gmail.com',    '9834567892', 'Delhi',     'Delhi',     '2022-05-20'),
('Neha Gupta',      'neha@gmail.com',     '9845678903', 'Agra',      'UP',        '2022-07-11'),
('Arjun Patel',     'arjun@gmail.com',    '9856789014', 'Ahmedabad', 'Gujarat',   '2022-09-01'),
('Sneha Joshi',     'sneha@gmail.com',    '9867890125', 'Pune',      'Maharashtra','2023-01-05'),
('Vikram Yadav',    'vikram@gmail.com',   '9878901236', 'Varanasi',  'UP',        '2023-02-14'),
('Anjali Mishra',   'anjali@gmail.com',   '9889012347', 'Bhopal',    'MP',        '2023-04-22'),
('Karan Mehta',     'karan@gmail.com',    '9890123458', 'Jaipur',    'Rajasthan', '2023-06-30'),
('Divya Rao',       'divya@gmail.com',    '9901234569', 'Hyderabad', 'Telangana', '2023-08-18');

-- Products
INSERT INTO products (product_name, category_id, seller_id, price, stock_qty) VALUES
('Samsung Galaxy M34',          1, 1, 18999.00, 50),
('Boat Rockerz Earphones',      1, 1,  1499.00, 120),
('Lenovo IdeaPad Laptop',       1, 1, 45999.00, 20),
('Data Structures by Lipschutz',2, 2,   499.00, 200),
('Wings of Fire – APJ Kalam',   2, 2,   299.00, 150),
('Python Programming Guide',    2, 2,   599.00, 180),
('Men Casual T-Shirt',          3, 3,   799.00, 300),
('Women Kurti Set',             3, 3,  1299.00, 250),
('Prestige Pressure Cooker',    4, 4,  2499.00,  80),
('Yoga Mat Anti-Slip',          5, 5,   899.00, 100),
('Dumbbell Set 10kg',           5, 5,  2199.00,  60),
('Wireless Keyboard & Mouse',   1, 1,  1299.00, 150);

-- Orders
INSERT INTO orders (customer_id, order_date, delivery_date, status, total_amount) VALUES
(1,  '2024-01-05 10:30:00', '2024-01-10', 'Delivered',   20498.00),
(2,  '2024-01-12 14:00:00', '2024-01-17', 'Delivered',    1798.00),
(3,  '2024-02-01 09:15:00', '2024-02-06', 'Delivered',   46798.00),
(4,  '2024-02-14 11:45:00', '2024-02-19', 'Delivered',    1397.00),
(5,  '2024-03-03 16:20:00', '2024-03-08', 'Delivered',    2499.00),
(6,  '2024-03-18 13:10:00', '2024-03-23', 'Delivered',    3798.00),
(7,  '2024-04-05 08:00:00', '2024-04-10', 'Delivered',    2198.00),
(8,  '2024-04-20 17:30:00', '2024-04-25', 'Shipped',      1299.00),
(9,  '2024-05-02 12:00:00', NULL,         'Processing',   19898.00),
(10, '2024-05-15 10:00:00', NULL,         'Pending',       899.00),
(1,  '2024-05-20 15:45:00', NULL,         'Cancelled',    1499.00),
(3,  '2024-06-01 09:00:00', NULL,         'Processing',   2199.00);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1,  1,  1, 18999.00),
(1,  2,  1,  1499.00),
(2,  7,  2,   799.00),
(2,  8,  1,  1299.00),  -- adjusted row for variety
(3,  3,  1, 45999.00),
(3,  12, 1,  1299.00),  -- keyboard
(4,  4,  1,   499.00),
(4,  5,  2,   299.00),
(4,  6,  1,   599.00),  -- Python book
(5,  9,  1,  2499.00),
(6,  10, 1,   899.00),
(6,  11, 1,  2199.00),
(6,  7,  1,   799.00),
(7,  8,  1,  1299.00),
(7,  7,  1,   799.00),
(8,  12, 1,  1299.00),
(9,  1,  1, 18999.00),
(9,  2,  1,   899.00),
(10, 10, 1,   899.00),
(11, 2,  1,  1499.00),
(12, 11, 1,  2199.00);

-- Payments
INSERT INTO payments (order_id, payment_date, method, amount, status) VALUES
(1,  '2024-01-05 10:35:00', 'UPI',         20498.00, 'Paid'),
(2,  '2024-01-12 14:05:00', 'Credit Card',  1798.00, 'Paid'),
(3,  '2024-02-01 09:20:00', 'Net Banking', 46798.00, 'Paid'),
(4,  '2024-02-14 11:50:00', 'UPI',          1397.00, 'Paid'),
(5,  '2024-03-03 16:25:00', 'Debit Card',   2499.00, 'Paid'),
(6,  '2024-03-18 13:15:00', 'UPI',          3798.00, 'Paid'),
(7,  '2024-04-05 08:05:00', 'COD',          2198.00, 'Paid'),
(8,  '2024-04-20 17:35:00', 'UPI',          1299.00, 'Paid'),
(9,  '2024-05-02 12:05:00', 'Credit Card', 19898.00, 'Pending'),
(10, '2024-05-15 10:05:00', 'COD',           899.00, 'Pending'),
(11, '2024-05-20 15:50:00', 'UPI',          1499.00, 'Refunded'),
(12, '2024-06-01 09:05:00', 'Debit Card',   2199.00, 'Pending');

-- Reviews
INSERT INTO reviews (product_id, customer_id, rating, review_text, review_date) VALUES
(1,  1, 5, 'Excellent phone! Great camera and battery.',      '2024-01-12'),
(2,  1, 4, 'Good sound quality, comfortable fit.',           '2024-01-12'),
(3,  3, 5, 'Fast laptop, perfect for coding and college.',   '2024-02-08'),
(4,  4, 5, 'Very helpful for DSA exam preparation.',         '2024-02-20'),
(5,  4, 4, 'Inspirational book, loved reading it.',          '2024-02-20'),
(9,  5, 4, 'Sturdy and works great, worth the price.',       '2024-03-10'),
(10, 6, 5, 'Perfect yoga mat, good grip on floor.',          '2024-03-25'),
(11, 6, 4, 'Decent dumbbells, good for home workout.',       '2024-03-25'),
(7,  2, 3, 'Okay quality, stitching could be better.',       '2024-01-18'),
(12, 8, 4, 'Works smoothly, good wireless range.',           '2024-04-27');

-- ============================================================
--  SECTION 3: QUERIES
-- ============================================================

-- ------------------------------------------------------------
-- BASIC QUERIES
-- ------------------------------------------------------------

-- Q1: View all customers
SELECT * FROM customers;

-- Q2: All available products with price
SELECT product_name, price, stock_qty
FROM products
WHERE is_available = TRUE
ORDER BY price ASC;

-- Q3: All orders and their status
SELECT order_id, customer_id, order_date, status, total_amount
FROM orders
ORDER BY order_date DESC;

-- Q4: Products under ₹1000
SELECT product_name, price
FROM products
WHERE price < 1000
ORDER BY price;

-- Q5: Customers from Uttar Pradesh
SELECT full_name, city, phone
FROM customers
WHERE state = 'UP';

-- ------------------------------------------------------------
-- QUERIES USING JOINS
-- ------------------------------------------------------------

-- Q6: Orders with customer names
SELECT o.order_id, c.full_name, c.city, o.order_date, o.status, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- Q7: Order items with product names and subtotals
SELECT oi.order_id, p.product_name, oi.quantity, oi.unit_price, oi.subtotal
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id;

-- Q8: Full order details (customer + product + payment)
SELECT
    o.order_id,
    c.full_name        AS customer,
    p.product_name,
    oi.quantity,
    oi.subtotal,
    pay.method         AS payment_method,
    pay.status         AS payment_status,
    o.status           AS order_status
FROM orders o
JOIN customers   c   ON o.customer_id  = c.customer_id
JOIN order_items oi  ON o.order_id     = oi.order_id
JOIN products    p   ON oi.product_id  = p.product_id
JOIN payments    pay ON o.order_id     = pay.order_id
ORDER BY o.order_id;

-- Q9: Products with their category and seller name
SELECT
    p.product_name,
    c.category_name,
    s.seller_name,
    p.price,
    p.stock_qty
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN sellers    s ON p.seller_id   = s.seller_id
ORDER BY c.category_name;

-- Q10: Reviews with customer name and product name
SELECT
    r.review_id,
    cu.full_name   AS reviewer,
    p.product_name,
    r.rating,
    r.review_text,
    r.review_date
FROM reviews r
JOIN customers cu ON r.customer_id = cu.customer_id
JOIN products  p  ON r.product_id  = p.product_id
ORDER BY r.review_date DESC;

-- ------------------------------------------------------------
-- AGGREGATE QUERIES
-- ------------------------------------------------------------

-- Q11: Total revenue from all paid orders
SELECT CONCAT('₹', FORMAT(SUM(amount), 2)) AS total_revenue
FROM payments
WHERE status = 'Paid';

-- Q12: Number of orders per status
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- Q13: Revenue by payment method
SELECT method, COUNT(*) AS transactions, SUM(amount) AS total_amount
FROM payments
WHERE status = 'Paid'
GROUP BY method
ORDER BY total_amount DESC;

-- Q14: Top 5 best-selling products by quantity sold
SELECT
    p.product_name,
    SUM(oi.quantity)  AS total_qty_sold,
    SUM(oi.subtotal)  AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_qty_sold DESC
LIMIT 5;

-- Q15: Average rating per product (only rated products)
SELECT
    p.product_name,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.review_id)      AS total_reviews
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY avg_rating DESC;

-- Q16: Total spending per customer
SELECT
    c.full_name,
    c.city,
    COUNT(o.order_id)      AS total_orders,
    SUM(o.total_amount)    AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'Cancelled'
GROUP BY c.full_name, c.city
ORDER BY total_spent DESC;

-- Q17: Monthly revenue trend
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    COUNT(payment_id)                  AS orders_paid,
    SUM(amount)                        AS monthly_revenue
FROM payments
WHERE status = 'Paid'
GROUP BY month
ORDER BY month;

-- Q18: Category-wise revenue
SELECT
    cat.category_name,
    SUM(oi.subtotal) AS category_revenue
FROM order_items oi
JOIN products   p   ON oi.product_id  = p.product_id
JOIN categories cat ON p.category_id  = cat.category_id
GROUP BY cat.category_name
ORDER BY category_revenue DESC;

-- ------------------------------------------------------------
-- SUBQUERIES
-- ------------------------------------------------------------

-- Q19: Customers who have never placed an order
SELECT full_name, email, city
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- Q20: Products never ordered
SELECT product_name, price
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM order_items);

-- Q21: Orders with above-average order value
SELECT order_id, customer_id, total_amount
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
ORDER BY total_amount DESC;

-- Q22: Most expensive product in each category
SELECT category_name, product_name, price
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
)
ORDER BY price DESC;

-- ------------------------------------------------------------
-- WINDOW FUNCTIONS
-- ------------------------------------------------------------

-- Q23: Rank customers by total spending
SELECT
    c.full_name,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS spending_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'Cancelled'
GROUP BY c.full_name;

-- Q24: Running total of revenue over time
SELECT
    DATE(payment_date)  AS pay_date,
    SUM(amount)         AS daily_revenue,
    SUM(SUM(amount)) OVER (ORDER BY DATE(payment_date)) AS running_total
FROM payments
WHERE status = 'Paid'
GROUP BY pay_date;

-- Q25: Product rank within each category by price
SELECT
    c.category_name,
    p.product_name,
    p.price,
    RANK() OVER (PARTITION BY c.category_name ORDER BY p.price DESC) AS price_rank
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- ------------------------------------------------------------
-- VIEWS
-- ------------------------------------------------------------

-- View 1: Order summary view
CREATE OR REPLACE VIEW vw_order_summary AS
SELECT
    o.order_id,
    c.full_name     AS customer_name,
    c.city,
    o.order_date,
    o.status,
    o.total_amount,
    pay.method      AS payment_method,
    pay.status      AS payment_status
FROM orders o
JOIN customers c  ON o.customer_id = c.customer_id
JOIN payments pay ON o.order_id    = pay.order_id;

SELECT * FROM vw_order_summary;

-- View 2: Product performance view
CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    p.product_id,
    p.product_name,
    cat.category_name,
    s.seller_name,
    IFNULL(SUM(oi.quantity), 0)  AS total_sold,
    IFNULL(SUM(oi.subtotal), 0)  AS total_revenue,
    IFNULL(ROUND(AVG(r.rating),2), 'No reviews') AS avg_rating
FROM products p
JOIN categories  cat ON p.category_id  = cat.category_id
JOIN sellers     s   ON p.seller_id    = s.seller_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN reviews     r  ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name, cat.category_name, s.seller_name;

SELECT * FROM vw_product_performance ORDER BY total_revenue DESC;

-- ------------------------------------------------------------
-- STORED PROCEDURE
-- ------------------------------------------------------------

DELIMITER $$

-- Procedure: Get all orders of a specific customer
CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT
        o.order_id,
        o.order_date,
        o.status,
        o.total_amount,
        pay.method,
        pay.status AS payment_status
    FROM orders o
    JOIN payments pay ON o.order_id = pay.order_id
    WHERE o.customer_id = cust_id
    ORDER BY o.order_date DESC;
END$$

DELIMITER ;

-- Usage example:
CALL GetCustomerOrders(1);
CALL GetCustomerOrders(3);

-- ------------------------------------------------------------
-- TRIGGER
-- ------------------------------------------------------------

DELIMITER $$

-- Trigger: Reduce stock when an order item is inserted
CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_qty = stock_qty - NEW.quantity
    WHERE product_id = NEW.product_id;
END$$

DELIMITER ;

-- ============================================================
--  SECTION 4: ANALYTICAL SUMMARY QUERIES
-- ============================================================

-- Q26: Dashboard KPIs
SELECT
    (SELECT COUNT(*) FROM customers)             AS total_customers,
    (SELECT COUNT(*) FROM products)              AS total_products,
    (SELECT COUNT(*) FROM orders)                AS total_orders,
    (SELECT COUNT(*) FROM orders WHERE status = 'Delivered') AS delivered_orders,
    (SELECT CONCAT('₹', FORMAT(SUM(amount),2))
     FROM payments WHERE status = 'Paid')        AS total_revenue;

-- Q27: Top customer of each state
SELECT state, full_name, total_spent
FROM (
    SELECT
        c.state,
        c.full_name,
        SUM(o.total_amount) AS total_spent,
        RANK() OVER (PARTITION BY c.state ORDER BY SUM(o.total_amount) DESC) AS rnk
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status != 'Cancelled'
    GROUP BY c.state, c.full_name
) ranked
WHERE rnk = 1;

-- Q28: Low stock alert (stock below 30)
SELECT product_name, stock_qty, seller_id
FROM products
WHERE stock_qty < 30
ORDER BY stock_qty ASC;

-- Q29: Cancelled order analysis
SELECT
    c.full_name,
    COUNT(o.order_id)   AS cancelled_orders,
    SUM(o.total_amount) AS cancelled_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'Cancelled'
GROUP BY c.full_name;

-- Q30: Seller performance report
SELECT
    s.seller_name,
    s.city,
    COUNT(DISTINCT p.product_id)  AS products_listed,
    SUM(oi.quantity)              AS units_sold,
    SUM(oi.subtotal)              AS total_revenue,
    s.rating                      AS seller_rating
FROM sellers s
JOIN products    p  ON s.seller_id   = p.seller_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY s.seller_name, s.city, s.rating
ORDER BY total_revenue DESC;

-- ============================================================
--  END OF PROJECT – EduCart
-- ============================================================
