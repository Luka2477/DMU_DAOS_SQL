--
-- views
--
--create view mitview1
--as
-- SELECT - query

use cykelplaceringer

drop view if exists fuldf�rte
go
create view fuldf�rte
as
select * 
from placering
where plac is not null
go
select * from fuldf�rte
go
--drop view fuldf�rtemedalt
go
create or alter view fuldf�rtemedalt
as
select rytternavn,p.aarstal as aar,plac,bynavn,land
from rytter r join placering p on r.initialer = p.initialer
              join vm on p.aarstal=vm.aarstal
where plac is not null
go
select * from fuldf�rtemedalt
order by aar desc,plac
--
--
-- Stored procedures
--
--go
--create proc myproc
--as
-- T-SQL
go
create or alter proc myproc
as
select distinct aarstal
from placering
where plac is null
go
exec myproc
go
create or alter proc myproc2 
@initialer char(3)
as
select distinct aarstal
from placering
where plac is null and initialer = @initialer
go
exec myproc2 'JS'
go
create or alter proc myproc3 (@initialer char(3),@before int)
as
select distinct aarstal
from placering
where plac is null and initialer = @initialer
and aarstal < @before
go
exec myproc3 'JS',1996
go
create or alter proc myproc4  (@initialer char(3),@antal int output) 
as
select @antal=count(*)
from placering
where plac is null and initialer = @initialer
go
declare @x int
exec myproc4 'JS',@x output
select @x
go

create or alter proc myproc5  (@initialer char(3)) 
as
select count(*)
from placering
where plac is null and initialer = @initialer

exec myproc5 'JS'
go
create or alter proc inds�tplac(@aar int, @initialer char(3),@plac int)
as
insert into placering values (@aar,@initialer,@plac)
go
exec inds�tplac 1975,'LM',56

select * from placering where initialer = 'LM'