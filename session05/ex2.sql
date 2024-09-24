create database session05_ex02;
use session05_ex02;


create table account(
id int auto_increment primary key,
userName varchar(100),
password varchar(255),
address varchar(255),
status bit
);


create table bill(
id int auto_increment primary key,
bill_type bit,
acc_id int, foreign key(acc_id) references account(id),
created datetime,
auth_date datetime
);

create table product(
id int auto_increment primary key,
name varchar(100),
created date,
price double ,
stock int,
status bit
);

create table bill_detail(
id int auto_increment primary key,
bill_id int ,foreign key(bill_id) references bill (id),
product_id int , foreign key(product_id) references product (id),
quantity int,
price double
);

insert into account(userName,password,address,status) values('hung',123456,'nghe an',1);
insert into account(userName,password,address,status) values('cuong',654321,'ha noi',1);
insert into account(userName,password,address,status) values('bach',135790,'ha noi',1);

insert into bill(bill_type,acc_id,created,auth_date) values(0,1,'2022-02-11','2022-03-12');
insert into bill(bill_type,acc_id,created,auth_date) values(0,1,'2023-10-05','2023-10-10');
insert into bill(bill_type,acc_id,created,auth_date) values(0,1,'2024-05-15','2024-05-20');
insert into bill(bill_type,acc_id,created,auth_date) values(1,3,'2024-05-15','2024-05-20');


insert into product(name,created,price,stock,status) values('quan dai','2022-03-12',1200,5,1);
insert into product(name,created,price,stock,status) values('ao dai','2022-03-15',1500,8,1);
insert into product(name,created,price,stock,status) values('mu coi','1999-03-08',1600,10,1);
insert into product(name,created,price,stock,status) values('mu coi2','1999-03-08',1600,10,1);

insert into bill_detail(bill_id,product_id,quantity,price) values(1,1,3,1200);
insert into bill_detail(bill_id,product_id,quantity,price) values(1,2,4,1500);
insert into bill_detail(bill_id,product_id,quantity,price) values(2,1,1,1200);
insert into bill_detail(bill_id,product_id,quantity,price) values(3,2,4,1500);
insert into bill_detail(bill_id,product_id,quantity,price) values(4,2,7,1600);


DELIMITER //
create procedure GetAccountsWithFiveOrMoreBills()
begin
select account.* from account join bill on account.id = bill.acc_id group by account.id having count(bill.acc_id) >= 5;
end //
DELIMITER ;

call GetAccountsWithFiveOrMoreBills();


DELIMITER //
create procedure Getproduct()
begin
  SELECT product.* 
    FROM product 
    LEFT JOIN bill_detail ON product.id = bill_detail.product_id 
    WHERE bill_detail.product_id IS NULL;
    end //
DELIMITER ;
call Getproduct();

DELIMITER //
create procedure getTop2BestSelling()
begin
select product.* , sum(bill_detail.quantity) as da_ban from product join bill_detail on product.id = bill_detail.product_id group by product_id  limit 2;
end //
DELIMITER ;

call getTop2BestSelling();

DELIMITER //
create procedure addCount(
in input_name varchar(100),
in input_password varchar(255),
in input_address varchar(255),
in input_status BIT
)
begin
insert into account(userName,password,address,status) values(input_name,input_password,input_address,input_status);
end //
DELIMITER ;

CALL addCount('new_user', 'password123', 'some_address', 1);



DELIMITER //
create procedure show_bill_id(in id int)
begin
select * from bill_detail where bill_detail.bill_id =  id;
end //
DELIMITER ;
call show_bill_id(3);

select product.* , sum(bill_detail.quantity) as sold from product join bill_detail on product.id = bill_detail.product_id group by product.id having sold > 5 ;

