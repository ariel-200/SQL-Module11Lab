/*
    Insert sample data into the EmbroideryBusinessDB database.
*/

USE EmbroideryBusinessDB;
GO


/* Insert customers */
INSERT INTO Customers (FirstName, LastName, Phone, Email)
VALUES
('Nicole', 'Johnson', '702-858-5507', 'realnicole@gmail.com'),
('Lynette', 'Jackson', '225-507-9311', 'lynette.jackson@gmail.com'),
('Sabrina', 'Jordan', '612-504-5393', 'jordans23@gmail.com'),
('Maya', 'Williams', '612-555-2048', 'maya.williams@gmail.com'),
('Kayla', 'Brown', '952-555-1872', 'kaylabrown@gmail.com'),
('Anthony', 'Davis', '651-555-3941', 'anthonydavis@gmail.com'),
('Jasmine', 'Moore', '763-555-7290', 'jasminemoore@gmail.com'),
('Trey', 'Anderson', '612-555-8854', 'trey.anderson@gmail.com'),
('Brianna', 'Taylor', '952-555-4682', 'briannataylor@gmail.com'),
('Marcus', 'Thomas', '651-555-9012', 'marcusthomas@gmail.com');

/* Insert categories */
INSERT INTO Categories (CategoryName)
VALUES
('Shirts'),
('Sweaters'),
('Hats'),
('Bags'),
('Accessories'),
('Bottoms'),
('Blankets');

/* Insert sizes */
INSERT INTO Sizes (SizeName)
VALUES
('XXS'),
('XS'),
('Small'),
('Medium'),
('Large'),
('XL'),
('2XL'),
('3XL'),
('4XL'),
('OSFA');

/* Insert colors */
INSERT INTO Colors (ColorName)
VALUES
('Black'),
('White'),
('Red'),
('Pink'),
('Purple'),
('Navy'),
('Gray'),
('Cream'),
('Blue'),
('Brown'),
('Maroon'),
('Gold'),
('Forest Green'),
('Orange');

/* Insert products */
INSERT INTO Products (ProductName, CategoryID)
VALUES
('T-Shirt', 1),
('Tank Top', 1),
('Long Sleeve Shirt', 1),
('Crewneck', 2),
('Hoodie', 2),
('Quarter Zip Sweater', 2),
('Fitted Hat', 3),
('Beanie', 3),
('Tote Bag', 4),
('Backpack', 4),
('Apron', 5),
('Socks', 5),
('Jeans', 6),
('Sweatpants', 6),
('Shorts', 6),
('Baby Blanket', 7);

/* Insert inventory */
INSERT INTO Inventory (QuantityOnHand, Cost, SalePrice, ProductID, SizeID, ColorID)
VALUES
(20, 12.00, 40.00, 1, 3, 1),
(18, 12.00, 40.00, 1, 4, 2),
(12, 12.00, 42.00, 1, 5, 9),
(10, 10.00, 35.00, 2, 3, 4),
(9, 10.00, 35.00, 2, 4, 5),
(8, 14.00, 48.00, 3, 4, 6),
(7, 14.00, 52.00, 3, 6, 11),
(8, 15.00, 75.00, 4, 4, 3),
(11, 15.00, 75.00, 4, 5, 7),
(7, 20.00, 85.00, 5, 5, 1),
(6, 20.00, 90.00, 5, 6, 8),
(5, 22.00, 95.00, 6, 4, 6),
(4, 22.00, 98.00, 6, 5, 12),
(14, 7.00, 46.50, 7, 10, 4),
(15, 7.00, 46.50, 7, 10, 1),
(20, 6.00, 35.00, 8, 10, 3),
(18, 6.00, 35.00, 8, 10, 13),
(25, 5.00, 30.00, 9, 10, 8),
(22, 5.00, 30.00, 9, 10, 1),
(8, 18.00, 65.00, 10, 10, 6),
(12, 9.00, 38.00, 11, 10, 1),
(30, 3.00, 18.00, 12, 4, 2),
(28, 3.00, 18.00, 12, 5, 5),
(10, 25.00, 70.00, 13, 3, 9),
(9, 25.00, 70.00, 13, 4, 9),
(12, 18.00, 60.00, 14, 5, 7),
(11, 18.00, 60.00, 14, 6, 1),
(14, 12.00, 45.00, 15, 4, 10),
(13, 12.00, 45.00, 15, 5, 8),
(10, 16.00, 55.00, 16, 10, 4),
(10, 16.00, 55.00, 16, 10, 9),
(8, 16.00, 55.00, 16, 10, 8);

/* Insert orders */
INSERT INTO Orders (OrderDate, OrderTotal, OrderStatus, CustomerID)
VALUES
('2026-04-20', 120.00, 'Pending', 1),
('2026-04-22', 75.00, 'Completed', 2),
('2026-03-02', 93.00, 'Completed', 3),
('2026-04-25', 145.00, 'Completed', 4),
('2026-04-28', 134.00, 'Pending', 5),
('2026-05-01', 95.00, 'Completed', 6),
('2026-05-03', 120.00, 'Completed', 7),
('2026-05-04', 160.00, 'Pending', 8),
('2026-05-06', 118.00, 'Completed', 9),
('2026-05-09', 139.00, 'Completed', 10);

/* Insert order details */
INSERT INTO OrderDetails (Quantity, SalePrice, OrderID, InventoryID)
VALUES
(3, 40.00, 1, 1),
(1, 75.00, 2, 8),
(2, 46.50, 3, 14),
(1, 85.00, 4, 10),
(2, 30.00, 4, 18),
(2, 40.00, 5, 2),
(3, 18.00, 5, 22),
(1, 95.00, 6, 12),
(4, 30.00, 7, 19),
(1, 90.00, 8, 11),
(2, 35.00, 8, 16),
(1, 48.00, 9, 6),
(2, 35.00, 9, 4),
(1, 65.00, 10, 20),
(1, 38.00, 10, 21),
(2, 18.00, 10, 23);
