/* 
    Embroidery Business Database
    This script creates the database and all required tables.
*/

CREATE DATABASE EmbroideryBusinessDB;
GO

USE EmbroideryBusinessDB;
GO

/* Customers table stores customer information */
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

/* Categories table stores broad product categories */
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

/* Sizes table stores product sizes */
CREATE TABLE Sizes (
    SizeID INT IDENTITY(1,1) PRIMARY KEY,
    SizeName VARCHAR(20) NOT NULL
);

/* Colors table stores product colors */
CREATE TABLE Colors (
    ColorID INT IDENTITY(1,1) PRIMARY KEY,
    ColorName VARCHAR(30) NOT NULL
);

/* Products table stores specific products sold by the business */
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);

/* Inventory table tracks product stock, cost, and sale price */
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    QuantityOnHand INT NOT NULL,
    Cost DECIMAL(10,2) NOT NULL,
    SalePrice DECIMAL(10,2) NOT NULL,
    ProductID INT NOT NULL,
    SizeID INT NOT NULL,
    ColorID INT NOT NULL,

    CONSTRAINT FK_Inventory_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID),

    CONSTRAINT FK_Inventory_Sizes
        FOREIGN KEY (SizeID)
        REFERENCES Sizes(SizeID),

    CONSTRAINT FK_Inventory_Colors
        FOREIGN KEY (ColorID)
        REFERENCES Colors(ColorID),

    /* Prevents the same product, size, and color combination from being duplicated */
    CONSTRAINT UQ_Inventory_Product_Size_Color
        UNIQUE (ProductID, SizeID, ColorID)
);

/* Orders table stores customer order information */
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    OrderTotal DECIMAL(10,2) NOT NULL,
    OrderStatus VARCHAR(30) NOT NULL,
    CustomerID INT NOT NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

/* OrderDetails table stores the individual items inside each order */
CREATE TABLE OrderDetails (
    OrderDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    Quantity INT NOT NULL,
    SalePrice DECIMAL(10,2) NOT NULL,
    OrderID INT NOT NULL,
    InventoryID INT NOT NULL,

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Inventory
        FOREIGN KEY (InventoryID)
        REFERENCES Inventory(InventoryID)
);
