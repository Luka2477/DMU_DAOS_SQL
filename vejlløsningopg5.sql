use eksempeldb
-- OPGAVE 5 Vejledende løsning
--1 Find cpr på alle systemudviklere
select cpr 
from person
where stilling = 'systemudvikler'

--2 Find alle postnumre, hvor der bor personer
select distinct postnr
from person

--3 Find navne på de, der tjener mere end 400000
select navn
from person
where loen > 400000

--4 Find navn, loen og arbejdsmarkedsbidrag for alle personer
select navn, loen,loen*0.08 as 'am-bidrag'
from person

--5 Find navne på de personer, der bor i Århus C
select navn
from person p join postnummer po on p.postnr=po.postnr
where postdistrikt = 'Århus C'

--6 Find de postdistrikter, hvor der bor personer med en løn over 400000
select postdistrikt
from person p join postnummer po on p.postnr=po.postnr
where loen > 400000

--7 Find de firmaer, der bor i Risskov
select firmanavn
from firma f join postnummer po on f.postnr=po.postnr
where postdistrikt = 'Risskov'

--8 Find navne på personer og det firma, de arbejder i
select navn,firmanavn
from person p join ansati a on p.cpr=a.cpr
              join firma f on a.firmanr=f.firmanr 

--9 Find de personer, der er ansat i et firma
select navn
from person p join ansati a on p.cpr=a.cpr
           