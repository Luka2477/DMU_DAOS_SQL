use eksempeldb

-- Vi skal se et eksempel på de to slags triggere vi har 
-- Fælles for de to typer er:
-- De kan laves på insert, update og/eller delete
-- Der findes i triggeren to specielle tabeller INSERTED og DELETED
-- Ved en insert har man en INSERTED-tabel, der indeholder den/de records man er ved at indsætte. DELETED-tabellen er tom
-- Ved en delete har man en DELETED-tabel, der indeholder den/de records man er ved at slette. INSERTED-tabellen er tom
-- Ved en update har man en DELETED-tabel, der indeholder de gamle værdier for den/de records man er ved at ændre og
-- en INSERTED-tabel, der indeholder de nye værdier for den/de records man er ved at ændre




-- Først ser vi på en "normal" trigger.
-- Funktionalitet på den type trigger i SQL-Server er at operationen laves først og triggeren kaldes bagefter 
--
go
create or alter trigger mytrigger1
on person
after insert,update
as
If exists (select * from inserted where loen < 500000 and stilling = 'programmør') 
begin 
  rollback tran
  raiserror('For lav løn',16,1) 
end
go

-- Bemærk at der står after i triggerens tredje linje - det betyder, at triggeren kaldes 
-- efter inserten er lavet
-- I SQL Server er det altid AFTER
--
-- Test af trigger
insert into person values('21','Peter','systemudvikler',200000,'8000')
insert into person values('23','Karl','programmør',400000,'8210')



-- Vi kunne også lave en trigger, der i bank-databasen forbyder overtræk 
-- antager at saldo ikke allerede er talt ned
use bankdb
go
create or alter trigger mytrigger1
on postering
after insert
as
If exists (select * from inserted i join konto k on i.kontonr=k.kontonr where saldo+beloeb < 0 ) 
begin 
  rollback tran
  raiserror('Overtræk',16,1) 
end

-- Test af trigger

select * from konto
select * from postering
insert into postering values(1005,'2015.04.04',-1)



-- "Normale" trigger bruges fortrinsvis til at
--      - Sikre at data overholder visse betingelser (integritet) <-- Opgave 18.1 og 18.4
--      - Styring af redundans/denormalisering   <-- Opgave 18.2 og 18.3
--      - Oprydning i data (f.eks. slet en bankkunde, når hans sidste konto er slettet)
--	     



-- Den anden type trigger er en instead of trigger
-- Funktionalitet er at triggeren kaldes i stedet for operationen
-- Den hyppigste anvendelse er ved indkapsling via views 
--
use eksempeldb
go
 create or alter view ansættelse
 as
 select navn,firmanavn
 from person p join ansati a on p.cpr=a.cpr 
      join firma f on a.firmanr=f.firmanr
 go
 select * from ansættelse
 go
 -- vi antager navn er entydig i person og firmanavn er entydig i firma
 -- og at delete kaldes på en record ad gangen 
 create or alter trigger deltrigger
 on ansættelse
 instead of delete
 as
 declare @cpr char(10)
 declare @firmanr int
 select @cpr = cpr from person p, deleted d where p.navn=d.navn
 select @firmanr = firmanr from firma f,deleted d where f.firmanavn=d.firmanavn
 delete from ansati where cpr = @cpr and firmanr = @firmanr   
 go 
 delete from ansættelse where navn='Ib Hansen' and firmanavn = 'Kommunedata'
go

