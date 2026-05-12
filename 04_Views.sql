/*
    Views for EmbroideryBusinessDB
    This file includes:
    1. vw_OrderSummary
    2. vw_ProfitSummary
*/

USE EmbroideryBusinessDB;
GO


/* =====================================================
   VIEW 1: Order Summary

   Displays:
   - Customer information
   - Order information
   - Product information
   - Quantity and pricing
===================================================== */

CREATE VIEW vw_OrderSummary
AS

SELECT
    Orders.OrderID,
    Orders.OrderDate,
    Orders.OrderStatus,

    Customers.FirstName,
    Customers.LastName,

    Products.ProductName,
    Categories.CategoryName,

    Sizes.SizeName,
    Colors.ColorName,

    OrderDetails.Quantity,
    OrderDetails.SalePrice,

    -- Calculate line total
    (OrderDetails.Quantity * OrderDetails.SalePrice) AS LineTotal

FROM OrderDetails

INNER JOIN Orders
    ON OrderDetails.OrderID = Orders.OrderID

INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID

INNER JOIN Inventory
    ON OrderDetails.InventoryID = Inventory.InventoryID

INNER JOIN Products
    ON Inventory.ProductID = Products.ProductID

INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID

INNER JOIN Sizes
    ON Inventory.SizeID = Sizes.SizeID

INNER JOIN Colors
    ON Inventory.ColorID = Colors.ColorID;
GO



/* =====================================================
   VIEW 2: Profit Summary

   Displays:
   - Revenue
   - Cost
   - Profit calculations
===================================================== */

CREATE VIEW vw_ProfitSummary
AS

SELECT
    Orders.OrderID,

    Products.ProductName,
    Categories.CategoryName,

    OrderDetails.Quantity,

    Inventory.Cost,
    OrderDetails.SalePrice,

    -- Revenue calculation
    (OrderDetails.Quantity * OrderDetails.SalePrice) AS Revenue,

    -- Total cost calculation
    (OrderDetails.Quantity * Inventory.Cost) AS TotalCost,

    -- Profit calculation
    (
        (OrderDetails.Quantity * OrderDetails.SalePrice)
        -
        (OrderDetails.Quantity * Inventory.Cost)
    ) AS Profit

FROM OrderDetails

INNER JOIN Orders
    ON OrderDetails.OrderID = Orders.OrderID

INNER JOIN Inventory
    ON OrderDetails.InventoryID = Inventory.InventoryID

INNER JOIN Products
    ON Inventory.ProductID = Products.ProductID

INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID;
GO
