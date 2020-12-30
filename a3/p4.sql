create or replace function p4() returns table(accountNumber char, customerName char, amountSpent NUMERIC(10,2), vendorName char) LANGUAGE 'plpgsql' AS $BODY$
declare
acc char(20);
num_trans integer;
cust_tno char(20);
cust_vno char(20);
cust_acc char(5);
temp_date char(20);
cust_date date;
cust_amount NUMERIC(10,2);
begin
return query
select t.account, c.cname, t.amount, v.vname
from
(select distinct account, MAX(t_date) as earlyDates from t
group by account) as recentData, t, c, v
where t.t_date = recentData.earlyDates and c.account = t.account and v.vno = t.vno
;

/*
open t1;
loop
fetch t1 into cust_tno, cust_vno, cust_acc, cust_date, cust_amount;
exit when not found;
	if(cust_acc = 'A1') then
		temp_date = cust_date;
		end if;
end loop;
	raise notice 'Date: %', temp_date;
close t1;*/
end; $BODY$;

select * from p4();
