use bankdb;

go
-- OPGAVE 18.1
create or alter proc opg1 as
select bk.navn, k.kontonr, k.saldo
from bankkunde bk, konto k
where k.kontoejer=bk.cpr;

go

exec opg1;

go
-- OPGAVE 18.2
create or alter proc opg2 as
select bk.cpr, bk.navn, k.kontonr, k.saldo
from bankkunde bk, konto k
where k.kontoejer=bk.cpr;

go

exec opg2;

go
-- OPGAVE 18.3
create or alter proc opg3
@cpr char(10)
as
select sum(saldo) kontiudtog
from konto
where kontoejer=@cpr;

go

exec opg3 '12';

go
-- OPGAVE 18.4
create or alter proc opg4
(@cpr char(10), @udtog int output)
as
select @udtog=sum(saldo)
from konto
where kontoejer=@cpr;

go

declare @udtog int;
exec opg4 '12', @udtog output;
select @udtog;

go
-- OPGAVE 18.5
