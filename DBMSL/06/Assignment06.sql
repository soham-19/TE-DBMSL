create table Marks(
    RollNo int primary key,
    Name varchar(50),
    marks int
);

insert into Marks VALUES(1,'A',98);
insert into Marks VALUES(2,'B',78);
insert into Marks VALUES(3,'C',68);
insert into Marks VALUES(4,'D',48);
insert into Marks VALUES(5,'E',38);
insert into Marks VALUES(6,'F',96);
insert into Marks VALUES(7,'G',67);
insert into Marks VALUES(8,'H',56);
insert into Marks VALUES(9,'I',89);
insert into Marks VALUES(10,'J',34);

update Marks set marks = -90 where RollNo = 10;

create table Result(
    RollNo int,
    Class varchar(100),
    foreign key(RollNo) references Marks(RollNo)
);

create or replace procedure categorization(
    p_roll in int,
    p_marks in int
) as
	v_class varchar(50);
	negativeMarks EXCEPTION;
	begin
        if p_marks < 0 then
        	raise negativeMarks;
		end if;

		if p_marks > 90 and p_marks <= 100 then
			v_class := 'O';
		elsif p_marks > 80 and p_marks <= 90 then
			v_class := 'A';
		elsif p_marks > 70 and p_marks <= 80 then
			v_class := 'B';
		elsif p_marks > 60 and p_marks <= 70 then
			v_class := 'C';
		elsif p_marks > 50 and p_marks <= 60 then
			v_class := 'D';
		else 
			v_class := 'F';
		end if;

		insert into Result values(p_roll, v_class);
		commit;
	exception
        when negativeMarks then 
        	dbms_output.put_line('Err: Marks can not be negative');
	end categorization;

DECLARE
	v_roll int;
	v_marks int;
begin
	for v_roll in 1..10 loop
		select marks into v_marks from Marks where RollNo = v_roll;
		categorization(v_roll, v_marks);
	end loop;
end;
delete from Result;
select M.*, R.Class
from Marks M, Result R
where M.RollNo = R.RollNo;