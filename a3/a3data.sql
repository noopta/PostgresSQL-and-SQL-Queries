CREATE TABLE c
(Account CHAR(5), Cname CHAR(20), Province CHAR (3), Cbalance NUMERIC(10,2), Crlimit INTEGER, PRIMARY KEY (Account));

INSERT INTO c VALUES('A1', 'Smith', 'ONT', 2515.00, 2000), ('A2', 'Jones', 'BC', 2014.00, 2500), ('A3', 'Doc', 'ONT', 150.00, 1000);


CREATE TABLE v
(Vno CHAR(5), Vname CHAR(20), City CHAR(20), VBalance NUMERIC(10,2), PRIMARY KEY (Vno));

CREATE TABLE t 
(Tno CHAR(5), Vno CHAR(5), Account CHAR(5), T_date DATE, Amount NUMERIC(10,2), PRIMARY KEY (Tno));


INSERT INTO v VALUES('V1','IKEA', 'Toronto', 200.00);
INSERT INTO v VALUES('V2', 'Walmart', 'Waterloo', 671.05);
INSERT INTO v VALUES('V3', 'Esso', 'Windsor', 0.00);
INSERT INTO v VALUES('V4', 'Esso', 'Waterloo', 225.00); 

INSERT INTO t VALUES ('T1', 'V2', 'A1', '2020-07-15', 1325.00);
INSERT INTO t VALUES ('T2', 'V2', 'A3', '2019-12-16', 1900.00);
INSERT INTO t VALUES ('T3', 'V3', 'A1', '2020-09-01', 2500.00);
INSERT INTO t VALUES ('T4', 'V4', 'A2', '2020-03-20', 1613.00);
INSERT INTO t VALUES ('T5', 'V4', 'A3', '2020-07-31', 2212.00);
