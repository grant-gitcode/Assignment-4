set foreign_key_checks = 0;

drop table Products;
drop table Invoice;
drop table Customer;
drop table Person;
drop table Address;
drop table Email;
select * from Person;
alter table Person drop column emailID;
alter table Person drop column addressID;
alter table Person drop foreign key Person_ibfk_1;
alter table Person drop foreign key Person_ibfk_2;
show create table Person;
show tables;