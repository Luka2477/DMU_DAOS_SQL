-- Løsning opgave 4
drop table if exists ordrelinje
drop table if exists ordrer
drop table if exists vare
drop table if exists kunde 


-- opgave 4.2

create table kunde
(
kundenr int primary key,
navn char(20) not null,
adresse char(20)
)

create table ordre
(
ordrenr int primary key not null,
dato date,
betalt bit,
kundenr int foreign key references kunde
)

create table vare
(
varenr int primary key,
navn char(20) not null,
pris decimal(7,2),
antalPåLager int
)

create table ordrelinje
(
antal int check (antal>0),
ordrenr int foreign key references ordre,
varenr int foreign key references vare
)

--opg 4.3
insert into kunde values(1, 'Karsten', 'Mågevej 10')
insert into kunde values(2, 'Svenlana', 'Spovevej 15')
insert into kunde values(3, 'Pia', 'Silkeborgvej 100')

insert into vare values(100, 'XL Hot Wings',65.00, 4)
insert into vare values(101, 'Stordreng Deodorant',69.00, 100)
insert into vare values(102, 'GrandeLatte',19.00, 500)
insert into vare values(103, 'Abemad',76443, 0)

insert into ordre values(1000,'2020-10-10',1,1)
insert into ordre values(1001,'2020-10-04',1,1)
insert into ordre values(1002,'2020-10-06',0,2)

insert into ordrelinje values(4,1000,100)
insert into ordrelinje values(3,1000,101)
insert into ordrelinje values(1,1001,101)

--select * from kunde
--select * from ordre
--select * from ordrelinje
--select * from vare

--opg 4.4.1
-- Find alle datoer, hvor der har været ordrer
select dato from ordre

--opg 4.4.2
-- Find de varer, der er udsolgt
select * from vare where (antalPåLager=0)

--opg 4.4.3
-- Alle varer sorteret efter pris - dyreste først
select * from vare order by pris desc

--opg 4.4.4
-- Alle ikke-udsolgte varer sorteret efter prios - billigste først
select * from vare where (antalPåLager<>0) order by pris asc

-- OPGAVE 6

-- opg 6.1
-- Find alle varer, hvis varenavn starter med a
select *
from vare
where navn like 'a%'

-- opg 6.2
-- Find alle varer, hvor a indgår i navnet
select *
from vare
where navn like '%a%'

--opg 6.3
-- Find alle varer, der koster mellem 5 og 100 kroner
select *
from vare
where pris between 5 and 100

-- opg 6.4
-- Lav en oversigt, der viser ordrenummer, ordredato og kundens navn 
-- for alle ordrer
select o.ordrenr, o.dato, k.navn
from ordre o join kunde k on k.kundenr=o.kundenr

--opg 6.5
-- Vis navne på alle kunder, der har mindst en ordre
select distinct k.navn
from kunde k join ordre o on k.kundenr=o.kundenr

--opg 6.6
-- Vis alle ordrer der indeholder en bestemt vare identificeret med varenavn. 
-- Oversigten skal indeholde ordrenr, ordredato og det solgte antal. 
select o.ordrenr,o.dato,ol.antal
from ordre o join ordrelinje ol on o.ordrenr=ol.ordrenr
join vare v on ol.varenr = v.varenr 
where v.navn = 'XL Hot Wings'

--opg 6.7
--	Vis navne på de kunder, der har købt en bestemt vare.
select k.navn
from kunde k join ordre o on k.kundenr=o.kundenr
join ordrelinje ol on o.ordrenr=ol.ordrenr
join vare v on ol.varenr=v.varenr 
where v.navn = 'XL Hot Wings'

--opg 6.8
--	Vis en oversigt med alle varer og alle deres tilhørende ordrer.
-- Hvis en vare overhovedet ikke er blevet solgt, 
-- skal den også med i visningen med ordrenummer 0.
select v.navn, isnull(ol.ordrenr,0) as ordrenr from vare v
left join ordrelinje ol on ol.varenr=v.varenr

