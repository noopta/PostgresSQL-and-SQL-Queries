create or replace function p1(theChar Char)
returns table
(vendorName char, vendorDar date, amountSpent NUMERIC)
LANGUAGE 'plpgsql'
AS $BODY$
begin
return query 
select v.vname, tSpending.theDate, tSpending.spendingAmount from (select t.vno as theVno, t.t_date as theDate, t.amount as spendingAmount from (select c.account as accDigits from c where cname = theChar) as smithInfo, t where smithInfo.accDigits = t.account) as tSpending, v where v.vno = tSpending.theVno; end; $BODY$
