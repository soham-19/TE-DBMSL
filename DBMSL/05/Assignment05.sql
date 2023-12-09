create table Areas(
    radius int,
    area number
);

declare 
    pi constant number := 3.14159;
    r int;
	a number;
	v_r int;

begin
	for r in 5..9 loop
		a := pi * r * r;
		if r= 8 then
            a := null;
		end if;

		if a is null then
            v_r := r;
            RAISE_APPLICATION_ERROR(-20001, 'Area cannot be NULL.');
		end if;

		insert into Areas values (r,a);
	end loop;
	
exception
    when others then
    	dbms_output.put_line('R : ' || v_r || '  ' || sqlerrm);
end;

select * from Areas;		