use kundeordre;

-- DROP TABLES --

drop table if exists ordrelinjer;
drop table if exists vare;
drop table if exists ordre;
drop table if exists kunder;

go

-- CREATE TABLES --

create table kunder (
	kundenr int primary key identity not null,
	navn varchar(50) not null,
	adresse varchar (50) not null
);

create table ordre (
	ordrenummer int primary key identity not null,
	kundenr int constraint kundenrforeign foreign key references kunder not null,
	dato date not null,
	er_betalt bit default 0
);

create table vare (
	varenummer int primary key identity not null,
	varenavn varchar(25) not null,
	pris decimal(7, 2) not null,
	antal_paa_lager int default 0
);

create table ordrelinjer (
	ordrenummer int constraint ordrenummerforeign foreign key references ordre not null,
	antal int not null,
	varenummer int constraint varenummerforeign foreign key references vare not null
	primary key (ordrenummer, varenummer)
);

go

-- INSERTS --

insert into vare values ('Musli', 24.95, 25);
insert into vare values ('Cykel', 1995.95, 2);
insert into vare values ('Rugbrød', 14.95, 0);
insert into vare values ('Jasmin ris (500g)', 9.95, 0);

insert into kunder values ('Lukas Knudsen', 'Risdalsvej 46');
insert into kunder values ('Berta Vazquez de Zubiaurre', 'Vinkenburgstraat 1');

insert into ordre (kundenr, dato) values (1, '2022.02.09');
insert into ordre (kundenr, dato) values (2, '2022.02.10');

insert into ordrelinjer values (1, 5, 1);
insert into ordrelinjer values (1, 1, 2);
insert into ordrelinjer values (2, 10, 1);

go

-- OVERSIGT OVER DATA --

select distinct dato from ordre;
select * from vare where antal_paa_lager=0;
select * from vare order by pris desc;
select * from vare where antal_paa_lager=0 order by pris;