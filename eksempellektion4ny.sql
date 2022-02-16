use eksempeldb
-- 
insert into person values('1717171717','Hans Poulsen',null,300000,'8210')
insert into person values('1818181818',null,null,320000,'8220')
--
-- join med ny syntaks
select * 
from firma f join postnummer po
on f.postnr=po.postnr

-- det samme med gammel syntaks
select * 
from firma f, postnummer po
where f.postnr=po.postnr

-- eksempel p� en st�rre join

select * 
from person p join postnummer po on p.postnr=po.postnr
              join ansati a on p.cpr=a.cpr
			  join firma f on a.firmanr=f.firmanr
			  join postnummer po2 on po2.postnr=f.postnr 

-- langt, langt de fleste joins er mellem en prim�r n�gle og en fremmedn�gle
-- men der kan ogs� findes andre eksempler p� joins  


-- AGGREGATES
-- COUNT, MIN, MAX p� alle datatyper
-- SUM og AVG kun taltyper

-- count 
-- t�ller antal records i person
select count(*) from person

-- t�ller antal records, hvor stilling ikke er null
select count(stilling) from person

-- t�ller antal forskellige v�rdier, som stilling antager
select count(distinct stilling) from person
--
-- aggregates brugt i en almindelig SQL (uden group by)
select min(loen),max(loen)
from person 
where stilling = 'systemudvikler'

-- returnerer en linie
select min(loen),max(loen)
from person 
where stilling = 'programm�r'
--
-- hvis jeg nu gerne ville have ovenst�ende for alle stillinger
-- uden at skulle n�vne hver enkelt
--
-- aggregates brugt med group by
select stilling,min(loen),max(loen)
from person 
group by stilling
-- returnerer en linie per v�rdi stilling har

-- GROUP BY
select stilling,avg(loen*1.0)
from person
group by stilling

-- I vores person-tabel ville man typisk groupe p� postnr eller stilling 

--
-- N�r man bruger group by m� man i SELECT kun skrive de attributter,
-- der findes i group by'en og aggregates
--

-- group by kan udvides med having
select stilling,avg(loen)
from person
group by stilling
having count(*) > 1
--
select stilling,avg(loen)
from person
where postnr ='8000'
group by stilling
having count(*) > 1
