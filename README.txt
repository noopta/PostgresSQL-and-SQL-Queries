The following files are all SQL annd Postgres SQL queries I have made for various projects. "a3data.sql" Creates a table "v" for vendor, "c" for customer and 
"t" for transactions. Once "a3data.sql" is ran, the tables are also populated with data. The various programs perform different tasks on the tables. 

Instructions for executing programs:

For reference, "$" refers to the command line prompt.

Loading Data:
$ \i a3data.sql

Program 1 :
$ \i p1.sql

To then enter user input and execute program enter: $ select * from p1('exampleName');

Program 2:
$ \i p2.sql

To then enter user input and execute program enter: $ select * from p2('exampleVendor');

Program 3:
$ \i p3.sql

To then enter user input and execute program enter: $ select * from p3('A5', 'exampleName', 'ONT', 2000);
e.g. $ select * from p3('A5', 'Anupta', 'ONT', 2000);

Program 4:
$ \i p4.sql

I called the command "$ select * from p4()" from inside the function for convenience purposes, it saved time instead of having to type it out over and over again.

Program 5:
$ \i p5.sql

With program 5 I also entered the command inside the program, so results will display automatically.

Program 6:
$ \i p6.sql

Again, I entered the command to call the function inside the program file. Results will display automatically.

Program 7:
$ \i p7.sql

The command to call the function is also inside of program sevens file. Results will display automatically.

Program 8:
$ \i p8.sql
$ select * from p8('V1', 'A1', 200);
