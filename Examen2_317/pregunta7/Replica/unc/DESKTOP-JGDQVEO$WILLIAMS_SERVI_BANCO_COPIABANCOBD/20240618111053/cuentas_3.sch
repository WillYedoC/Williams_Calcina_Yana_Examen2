drop Table [dbo].[cuentas]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cuentas](
	[id_cuenta] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[id_cliente] [int] NULL,
	[saldo] [money] NULL,
	[tipo] [varchar](20) COLLATE Modern_Spanish_CI_AS NULL,
	[fecha_creacion] [date] NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dbocuentas]', 'P') > 0
    drop proc [sp_MSins_dbocuentas]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dbocuentas'
go
create procedure [sp_MSins_dbocuentas]
    @c1 int,
    @c2 int,
    @c3 money,
    @c4 varchar(20),
    @c5 date
as
begin  
	insert into [dbo].[cuentas] (
		[id_cuenta],
		[id_cliente],
		[saldo],
		[tipo],
		[fecha_creacion]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5	) 
end  
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSins_dbocuentas',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'cuentas'
go
if object_id(N'[dbo].[sp_MSins_dbocuentas_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dbocuentas_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dbocuentas_msrepl_ccs]
		@c1 int,
		@c2 int,
		@c3 money,
		@c4 varchar(20),
		@c5 date
as
begin
if exists (select * 
             from [dbo].[cuentas]
            where [id_cuenta] = @c1)
begin
update [dbo].[cuentas] set
		[id_cliente] = @c2,
		[saldo] = @c3,
		[tipo] = @c4,
		[fecha_creacion] = @c5
	where [id_cuenta] = @c1
end
else
begin
	insert into [dbo].[cuentas] (
		[id_cuenta],
		[id_cliente],
		[saldo],
		[tipo],
		[fecha_creacion]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5	) 
end
end
go
if object_id(N'[sp_MSupd_dbocuentas]', 'P') > 0
    drop proc [sp_MSupd_dbocuentas]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dbocuentas'
go
create procedure [sp_MSupd_dbocuentas]
		@c1 int = NULL,
		@c2 int = NULL,
		@c3 money = NULL,
		@c4 varchar(20) = NULL,
		@c5 date = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''

update [dbo].[cuentas] set
		[id_cliente] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [id_cliente] end,
		[saldo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [saldo] end,
		[tipo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [tipo] end,
		[fecha_creacion] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [fecha_creacion] end
	where [id_cuenta] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[id_cuenta] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[dbo].[cuentas]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSupd_dbocuentas',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'cuentas'
go
if object_id(N'[sp_MSdel_dbocuentas]', 'P') > 0
    drop proc [sp_MSdel_dbocuentas]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dbocuentas'
go
create procedure [sp_MSdel_dbocuentas]
		@pkc1 int
as
begin  

	declare @primarykey_text nvarchar(100) = ''
	delete [dbo].[cuentas] 
	where [id_cuenta] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[id_cuenta] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[dbo].[cuentas]', @param2=@primarykey_text, @param3=13234 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSdel_dbocuentas',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'cuentas'
go
if object_id(N'[dbo].[sp_MSdel_dbocuentas_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dbocuentas_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dbocuentas_msrepl_ccs]
		@pkc1 int
as
begin  

	declare @primarykey_text nvarchar(100) = ''
	delete [dbo].[cuentas] 
	where [id_cuenta] = @pkc1
end  
go
