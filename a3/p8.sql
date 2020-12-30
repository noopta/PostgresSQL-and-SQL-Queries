
create or replace function customerData() returns table(account char, cname char, province char, cbalance NUMERIC(10,2), Crlimit integer) LANGUAGE 'plpgsql' AS $BODY$
	begin
	return query
	select c.account, c.cname, c.province, c.cbalance, c.crlimit from c;
	end;
$BODY$;



create or replace function p8(vendorNum char, accountNum Char, inputAmount NUMERIC(10,2)) returns void as $$
declare 

c1 cursor for select account from c;
c2 cursor for select account from c;
c3 cursor for select account, cname, province, cbalance, crlimit from c;
v1 cursor for select vno from v;
v2 cursor for select vno from v;
v3 cursor for select vno, vname, city, vbalance from v;
t1 cursor for select tno from t;
t2 cursor for select tno, vno, account, t_date, amount from t;

currentAccountNum char(5);
currentVendorNumber char(5);
currentTransactionNumber char(5);
customerValidity integer= 0;
vendorValidity integer = 0;
transactionCount integer = 0;
tempChar char(5);
tempConvertedInt char(2);
newTransactionID char(5);
currentDate date;
tempAccountNum char(5);
tempVendorNumber char(5);
tempBalance NUMERIC(10,2);


displayVendorNum char(5);
displayVendorName char(20);
displayVendorCity char (20);
displayVendorBalance NUMERIC(10,2);

displayTransactionTno char(5);
displayTransactionVno char(5);
displayTransactionAccount char(5);
displayTransactionDate date;
displayTransactionAmount NUMERIC(10,2);

displayCustomerAccount char(5);
displayCustomerName char(20);
displayCustomerProvince char(20);
displayCustomerCBalance NUMERIC(10,2);
displayCustomerLimit NUMERIC(10,2);


begin
	
	
	open v1;
	loop
		fetch v1 into currentVendorNumber;
		exit when not found;
		if(currentVendorNumber = vendorNum) then
		customerValidity = 1;
		end if;
	end loop;
	close v1;

	open c1;
	loop
		fetch c1 into currentAccountNum;
		exit when not found;
		if(currentAccountNum = accountNum) then 
		vendorValidity = 1;
		end if;
	end loop;
	close c1;
	
	if(customerValidity = 1 and vendorValidity = 1) then
	raise notice 'The input is valid';
	newTransactionID = 'T';
		
		open t1;
		loop 
			fetch t1 into currentTransactionNumber;
			exit when not found;
			transactionCount = transactionCount + 1;
		end loop;
		close t1;
		
		transactionCount = transactionCount + 1;
		
		tempConvertedInt = transactionCount::char;
		raise notice 'There are % transactions in the transaction table', tempConvertedInt;
		newTransactionID = newTransactionID || tempConvertedInt;
		
		raise notice 'The new ID is : %', newTransactionID;
		currentDate = current_date;
		raise notice 'The date is %', currentDate;
		
		insert into t(tno, vno, account, t_date, amount)
		values(newTransactionID, vendorNum, accountNum, currentDate, inputAmount);
		
		
		open c2;
		loop
			fetch c2 into tempAccountNum;
			exit when not found;
				update c set cbalance = cbalance - inputAmount
				where tempAccountNum = account and accountNum = tempAccountNum;
		end loop;
		close c2;
		
		open v2;
		loop
			fetch v2 into tempVendorNumber;
			exit when not found;
			update v set vbalance = vbalance + inputAmount
			where tempVendorNumber = vno and vendorNum = tempVendorNumber;
		end loop;
		close v2;
	
	raise notice 'New transaction completed'; 	
	raise notice '';
	
	raise notice 'Transaction Records';
	raise notice '';
	
	open t2;
	loop
		fetch t2 into displayTransactionTno, displayTransactionVno, displayTransactionAccount, displayTransactionDate, displayTransactionAmount;
		exit when not found;
		raise notice 'Tno: % Vno: % Account: % T_date: % Amount: %', displayTransactionTno, displayTransactionVno, displayTransactionAccount, displayTransactionDate, displayTransactionAmount; 
	end loop;
	close t2;
	
	raise notice '';
	raise notice '';
	raise notice 'Customer Records';
	raise notice '';
	
	open c3;
	loop
		fetch c3 into displayCustomerAccount, displayCustomerName, displayCustomerProvince, displayCustomerCBalance, displayCustomerLimit;
		exit when not found;
		raise notice 'Account: %', displayCustomerAccount;
		raise notice 'Cname: %', displayCustomerName;
		raise notice 'Province: %', displayCustomerProvince;
		raise notice 'Cbalance: %', displayCustomerCBalance;
		raise notice 'Crlimit: %', displayCustomerLimit;
		raise notice '';

	end loop;
	close c3;
	
	raise notice '';
	raise notice 'Vendor Records';
	raise notice '';
	open v3;
	loop 
		fetch v3 into displayVendorNum, displayVendorName, displayVendorCity, displayVendorBalance;
		exit when not found;
		raise notice 'Vno: %', displayVendorNum;
		raise notice 'Vname: %', displayVendorName;
		raise notice 'City: %', displayVendorCity;
		raise notice 'Vbalance: %', displayVendorBalance;
		raise notice '';
		
	end loop;
	close v3;
	
	else 
	raise notice 'Invalid input';
	return;
	end if;

end;

$$
LANGUAGE 'plpgsql';
