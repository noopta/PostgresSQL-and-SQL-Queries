create or replace function p7() returns void as $$
declare 

c1 cursor for select account, cname, cbalance, crlimit from c;
currentBalance NUMERIC(10,2);
currentCreditLimit NUMERIC(10,2);
currentAccount char(5);
currentName char(20);
tempBalance NUMERIC(10,2);

begin
	

	open c1;
	loop
		fetch c1 into currentAccount, currentName, currentBalance, currentCreditLimit;
		exit when not found;
		tempBalance = currentBalance - ((currentBalance - currentCreditLimit) * 0.10);
		if(currentBalance > currentCreditLimit) then 
			update c set cbalance = currentBalance - ((currentBalance - currentCreditLimit) * 0.10)
			where currentAccount = account;
			raise notice '% was charged', currentName;
			raise notice 'Their new balance is $%', tempBalance;
		end if;
			
	end loop;
	close c1;

end;

$$
LANGUAGE 'plpgsql';

select * from p7();
