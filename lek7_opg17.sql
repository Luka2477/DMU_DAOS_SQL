use exampledb

go
-- OPGAVE 17.1
drop view if exists altdata;

go

create view altdata as
select p.navn, p.stilling, pn.postdistrikt, ISNULL(f.firmanavn, 'ukendt') firmanavn
from person p
left join postnummer pn on p.postnr=pn.postnr
left join ansati a on p.cpr=a.cpr
left join firma f on a.firmanr=f.firmanr;

go

select * from altdata;

go
-- OPGAVE 17.2
select navn, postdistrikt, firmanavn
from altdata
where stilling='programmoer';

go
-- OPGAVE 17.3
drop view if exists altdata2;

go

create view altdata2 as
select p.navn, p.stilling, pn.postdistrikt, f.firmanavn, pf.postdistrikt firmapostdistrikt
from person p
left join postnummer pn on p.postnr=pn.postnr
join ansati a on p.cpr=a.cpr
left join firma f on a.firmanr=f.firmanr
left join postnummer pf on f.postnr=pf.postnr;

go

select * from altdata2;
select firmanavn, postdistrikt from postnummer, firma
where postnummer.postnr=firma.postnr;
