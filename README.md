# Embroidery Business Database

## Project Overview
This project is a SQL Server database designed for a custom embroidery business. The database helps manage inventory, customer orders, products, sales, and profit tracking.

The system was created as a final SQL Server database project and demonstrates normalized database design, relationships, stored procedures, views, inventory management, and business reporting.

---

## Features
- Customer management
- Product and category tracking
- Inventory management
- Order processing
- Profit calculations
- Low inventory alerts
- Stored procedures
- SQL views
- Relational database design

---

### Database Tables
- Customers
- Orders
- OrderDetails
- Categories
- Products
- Inventory
- Sizes
- Colors

---

### Stored Procedures

#### `sp_AddOrder`
Adds a new order, checks inventory availability, updates inventory quantities, and calculates order totals.

#### `sp_GetInventoryStatus`
Displays inventory information with low stock alerts.

#### `sp_DeleteOrder`
Restores inventory quantities and safely deletes orders and related order details.

---

### Views

#### `vw_OrderSummary`
Displays customer, order, product, size, color, and pricing information.

#### `vw_ProfitSummary`
Displays revenue, cost, and profit calculations.

---

### Technologies Used
- SQL Server
- Docker
- GitHub Codespaces
- SQLCMD
- VS Code SQL Extension

---

###### Author
###### Ariel Blackwell
