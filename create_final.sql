CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(200),
    seller_address VARCHAR(200),
    seller_phone VARCHAR(11)
);
    
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(30)
);
    
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(200),
    product_desc VARCHAR(2000),
    seller_id int ,
    foreign key (seller_id) references Sellers(Seller_id),
    unique(product_id,seller_id)
);


CREATE TABLE Product_category (
    category_id INT ,
    product_id INT,
    PRIMARY KEY (category_id , product_id),
    FOREIGN KEY (product_id)
        REFERENCES Products (product_id),
    FOREIGN KEY (category_id)
        REFERENCES Categories (category_id)
);

-- Product Delivery Use Case
CREATE TABLE Product_info (
    Product_ID INT PRIMARY KEY,
    Product_units INT,
    Product_condition VARCHAR(20),
	product_price numeric(7,2),
    FOREIGN KEY (product_id)
        REFERENCES Products (product_id)
);

-- New Customer Use Case
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY ,
    customer_name VARCHAR(30),
    customer_address VARCHAR(200) UNIQUE, 
    customer_phone VARCHAR(11),
    customer_email VARCHAR(30)
);
  
  
-- Product Purchase Use Case
CREATE TABLE Shipmode (
    ship_id INT PRIMARY KEY,
    ship_speed VARCHAR(30)
    );

CREATE TABLE Orders (
    order_id INT PRIMARY KEY  ,
    customer_id INT,
    product_id INT,
    seller_id INT,
    units INT,
    FOREIGN KEY (customer_id)
        REFERENCES Customers (customer_id),
    FOREIGN KEY (product_id,seller_id)
        REFERENCES Products (product_id,seller_id)
);
    
CREATE TABLE Packages(
	package_id INT PRIMARY KEY ,
    order_id int,
    ship_address varchar(200),
    ship_time date,
    ship_mode int,
	FOREIGN KEY (order_id)
		REFERENCES ORDERS (order_id),
    FOREIGN KEY (ship_mode)
        REFERENCES Shipmode (ship_id),
	FOREIGN KEY (ship_address)
		REFERENCES CUSTOMERS (customer_address)
    );

create index cus_phone_index on customers(customer_id, customer_address, customer_email);