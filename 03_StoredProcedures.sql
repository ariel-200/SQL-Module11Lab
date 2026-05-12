/*
    Stored Procedures for EmbroideryBusinessDB
    This file includes:
    1. sp_AddOrder - Adds an order and updates inventory
    2. sp_GetInventoryStatus - Retrieves inventory with stock alerts
    3. sp_DeleteOrder - Deletes an order and restores inventory
*/

USE EmbroideryBusinessDB;
GO


/* =====================================================
   STORED PROCEDURE 1: Add Order

   This procedure:
   - Checks if enough inventory is available
   - Creates a new order
   - Adds the order detail
   - Calculates the order total
   - Subtracts the purchased quantity from inventory
===================================================== */

CREATE PROCEDURE sp_AddOrder
    @CustomerID INT,
    @OrderDate DATE,
    @OrderStatus VARCHAR(30),
    @InventoryID INT,
    @Quantity INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @AvailableQuantity INT;
    DECLARE @SalePrice DECIMAL(10,2);
    DECLARE @OrderTotal DECIMAL(10,2);
    DECLARE @NewOrderID INT;

    -- Get the current quantity and sale price for the selected inventory item
    SELECT
        @AvailableQuantity = QuantityOnHand,
        @SalePrice = SalePrice
    FROM Inventory
    WHERE InventoryID = @InventoryID;

    -- Make sure the inventory item exists
    IF @AvailableQuantity IS NULL
    BEGIN
        RAISERROR('Inventory item does not exist.', 16, 1);
        RETURN;
    END;

    -- Make sure the order quantity is valid
    IF @Quantity <= 0
    BEGIN
        RAISERROR('Quantity must be greater than zero.', 16, 1);
        RETURN;
    END;

    -- Prevent an order from being placed if there is not enough stock
    IF @Quantity > @AvailableQuantity
    BEGIN
        RAISERROR('Not enough inventory available to place this order.', 16, 1);
        RETURN;
    END;

    -- Calculate the order total
    SET @OrderTotal = @Quantity * @SalePrice;

    -- Insert the new order
    INSERT INTO Orders (OrderDate, OrderTotal, OrderStatus, CustomerID)
    VALUES (@OrderDate, @OrderTotal, @OrderStatus, @CustomerID);

    -- Save the new OrderID
    SET @NewOrderID = SCOPE_IDENTITY();

    -- Insert the order detail
    INSERT INTO OrderDetails (Quantity, SalePrice, OrderID, InventoryID)
    VALUES (@Quantity, @SalePrice, @NewOrderID, @InventoryID);

    -- Subtract the ordered quantity from inventory
    UPDATE Inventory
    SET QuantityOnHand = QuantityOnHand - @Quantity
    WHERE InventoryID = @InventoryID;
END;
GO


/* =====================================================
   STORED PROCEDURE 2: Get Inventory Status

   This procedure:
   - Retrieves inventory data
   - Joins products, categories, sizes, and colors
   - Displays a stock alert based on quantity
===================================================== */

CREATE PROCEDURE sp_GetInventoryStatus
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Inventory.InventoryID,
        Products.ProductName,
        Categories.CategoryName,
        Sizes.SizeName,
        Colors.ColorName,
        Inventory.QuantityOnHand,
        Inventory.Cost,
        Inventory.SalePrice,

        -- Low inventory alert
        CASE
            WHEN Inventory.QuantityOnHand = 0 THEN 'Out of Stock'
            WHEN Inventory.QuantityOnHand <= 3 THEN 'Low Stock'
            ELSE 'In Stock'
        END AS StockStatus

    FROM Inventory

    INNER JOIN Products
        ON Inventory.ProductID = Products.ProductID

    INNER JOIN Categories
        ON Products.CategoryID = Categories.CategoryID

    INNER JOIN Sizes
        ON Inventory.SizeID = Sizes.SizeID

    INNER JOIN Colors
        ON Inventory.ColorID = Colors.ColorID

    ORDER BY Products.ProductName, Sizes.SizeName, Colors.ColorName;
END;
GO


/* =====================================================
   STORED PROCEDURE 3: Delete Order

   This procedure:
   - Restores inventory quantity before deleting an order
   - Deletes related order details
   - Deletes the order record
===================================================== */

CREATE PROCEDURE sp_DeleteOrder
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Make sure the order exists before trying to delete it
    IF NOT EXISTS (
        SELECT 1
        FROM Orders
        WHERE OrderID = @OrderID
    )
    BEGIN
        RAISERROR('Order does not exist.', 16, 1);
        RETURN;
    END;

    -- Restore inventory quantities from the order details
    UPDATE Inventory
    SET QuantityOnHand = QuantityOnHand + OrderDetails.Quantity
    FROM Inventory
    INNER JOIN OrderDetails
        ON Inventory.InventoryID = OrderDetails.InventoryID
    WHERE OrderDetails.OrderID = @OrderID;

    -- Delete order details first because they depend on Orders
    DELETE FROM OrderDetails
    WHERE OrderID = @OrderID;

    -- Delete the order
    DELETE FROM Orders
    WHERE OrderID = @OrderID;
END;
GO
