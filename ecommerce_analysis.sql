Create the Database & Tables

CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    created_at DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),  -- 'delivered', 'cancelled', 'pending'
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

Insert Sample Data

INSERT INTO categories VALUES (1,'Electronics'),(2,'Clothing'),(3,'Books'),(4,'Home & Kitchen');

INSERT INTO customers VALUES
(1,'Amit Sharma','amit@gmail.com','Delhi','2023-01-15'),
(2,'Priya Mehta','priya@gmail.com','Mumbai','2023-02-20'),
(3,'Rahul Singh','rahul@gmail.com','Bangalore','2023-03-10'),
(4,'Sneha Roy','sneha@gmail.com','Kolkata','2023-04-05');

INSERT INTO products VALUES
(1,'iPhone 14',1,75000,50),
(2,'Samsung TV',1,45000,30),
(3,'T-Shirt',2,999,200),
(4,'Jeans',2,1999,150),
(5,'Harry Potter',3,499,100),
(6,'Air Fryer',4,3500,80);

INSERT INTO orders VALUES
(1,1,'2024-01-10','delivered'),
(2,2,'2024-01-15','delivered'),
(3,3,'2024-02-01','cancelled'),
(4,4,'2024-02-20','delivered'),
(5,1,'2024-03-05','pending');

INSERT INTO order_items VALUES
(1,1,1,1,75000),
(2,1,5,2,499),
(3,2,3,3,999),
(4,2,6,1,3500),
(5,3,2,1,45000),
(6,4,4,2,1999),
(7,5,1,1,75000);

Write Analysis Queries
1. Total Revenue by Category

SELECT c.category_name,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'delivered'
GROUP BY c.category_name
ORDER BY total_revenue DESC;

2. Top 3 Customers by Spending

SELECT cu.name, cu.city,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers cu
JOIN orders o ON cu.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'delivered'
GROUP BY cu.customer_id, cu.name, cu.city
ORDER BY total_spent DESC
LIMIT 3;

3. Monthly Sales Trend

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       COUNT(DISTINCT o.order_id) AS total_orders,
       SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'delivered'
GROUP BY month
ORDER BY month;

4. Cancellation Rate

SELECT 
    COUNT(*) AS total_orders,
    SUM(status = 'cancelled') AS cancelled_orders,
    ROUND(SUM(status = 'cancelled') * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM orders;

5. Best Selling Products

SELECT p.product_name,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC;

