create table Library(
    book_id int primary key,
    title varchar(50),
    author varchar(50)
);

create table Library_Audit (
    audit_id int primary key,
    action_type varchar(50),
    book_id int,
    title varchar(50),
    author varchar(50)
);


insert into Library values(1,'Book 1', 'Author 1');
insert into Library values(2,'Book 2', 'Author 2');
insert into Library values(3,'Book 3', 'Author 3');

commit;

create sequence Library_Audit_seq
    start with 1
    increment by 1

create or replace trigger library_audit_trigger
before delete or update on Library
for each row
declare
	action_type varchar(50);
begin
	if deleting then
		action_type := 'DELETE';
	elsif updating then
		action_type := 'UPDATE';
	end if;

	insert into Library_Audit values (
        Library_Audit_seq.NEXTVAL,
        action_type,
        :OLD.book_id,
        :OLD.title,
        :OLD.author
    );
end;
select * from Library;
select * from Library_Audit;

delete from Library where author = 'Author 3';

select * from Library_Audit;

update Library 
set title = 'Book 1 - Edition 1'
where author = 'Author 1';

select * from Library_Audit;