use cykelplaceringer;

-- SELECTS --
select initialer, aarstal, plac from placering;

select p.initialer, aarstal, plac, rytternavn from placering p
join rytter r on p.initialer=r.initialer;

select p.initialer, p.aarstal, plac, rytternavn, bynavn, land from placering p
join rytter r on p.initialer=r.initialer
join vm on p.aarstal=vm.aarstal;

select rytternavn, plac, aarstal from placering p
join rytter r on p.initialer=r.initialer
order by plac, aarstal;

select distinct rytternavn from rytter r
join placering p on r.initialer=p.initialer and plac is not null;

select distinct rytternavn from rytter r
join placering p on r.initialer=p.initialer and plac is null
join vm on p.aarstal=vm.aarstal and land='Italien';

select distinct rytternavn from rytter r
join placering p on r.initialer=p.initialer and (plac between 1 and 3);

select max(plac) 'plac' from placering;

select count(*) from placering;

-- Kan gøres på beggge måder --
select count(*)-count(plac) from placering;
select count(isnull(plac, 0)) from placering where plac is null;

select 100*count(plac)/count(*) 'fuldførelsesprocenten' from placering;