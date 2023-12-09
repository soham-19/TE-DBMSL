create table Borrower(
    RollNo int primary key,
    Name varchar(50),
    Book varchar(50),
    Date_Of_Issue date,
    Status char(1) default 'I'
);

insert into Borrower values (1, 'Alice','DBMS',date '2023-10-11', 'I');
insert into Borrower values (2, 'Bob','TOC',date '2023-11-11', 'I');
insert into Borrower values (3, 'Charlie','SPOS',date '2023-10-21', 'I');
insert into Borrower values (4, 'Dan','CNS',date '2023-10-30', 'I');
insert into Borrower values (5, 'Ethan', 'IOT', date '2023-10-01', 'I');
insert into Borrower values (6, 'Farhan','WT',date '2023-02-11', 'I');
insert into Borrower values (7, 'Gaurav','HCI',date '2023-11-18', 'I');
insert into Borrower values (8, 'Helen','DAA',date '2023-11-12', 'I');
insert into Borrower values (9, 'Ila','SE',date '2023-10-11', 'I');
insert into Borrower values (10, 'Janhavi','DSA',date '2023-08-10', 'I');
insert into Borrower (RollNo, Name) values (11, 'Kiara');

create table Fine(
    RollNo int,
    Date_Of_Return date,
    Fine number,
    foreign key(RollNo) references Borrower(RollNo)
	negative EXCEPTION;
);

declare 
	v_roll int;
	v_fine number;
	days int;
	v_issue date;
begin

	for v_roll in 1..11 loop
    	select Date_Of_Issue into v_issue from Borrower where RollNo = v_roll;

		days := to_date(sysdate) - to_date(v_issue);

		if days < 0 then
            raise negative;
		end if;

		v_fine := 0;
		if days > 30 then
            v_fine := days*50;
		elsif days between 15 and 30 then
            v_fine := days*5;
		end if;

		if v_fine > 0 then
            update Borrower set Status = 'R' where RollNo = v_roll;
			insert into Fine values (v_roll, sysdate, v_fine);
			dbms_output.put_line('Roll ' || v_roll || ' Days ' || days || ' Fine ' || v_fine);
		end if;		
	end loop;
exception
    when negative then
    	dbms_output.put_line('Issue date must be less than or equal to sysdate');
end;

select * from Borrower;
select * from Fine;