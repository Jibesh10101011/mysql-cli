create database testData;
use testData;

create table Customer (
    id int primary key,
    name varchar(200),
    address varchar(200),
    city varchar(200)
)

create table Orders (
    id int primary key,
    title varchar(200),
    cust_id int,
    foreign key (cust_id) references Customer(id)
);


insert into Customer 
(id,name,address,city)
values 
(1,"Jibesh","Jalpaiguri","India"),
(2,"Srinjan","Jalpaiguri","India"),
(3,"Anurag","Durgapur","India"),
(4,"Kaustav","Durgapur","India"),
(5,"Suman","Gederar Dighi","India");



insert into Orders 
(id,title,cust_id)
values
(1,"Chocolate",1),
(2,"Football",2),
(3,"Eating",3);
(4,"Teaching",8),
(5,"Goding",9),
(6,"Running",10);

select * from Customer;
select * from Orders;


-- Perform JOIN Operation 

-- Inner JOIN 

select C.*,O.* from Customer as C Inner JOIN Orders as O on C.id = O.cust_id;

-- Outer JOIN

-- Left JOIN

select C.*,O.* from Customer as C Left JOIN Orders as O on C.id = O.cust_id;

-- Right JOIN

select C.*,O.* from Customer as C Right JOIN Orders as O on C.id = O.cust_id;

-- Full JOIN 

select C.*,O.* from Customer as C Left JOIN Orders as O on C.id = O.cust_id
UNION 
select C.*,O.* from Customer as C Right JOIN Orders as O on C.id = O.cust_id;


-- Self JOIN 

select e1.*,e2.* from Customer as e1 Inner JOIN Customer as e2 on e1.id=e2.id;

select * from Customer,Orders where Orders.cust_id = Customer.id;