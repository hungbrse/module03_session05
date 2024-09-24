create database session05_ex01;
use session05_ex01;


create table customer(
id int auto_increment primary key,
name varchar(255),
cAge tinyint
);

insert into customer(name,cAge) values('minh quan', 10);
insert into customer(name,cAge) values('ngoc oanh', 20);
insert into customer(name,cAge) values('hong ha', 50);


create table oder(
oId int auto_increment primary key,
cId int, foreign key(cId) references customer(id),
oDate datetime,
oTotalPrice int
);

INSERT INTO oder(cId, oDate, oTotalPrice) VALUES (1, '2006-03-21', 150000);
INSERT INTO oder(cId, oDate, oTotalPrice) VALUES (2, '2006-03-23', 200000);
INSERT INTO oder(cId, oDate, oTotalPrice) VALUES (1, '2006-03-16', 170000);

create table product(
pId int auto_increment primary key,
pName varchar(25),
pPrice int
);

insert into product(pname,pPrice) values ('may giat',300);
insert into product(pname,pPrice) values ('tu lanh',500);
insert into product(pname,pPrice) values ('dieu hoa',700);
insert into product(pname,pPrice) values ('quat',100);
insert into product(pname,pPrice) values ('bep dien',200);
insert into product(pname,pPrice) values ('may hut bui ',500);


create table orderDetail(
oId int, foreign key(oId) references oder(oId),
pId int,foreign key(pId) references product(pId),
odQTY int 
);

insert into orderDetail(oId,pId,odQTY) values(1,1,3);
insert into orderDetail(oId,pId,odQTY) values(1,3,7);
insert into orderDetail(oId,pId,odQTY) values(1,4,2);
insert into orderDetail(oId,pId,odQTY) values(2,1,1);
insert into orderDetail(oId,pId,odQTY) values(3,1,8);
insert into orderDetail(oId,pId,odQTY) values(2,5,4);
insert into orderDetail(oId,pId,odQTY) values(2,3,3);

create view show_customer as select * from customer;

select * from show_customer;

create view show_order as select * from oder where oTotalPrice > 150000 ;
select * from show_order;

create index index_pName on product(pname) ;

DELIMITER //

CREATE PROCEDURE ShowMinTotalOrder()
BEGIN
    SELECT * 
    FROM oder
    WHERE oTotalPrice = (
        SELECT MIN(oTotalPrice) 
        FROM oder
    );
END //

DELIMITER ;

CALL ShowMinTotalOrder();

DELIMITER //

CREATE PROCEDURE ShowMinBuyerForMayGiat()
BEGIN
    SELECT c.name AS customer_name, MIN(od.odQTY) AS min_quantity
    FROM customer c
    JOIN oder o ON c.id = o.cId
    JOIN orderDetail od ON o.oId = od.oId
    JOIN product p ON od.pId = p.pId
    WHERE p.pName = 'may giat'
    GROUP BY c.name
    ORDER BY min_quantity
    LIMIT 1;
END //

DELIMITER ;

CALL ShowMinBuyerForMayGiat();

