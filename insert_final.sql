insert into Sellers values(1,'Seller 1','Seller Address 1','1213112341');
insert into Sellers values(2,'Seller 2','Seller Address 2','234102913');
insert into Sellers values(3,'Seller 3','Seller Address 3','299000032');

insert into categories values(1,'Computer');
insert into categories values(2,'Electronics');
insert into categories values(3,'Appliances');

insert into products values(1,'Product 1','Product description 1',1);
insert into products values(2,'Product 2','Product description 2',2);
insert into products values(3,'Product 3','Product description 3',3);

insert into product_category values(1,1);
insert into product_category values(2,2);
insert into product_category values(3,3);

insert into product_info values(1,10,'new',10.2);
insert into product_info values(2,20,'used',12);
insert into product_info values(3,30,'new',1.2);

insert into customers values(1,'Customer 1','Customer Address 1','345133412','customer1@gmail.com');
insert into customers values(2,'Customer 2','Customer Address 2','345133413','customer2@gmail.com');
insert into customers values(3,'Customer 3','Customer Address 3','345133414','customer3@gmail.com');

insert into shipmode values(1,'super saver shipping');
insert into shipmode values(2,'standard shipping');
insert into shipmode values(3,'two-day');
insert into shipmode values(4,'one-day');

insert into orders values(1,1,1,1,2);
insert into orders values(2,2,2,2,4);
insert into orders values(3,3,3,3,6);

insert into packages values(1,1,'Customer Address 1',to_date('2018-01-11','YYYY-MM-DD'),1);
insert into packages values(2,2,'Customer Address 2',to_date('2018-02-11','YYYY-MM-DD'),2);
insert into packages values(3,3,'Customer Address 3',to_date('2018-03-11','YYYY-MM-DD'),3);
commit;
