use bankdb;
go
drop table if exists postering
drop table if exists konto
drop table if exists bankkunde
go
create table bankkunde
(
cpr char(10) primary key,
navn varchar(30) not null
)
create table konto
(
kontonr int identity(1001,1) primary key,
kontoejer char(10) foreign key references bankkunde not null, 
oprettet date not null,
saldo decimal(14,2) not null
)
create table postering
(
posteringsnr int identity primary key,
kontonr int foreign key references konto not null, 
dato date not null,
beloeb decimal(14,2) not null -- positivt beloeb = indsættelse, negativt = hævning
)

insert into bankkunde values('12','Ib Hansen')
insert into bankkunde values('13','Søren Hansen')
insert into bankkunde values('14','Bo Jensen')
insert into bankkunde values('15','Per Sørensen')
insert into konto values('12','1998.05.01',-200)
insert into konto values('12','2011.08.09',27500)
insert into konto values('13','2015.04.04',90000)
insert into konto values('13','2014.01.28',1400)
insert into konto values('14','2012.01.01',-500)
insert into konto values('14','2022.02.22',0)
insert into postering values(1001,'1999.03.23',400)
insert into postering values(1001,'2001.03.23',-600)
insert into postering values(1002,'2017.03.23',2500)
insert into postering values(1002,'2022.02.23',25000)
insert into postering values(1003,'2015.04.04',40000)
insert into postering values(1003,'2015.09.23',50000)
insert into postering values(1004,'2014.09.09',1400)
insert into postering values(1005,'2012.01.09',500)
insert into postering values(1005,'2017.12.09',-500)
insert into postering values(1005,'2022.01.09',-500)

