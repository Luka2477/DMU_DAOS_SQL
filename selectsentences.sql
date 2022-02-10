use exampledb;

go

-- SELECT SENTENCES --

select cpr from person where stilling='systemudvikler';

select distinct postnr from person;

select navn from person where loen>400000;

select navn, loen, loen*0.08 as arbejdsmarkedsbidrag from person;

select navn from person where postnr=(select postnr from postnummer where postdistrikt='Aarhus C');

select postdistrikt from postnummer where postnr in (select postnr from person where loen>400000);

select * from firma where postnr=(select postnr from postnummer where postdistrikt='Risskov');

select person.navn, firma.firmanavn from ansati
join person on ansati.cpr=person.cpr
join firma on ansati.firmanr=firma.firmanr;

select person.navn from ansati
join person on (ansati.cpr=person.cpr);