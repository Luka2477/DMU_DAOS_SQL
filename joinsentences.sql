use kundeordre;

-- SELECTS --
select * from vare where varenavn like 'a%';
select * from vare where varenavn like '%a%';
select * from vare where pris between 5 and 100;
select ordrenummer, dato, navn from ordre as o join kunder as k on o.kundenr=k.kundenr;
select distinct navn from ordre o join kunder k on o.kundenr=k.kundenr;

select ol.ordrenummer, dato, antal from ordrelinjer ol
join vare v on v.varenavn='Musli'
join ordre o on o.ordrenummer=ol.ordrenummer;

select navn from kunder k
join ordre o on k.kundenr=o.kundenr
join vare v on v.varenavn='Musli';

select varenavn, isnull(ordrenummer, 0) 'ordrenummer' from vare v
left join ordrelinjer ol on v.varenummer=ol.ordrenummer;