create database session05_ex03;
use session05_ex03;


create table class(
classId int auto_increment primary key,
className varchar(100),
startDate varchar(255),
status bit
);

create table student(
studentId int auto_increment primary key,
studentName varchar(100),
address varchar(255),
phone varchar(11),
class_id int,
status bit
);

ALTER TABLE student
MODIFY class_id int,
ADD CONSTRAINT class_id
FOREIGN KEY (class_id) REFERENCES class(classId);

create table subject(
subject_id int auto_increment primary key,
subjectName varchar(100),
credit int,
status bit
);

create table mark(
markId int auto_increment primary key,
student_id int, foreign key(student_id) references student(studentId),
subject_id int,foreign key(subject_id) references subject(subject_id),
mark double,
examTime datetime
);


insert into class(className,startDate,status) values('HN-JV231103','03/11/2023',1);
insert into class(className,startDate,status) values('HN-JV2312293','29/12/2023',1);
insert into class(className,startDate,status) values('HN-JV230615','15/06/2023',1);



insert into student(studentName,address,phone,class_id , status) values('ho da hung', 'ha Noi' ,'0987554321','1',1);
insert into student(studentName,address,phone,class_id , status) values('phan van giang', 'da nang' ,'0987554321','1',1);
insert into student(studentName,address,phone,class_id , status) values('duong my huyen', 'ha Noi' ,'0987554321','2',1);

insert into subject(subjectName,credit,status) values('toan', '3' ,1);
insert into subject(subjectName,credit,status) values('van', '3' ,1);
insert into subject(subjectName,credit,status) values('anh', '2' ,1);
insert into subject(subjectName,credit,status) values('ly', '2' ,1);

insert into mark(student_id,subject_id,mark,examTime) values('1','1', 7,'2024-05-12');
insert into mark(student_id,subject_id,mark,examTime) values('1','1', 7,'2024-03-15');
insert into mark(student_id,subject_id,mark,examTime) values('1','1', 7,'2024-05-12');
insert into mark(student_id,subject_id,mark,examTime) values('2','3', 9,'2024-05-12');
insert into mark(student_id,subject_id,mark,examTime) values('3','3', 10,'2024-11-02');


DELIMITER //
create procedure getStudentQuantity()
begin
select class.* , count(student.class_id) as quantity from class join student on class.classId = student.class_id  group by class.classId having quantity > 5 ;
end //
DELIMITER ;


call getStudentQuantity();

DELIMITER //
create procedure getMark10()
begin
select subject.* , mark.mark from subject join mark on subject.subject_id = mark.subject_id where mark.mark = 10;
end //
DELIMITER ;

call getMark10();

DELIMITER //
create procedure getClassMark10()
begin
select class.* , student.studentName , mark.mark from class join student on class.classId = student.class_id join mark on student.studentId = mark.student_id  where mark. mark = 10;
end //
DELIMITER ;

call getClassMark10()

DELIMITER //
create procedure addStudentAndShow(
in ip_studentName  varchar(100),
in ip_address  varchar(255),
in ip_phone varchar(11),
in ip_class_id int,
in ip_status BIT)
begin
insert into student(studentName,address,phone,class_id , status) values(ip_studentName, ip_address,ip_phone,ip_class_id,ip_status);
select * from student where studentName  =  ip_studentName;
end //
DELIMITER :
DROP PROCEDURE addStudentAndShow;
call addStudentAndShow('hungd2z','tientrong','0974356313',3,1)

select subject.* from subject left join mark on subject.subject_id = mark.subject_id where mark.subject_id is null;