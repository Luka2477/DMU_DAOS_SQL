use bankdb;

go

-- OPGAVE 20.1
create or alter trigger opg1trigger
on konto after delete
as
if not exists (select * from deleted where saldo=0) begin
	rollback tran;
	raiserror('Kontoens saldo skal være 0', 16, 1);
end

go

delete from postering where kontonr=1003;
delete from konto where kontonr=1003;
select * from konto;

go

-- OPGAVE 20.2
drop trigger if exists opg3trigger_ins;
drop trigger if exists opg3trigger_upd;
drop trigger if exists opg3trigger_del;

go

create or alter trigger opg2trigger
on postering after insert
as
update konto
set saldo=saldo+(select beloeb from inserted)
where kontonr=(select kontonr from inserted);

go

select * from konto k left join postering p on k.kontonr=p.kontonr where k.kontonr=1003;
insert into postering values (1003, '09-03-2022', 500);
select * from konto k left join postering p on k.kontonr=p.kontonr where k.kontonr=1003;

go

-- OPGAVE 20.3
drop trigger if exists opg2trigger;

go

create or alter trigger opg3trigger_ins
on postering after insert
as
update konto
set saldo=saldo+(select sum(beloeb) from inserted)
where kontonr=(select distinct kontonr from inserted);

go

create or alter trigger opg3trigger_upd
on postering after update
as
update konto
set saldo=saldo-(select sum(beloeb) from deleted)+(select sum(beloeb) from inserted)
where kontonr=(select distinct kontonr from deleted);

go

create or alter trigger opg3trigger_del
on postering after delete
as
update konto
set saldo=saldo-(select sum(beloeb) from deleted)
where kontonr=(select distinct kontonr from deleted);

go

select * from konto k left join postering p on k.kontonr=p.kontonr where k.kontonr=1003;
insert into postering values (1003, '09-03-2022', 500);
select * from konto k left join postering p on k.kontonr=p.kontonr where k.kontonr=1003;
update postering set beloeb=2000 where kontonr=1003;
select * from konto k left join postering p on k.kontonr=p.kontonr where k.kontonr=1003;
delete from postering where kontonr=1003;
select * from konto k left join postering p on k.kontonr=p.kontonr where k.kontonr=1003;

go
-- OPGAVE 20.4
create or alter trigger opg4trigger
on konto after insert
as
if (select count(*) from konto k, inserted i where k.kontoejer=i.kontoejere) > 3 begin
	rollback tran;
	raiserror('Kunde har for mange konti.', 16, 1);
end

go

select * from konto;
insert into konto values (13, '2022-03-09', 1000);
select * from konto;