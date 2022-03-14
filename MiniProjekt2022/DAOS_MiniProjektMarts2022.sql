use daos_mini_proj;

-- DROP TABLES =============================================================================================================

drop table if exists forsoeg;
drop table if exists eksamener;
drop table if exists studerende;
drop table if exists uddannelser;

go

-- CREATE TABLES ===========================================================================================================

create table uddannelser
(
	kode char(10) primary key,
	navn varchar(25) not null,
);

create table studerende
(
	userid char(8) primary key,
	fornavn varchar(25) not null,
	mellemnavn varchar(25),
	efternavn varchar(25) not null,
	uddannelseskode char(10),

	constraint studerende_uddannelseskode_foreign foreign key(uddannelseskode) references uddannelser
);

create table eksamener
(
	kode char(10) primary key,
	navn varchar(25) not null,
	uddannelseskode char(10),

	constraint eksamener_uddannelseskode_foreign foreign key(uddannelseskode) references uddannelser
);

create table forsoeg
(
	id int identity primary key,
	karakter smallint not null,
	kode char(2),
	termin char(5) not null,
	userid char(8),
	eksamenskode char(10),

	constraint userid_foreign foreign key(userid) references studerende,
	constraint eksamensid_foreign foreign key(eksamenskode) references eksamener,
	constraint karakter_check check
	(
		karakter=-3 or
		karakter=0 or
		karakter=2 or
		karakter=4 or
		karakter=7 or
		karakter=10 or
		karakter=12
	),
	constraint kode_check check
	(
		kode='SY' or
		kode='IM' or
		kode='IA'
	),
	constraint karakter_kode_check check
	(
		(karakter=-3 and kode is not null) or
		(karakter<>-3 and kode is null)
	)
);

go

-- INSERT INTO TABLES ======================================================================================================

insert into uddannelser values ('DMU', 'Datamatiker');
insert into uddannelser values ('MMD', 'Multimedie Design');

insert into studerende values ('eaaluok', 'Lukas', 'Orluff', 'Knudsen', 'DMU');
insert into studerende values ('eaamigk', 'Mike', 'Grindsted', 'Kragelund', 'DMU');
insert into studerende values ('eaacada', 'Casper', null, 'Dahl', 'MMD');
insert into studerende values ('eaalala', 'Lasse', null, 'Larsen', 'MMD');

insert into eksamener values ('1APDMU', '1. Årsprøve', 'DMU');
insert into eksamener values ('PRODMU', 'Programmering', 'DMU');
insert into eksamener values ('SUMDMU', 'Systemudviklingsmetode', 'DMU');
insert into eksamener values ('SPEDMU', 'Specialisering', 'DMU');
insert into eksamener values ('POHDMU', 'Praktik og Hovedopgave', 'DMU');
insert into eksamener values ('1APMMD', '1. Årsprøve', 'MMD');
insert into eksamener values ('GPDMMD', 'Grafisk Design', 'MMD');
insert into eksamener values ('WEBMMD', 'Webudvikling', 'MMD');
insert into eksamener values ('RCTMMD', 'React', 'MMD');
insert into eksamener values ('POHMMD', 'Praktik og Hovedopgave', 'MMD');

insert into forsoeg values (-3, 'IA', 'V2021', 'eaaluok', '1APDMU');
insert into forsoeg values (-3, 'SY', 'V2021', 'eaaluok', '1APDMU');
insert into forsoeg values (4, null, 'V2021', 'eaaluok', '1APDMU');
insert into forsoeg values (-3, 'IA', 'V2021', 'eaamigk', '1APDMU');
insert into forsoeg values (12, null, 'V2021', 'eaamigk', '1APDMU');
insert into forsoeg values (0, null, 'V2021', 'eaacada', '1APMMD');
insert into forsoeg values (-3, 'SY', 'V2021', 'eaacada', '1APMMD');
insert into forsoeg values (4, null, 'S2022', 'eaacada', '1APMMD');
insert into forsoeg values (12, null, 'S2022', 'eaaluok', 'PRODMU');
insert into forsoeg values (12, null, 'S2022', 'eaamigk', 'PRODMU');
insert into forsoeg values (12, null, 'V2022', 'eaamigk', 'SUMDMU');
insert into forsoeg values (12, null, 'S2022', 'eaalala', '1APMMD');
insert into forsoeg values (12, null, 'V2023', 'eaalala', 'GPDMMD');
insert into forsoeg values (12, null, 'V2023', 'eaalala', 'WEBMMD');
insert into forsoeg values (12, null, 'V2023', 'eaalala', 'RCTMMD');
insert into forsoeg values (12, null, 'V2023', 'eaalala', 'POHMMD');

go

-- SELECT QUERIES ==========================================================================================================

-- 4.a
select distinct s.fornavn
from studerende s
join forsoeg f on s.userid=f.userid and f.karakter=12;

-- 4.b
select s.fornavn
from studerende s
where s.userid not in
(
	select f.userid
	from forsoeg f
	where f.karakter<>12
);

-- 4.c
select s.fornavn
from studerende s
where s.userid not in
(
	select f.userid
	from forsoeg f
	group by f.userid, f.eksamenskode
	having count(f.userid)<>1
);

-- 4.d
select e.uddannelseskode uddannelse, e.navn, sum(f.karakter)/(count(*)*1.0) gennemsnit
from forsoeg f
join eksamener e on f.eksamenskode=e.kode
group by e.uddannelseskode, e.navn, f.eksamenskode;

go

-- CREATE VIEW =============================================================================================================

drop view if exists termin_bestaaet_view;

go

create view termin_bestaaet_view as
select u.navn uddannelse, e.navn eksamen, f.termin, count(*) antal_bestaaet
from forsoeg f, eksamener e, uddannelser u
where f.karakter>=2 and f.eksamenskode=e.kode and e.uddannelseskode=u.kode
group by f.termin, e.navn, u.navn;

go

select * from termin_bestaaet_view;

go

-- CREATE PROCEDURE ========================================================================================================

create or alter proc eksamens_statistik_proc
@eksamenskode char(10)
as
select f.karakter, f.kode, count(*) antal
from forsoeg f
where f.eksamenskode=@eksamenskode
group by f.karakter, f.kode;

go

exec eksamens_statistik_proc '1APDMU';
exec eksamens_statistik_proc '1APMMD';

go

-- CREATE TRIGGER ==========================================================================================================

create or alter trigger forsoeg_trigger
on forsoeg after insert
as
if (select count(*) from inserted i, forsoeg f where i.eksamenskode=f.eksamenskode and i.userid=f.userid and f.karakter>=2)>1
begin
	rollback tran;
	raiserror('Den pågældende studerende har allerde bestået den pågældende eksamen', 16, 1);
end;

go

insert into forsoeg values (10, null, 'V2023', 'eaalala', 'POHMMD');

go

-- EKSTRA ==================================================================================================================

create or alter proc uddannelse_bestaaet_proc
@uddannelseskode char(10)
as
select s.fornavn
from forsoeg f
join studerende s on f.userid=s.userid
join eksamener e on e.kode=f.eksamenskode
where e.uddannelseskode=@uddannelseskode and f.karakter>=2
group by s.fornavn
having count(s.fornavn)=(select count(*) from eksamener e where e.uddannelseskode=@uddannelseskode);

go

exec uddannelse_bestaaet_proc 'MMD';