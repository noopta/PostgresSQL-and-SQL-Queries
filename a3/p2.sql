create or replace function p2(vendorName Char)
Returns table
(cNums char, customerNames char, theProvince char)
LANGUAGE 'plpgsql'
AS $BODY$
begin 
return query
Select c.account, c.cname, c.province from (select t.account as accountNums from (select v.vno as vendorNum from v where vendorName = v.vname) as venderInfo, t where t.vno = venderInfo.vendorNum) as refinedAccountInfo, c where c.account = refinedAccountInfo.accountNums;end; $BODY$; 
