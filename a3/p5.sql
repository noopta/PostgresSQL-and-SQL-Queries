create or replace function p5() returns void as $$
declare 
v1 cursor for select SUM(t.amount), v.vno from v,t WHERE v.vno = t.vno group by v.vno;
v2 cursor for select v.vno, v.vname, v.vbalance from v,t WHERE v.vno = t.vno group by v.vbalance, v.vno;
vendorNumber char(20);
vendorNum char(20);
vendorName char(20);
vendorBalance NUMERIC(10,2);
totalAmount NUMERIC(10,2);
begin
	

	open v1;
	loop
		fetch v1 into totalAmount, vendorNum;
		exit when not found;
		update v set vbalance = vbalance + totalAmount
		where vno = vendorNum;
	end loop;
	close v1;
	
	open v2;
	loop
		fetch v2 into vendorNumber, vendorName, vendorBalance;
		exit when not found;
		
		raise notice 'Vendor Number: %', vendorNumber;
		raise notice 'Vendor Name:  %', vendorName;
		raise notice 'New Vendor Balance: %', vendorBalance;
		raise notice '';
	end loop;
	close v2;

		
/*
return query
select t.vno as vendorNum, SUM(t.amount) as vnoSums
from t
group by t.vno;
*/
end;

$$
LANGUAGE 'plpgsql';

select * from p5();

