drop Table [dbo].[transacciones]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transacciones](
	[id_transaccion] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[id_cuenta] [int] NULL,
	[tipo] [varchar](20) COLLATE Modern_Spanish_CI_AS NULL,
	[monto] [money] NULL,
	[fecha_transaccion] [datetime] NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dbotransacciones]', 'P') > 0
    drop proc [sp_MSins_dbotransacciones]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dbotransacciones'
go
create procedure [sp_MSins_dbotransacciones]
    @c1 int,
    @c2 int,
    @c3 varchar(20),
    @c4 money,
    @c5 datetime
as
begin  
	insert into [dbo].[transacciones] (
		[id_transaccion],
		[id_cuenta],
		[tipo],
		[monto],
		[fecha_transaccion]
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
    @object_name = N'sp_MSins_dbotransacciones',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'transacciones'
go
if object_id(N'[dbo].[sp_MSins_dbotransacciones_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dbotransacciones_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dbotransacciones_msrepl_ccs]
		@c1 int,
		@c2 int,
		@c3 varchar(20),
		@c4 money,
		@c5 datetime
as
begin
if exists (select * 
             from [dbo].[transacciones]
            where [id_transaccion] = @c1)
begin
update [dbo].[transacciones] set
		[id_cuenta] = @c2,
		[tipo] = @c3,
		[monto] = @c4,
		[fecha_transaccion] = @c5
	where [id_transaccion] = @c1
end
else
begin
	insert into [dbo].[transacciones] (
		[id_transaccion],
		[id_cuenta],
		[tipo],
		[monto],
		[fecha_transaccion]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5	) 
end
end
go
if object_id(N'[sp_MSupd_dbotransacciones]', 'P') > 0
    drop proc [sp_MSupd_dbotransacciones]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dbotransacciones'
go
create procedure [sp_MSupd_dbotransacciones]
		@c1 int = NULL,
		@c2 int = NULL,
		@c3 varchar(20) = NULL,
		@c4 money = NULL,
		@c5 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''

update [dbo].[transacciones] set
		[id_cuenta] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [id_cuenta] end,
		[tipo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [tipo] end,
		[monto] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [monto] end,
		[fecha_transaccion] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [fecha_transaccion] end
	where [id_transaccion] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[id_transaccion] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[dbo].[transacciones]', @param2=@primarykey_text, @param3=13233 
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
    @object_name = N'sp_MSupd_dbotransacciones',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'transacciones'
go
if object_id(N'[sp_MSdel_dbotransacciones]', 'P') > 0
    drop proc [sp_MSdel_dbotransacciones]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dbotransacciones'
go
create procedure [sp_MSdel_dbotransacciones]
		@pkc1 int
as
begin  

	declare @primarykey_text nvarchar(100) = ''
	delete [dbo].[transacciones] 
	where [id_transaccion] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[id_transaccion] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[dbo].[transacciones]', @param2=@primarykey_text, @param3=13234 
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
    @object_name = N'sp_MSdel_dbotransacciones',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'transacciones'
go
if object_id(N'[dbo].[sp_MSdel_dbotransacciones_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dbotransacciones_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dbotransacciones_msrepl_ccs]
		@pkc1 int
as
begin  

	declare @primarykey_text nvarchar(100) = ''
	delete [dbo].[transacciones] 
	where [id_transaccion] = @pkc1
end  
go
