use cykelplaceringer;

go

-- SELECT QUERIES --

-- Opgave 8.1
select initialer, count(*) 'deltagelser'
from placering
group by initialer
order by count(*) desc

-- Opgave 8.2
select initialer, count(*) 'deltagelser'
from placering
where plac is not null
group by initialer
order by count(*) desc

-- Opgave 8.3
select initialer, count(*) 'deltagelser', min(plac) 'bedste tid', max(plac) 'dårligste tid'
from placering
where plac is not null
group by initialer
having count(*) > 1
order by count(*) desc

-- Opgave 8.4
select aarstal, count(*)
from placering
group by aarstal
order by aarstal desc

-- Opgave 8.5
select aarstal, count(*)
from placering
where plac is not null
group by aarstal
order by aarstal desc

-- Opgave 8.6
select aarstal, count(*)
from placering
where plac is null
group by aarstal
order by aarstal desc

-- Opgave 8.7
select aarstal, min(plac)
from placering
group by aarstal
order by aarstal desc

-- Opgave 8.8
select r.initialer, count(*) 'DNF'
from rytter r
join placering p
on r.initialer=p.initialer and plac is null
group by r.initialer
having count(*) > 2
order by DNF desc

-- Opgave 8.9
select vm.land, count(*) 'antal'
from vm
group by vm.land
order by antal desc