use feriehusleje;

-- DROP TABLES --
drop table if exists bookings;
drop table if exists lejere;
drop table if exists ejere;
drop table if exists feriehuse;
drop table if exists omraader;

-- CREATE TABLES --
create table omraader (
	omraadenavn varchar(50) primary key not null,
	land varchar(50) not null
);

create table feriehuse (
	navn varchar(50) not null,
	adresse varchar(50) primary key not null,
	postnr char(4) not null,
	ugepris int not null,
	omraadenavn varchar(50) constraint omraadeforeign foreign key references omraader
);

create table ejere (
	kundenr int primary key not null,
	navn varchar(50) not null,
	fuldadresse varchar(50),
	kontonr int not null,
	adresse varchar(50) constraint adresseforeign foreign key references feriehuse
);

create table lejere (
	kundenr int primary key not null,
	navn varchar(50) not null,
	fuldadresse varchar(50),
	rabatprocent decimal(4, 3) default 0
);

create table bookings (
	bookingnr int primary key not null,
	ugenr int not null,
	adresse varchar(50) constraint adresseforeign foreign key references feriehuse not null,
	kundenr int constraint kundenrforeign foreign key references lejere not null
);

-- INSERT SOME STUFF --


-- SELECT SOME STUFF --
select * from omraader;
select * from feriehuse;
select * from ejere;
select * from lejere;
select * from bookings;