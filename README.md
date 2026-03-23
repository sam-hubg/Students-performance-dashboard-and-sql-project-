# 📊 EduInsight – Student Performance Dashboard

A Power BI dashboard project built as part of my BCA academics.

## 🔍 What is this?
An interactive dashboard that visualizes academic performance of 50 students from Uttar Pradesh — analyzing grades, attendance, and factors like internet access and coaching.

## 📁 Files
| File | What it is |
|------|------------|
| `StudentPerformance.xlsx` | Raw dataset |
| `EduInsight.pbix` | Power BI dashboard |
| `PowerBI_BuildGuide.md` | How I built this step by step |

## 🛠️ Tools
Power BI Desktop · Excel · DAX · Power Query

## 👤 Author
**Sameer** — BCA Student, Uttar Pradesh, India
EduCart – E-Commerce Order Management System


A MySQL project simulating a real-world e-commerce backend with orders, products, sellers, payments and reviews.
Database Schema
8 tables with proper relationships:
customers → orders → order_items → products → categories
                ↓                      ↓
           payments               sellers
               reviews ← customers + products
Files
File
Description
EduCart_Ecommerce.sql
Full SQL — schema, data, queries
screenshot1.png
Best-selling products query output
screenshot2.png
Seller performance report output
What's Covered
Schema — 8 tables, foreign keys, constraints, ENUM, GENERATED columns
30 Queries — Basic → JOINs → Aggregates → Subqueries → Window Functions
2 Views — vw_order_summary, vw_product_performance
1 Stored Procedure — GetCustomerOrders(customer_id)
1 Trigger — Auto stock reduction on order insert
