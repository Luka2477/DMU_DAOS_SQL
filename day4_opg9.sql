use exampledb;

go

-- SELECT QUERIES --

-- Opgave 9.1
select avg(person.loen) 'gennemsnitsløn'
from person

-- Opgave 9.2
select person.postnr, avg(person.loen) 'gennemsnitsløn'
from person
group by person.postnr
order by person.postnr

-- Opgave 9.3
select p.stilling, count(*)
from person p
group by stilling

-- Opgave 9.4
select p.stilling, count(*) 'antal', avg(p.loen) 'gennemsnitsløn'
from person p
group by stilling

-- Opgave 9.5
select f.firmanavn, count(*) 'ansatte'
from firma f
join ansati a
on f.firmanr=a.firmanr
group by f.firmanavn
having count(*) > 1

-- Opgave 9.6
select f.firmanavn, count(*) 'ansatte'
from firma f
join ansati a
on f.firmanr=a.firmanr
group by f.firmanavn
having count(*) = 2

-- Opgave 9.7
select f.postnr, count(*) 'antal'
from firma f
group by f.postnr

-- Opgave 9.8
select p.stilling, count(*) 'antal'
from person p
group by p.stilling
having count(*) > 1

-- Opgave 9.9
select p.navn, p.postnr 'person postnr', f.postnr 'firma postnr'
from person p
join ansati a
on a.cpr=p.cpr
join firma f
on a.firmanr=f.firmanr
where p.postnr=f.postnr

-- Opgave 9.10
select p.navn, po.postdistrikt
from person p
join postnummer po
on p.postnr=po.postnr
where p.navn like '%a%' or po.postdistrikt like '%a%'

-- Opgave 9.11
select p.navn
from person p
where p.cpr not in (select a.cpr from ansati a)