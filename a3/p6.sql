create or replace function p6() returns table(vendorName char, newbalance NUMERIC(10,2))
LANGUAGE 'plpgsql' AS $BODY$
declare 

vendorNumber char(20);
vendorName char(20);
vendorBalance NUMERIC(10,2);
v1 cursor for select vno, vname, vbalance from v;
begin
	
	open v1;
	loop 
	fetch v1 into vendorNumber, vendorName, vendorBalance;
	exit when not found;
	raise notice '% lost $%', vendorName, vendorBalance * 0.04;
	update v set vbalance = vbalance - (vendorBalance * 0.04)
	where vno = vendorNumber;
	end loop;
	close v1;
	return query
	select vname, vbalance from v;
end;
$BODY$;

select * from p6();
