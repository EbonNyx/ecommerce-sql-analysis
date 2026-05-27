# 🛒 E-commerce Sales Analysis | MySQL

## 📌 Project Overview
This project analyzes e-commerce sales data using MySQL.
It covers customer behavior, revenue trends, product performance,
and order patterns using structured SQL queries.

---

## 🗄️ Database Schema
The database consists of 5 tables:

| Table | Description |
|---|---|
| `customers` | Customer details (name, city, email) |
| `products` | Product catalog with pricing |
| `categories` | Product categories |
| `orders` | Order info with status |
| `order_items` | Individual items per order |

---

## 🔍 Key Analysis Performed

- ✅ Total Revenue by Category
- ✅ Top 3 Customers by Spending
- ✅ Monthly Sales Trend
- ✅ Cancellation Rate
- ✅ Best Selling Products

---

## 🛠️ Tools Used
- MySQL 8.0
- MySQL Command Line

---

## 💡 Key Insights
- Electronics generated the highest revenue
- Majority of cancellations occurred in Feb 2024
- Top customer (Amit Sharma) placed 2 orders worth ₹1.5L+

---

## 🚀 How to Run This Project

1. Open MySQL Command Line
2. Run the following command:
   mysql -u root -p < ecommerce_analysis.sql
3. Then open MySQL and run analysis queries

---

## 📁 File Structure

ecommerce_analysis.sql   → All CREATE, INSERT & SELECT queries
