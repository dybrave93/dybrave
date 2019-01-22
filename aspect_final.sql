-- 1
create or replace procedure new_procedure(v_seller   in sellers.seller_id%type,
                                          v_name     in products.product_name%type,
                                          v_desc     in products.product_desc%type,
                                          v_category in categories.category_name%type) is
  v_prodID number;
  v_pID    number;
  v_cateID number;
  v_cID    number;
begin
  select max(product_id) + 1 into v_PID from products;
  insert into products values (v_PID, v_name, v_desc, v_seller);
  select product_id
    into v_prodID
    from products
   where product_name = v_name
     and seller_id = v_seller;
  select category_id
    into v_cateID
    from Categories
   where category_name = v_category;
   select max(category_id) + 1 into v_cid from categories;
  if v_cateID is null then
    insert into categories  values (v_cid,v_category);
    select category_id
      into v_cateID
      from Categories
     where category_name = v_category;
  end if;
  insert into Product_category values (v_prodID, v_cateID);
end new_procedure;
/


-- 2
create or replace procedure product_delivery(v_product_id in int,v_units in int) is
begin
  insert into Product_info(product_id,Product_Units) values(v_product_id,v_units);
end product_delivery;
/
-- 3
create or replace procedure add_newUser(v_name    in customers.customer_name%type,
                                        v_address in customers.customer_address%type,
                                        v_phone   in customers.customer_phone%type,
                                        v_email   in customers.customer_email%type) is
v_id int;                                      
begin
     select max(customer_id) + 1 into v_id from customers;
     insert into customers values(v_id,v_name,v_address,v_phone,v_email);
end add_newUser;
/

-- 4
create or replace procedure makeorder(v_customer_id in int,v_product_id in int,v_seller_id in int,v_units in int) is
v_id int;                                      
begin
     select max(order_id) + 1 into v_id from orders;
     insert into orders values(v_id,v_customer_Id,v_product_id,v_seller_id,v_units);
end makeorder;
/

-- 5
create or replace procedure shipment (v_order_id in int,v_customer_id in int,v_shipmode in int) is
v_id int; 
v_address varchar(200);                                     
begin
     select max(package_id) + 1 into v_id from packages;
     select customer_address into v_address from customers where customer_id = v_customer_id;
         insert into packages values(v_id,v_order_id,v_address,sysdate(),v_shipmode);
end shipment;
/