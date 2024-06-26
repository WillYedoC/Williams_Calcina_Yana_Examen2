drop Table [dbo].[clientes]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[id_cliente] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[nombre] [varchar](50) COLLATE Modern_Spanish_CI_AS NULL,
	[apellido] [varchar](50) COLLATE Modern_Spanish_CI_AS NULL,
	[dni] [varchar](20) COLLATE Modern_Spanish_CI_AS NULL,
	[direccion] [varchar](100) COLLATE Modern_Spanish_CI_AS NULL,
	[telefono] [varchar](20) COLLATE Modern_Spanish_CI_AS NULL,
	[email] [varchar](50) COLLATE Modern_Spanish_CI_AS NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboclientes]', 'P') > 0
    drop proc [sp_MSins_dboclientes]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboclientes'
go
create procedure [sp_MSins_dboclientes]
    @c1 int,
    @c2 varchar(50),
    @c3 varchar(50),
    @c4 varchar(20),
    @c5 varchar(100),
    @c6 varchar(20),
    @c7 varchar(50)
as
begin  
	insert into [dbo].[clientes] (
		[id_cliente],
		[nombre],
		[apellido],
		[dni],
		[direccion],
		[telefono],
		[email]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6,
		@c7	) 
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
    @object_name = N'sp_MSins_dboclientes',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'clientes'
go
if object_id(N'[dbo].[sp_MSins_dboclientes_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboclientes_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboclientes_msrepl_ccs]
		@c1 int,
		@c2 varchar(50),
		@c3 varchar(50),
		@c4 varchar(20),
		@c5 varchar(100),
		@c6 varchar(20),
		@c7 varchar(50)
as
begin
if exists (select * 
             from [dbo].[clientes]
            where [id_cliente] = @c1)
begin
update [dbo].[clientes] set
		[nombre] = @c2,
		[apellido] = @c3,
		[dni] = @c4,
		[direccion] = @c5,
		[telefono] = @c6,
		[email] = @c7
	where [id_cliente] = @c1
end
else
begin
	insert into [dbo].[clientes] (
		[id_cliente],
		[nombre],
		[apellido],
		[dni],
		[direccion],
		[telefono],
		[email]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6,
		@c7	) 
end
end
go
if object_id(N'[sp_MSupd_dboclientes]', 'P') > 0
    drop proc [sp_MSupd_dboclientes]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboclientes'
go
create procedure [sp_MSupd_dboclientes]
		@c1 int = NULL,
		@c2 varchar(50) = NULL,
		@c3 varchar(50) = NULL,
		@c4 varchar(20) = NULL,
		@c5 varchar(100) = NULL,
		@c6 varchar(20) = NULL,
		@c7 varchar(50) = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''

update [dbo].[clientes] set
		[nombre] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [nombre] end,
		[apellido] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [apellido] end,
		[dni] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [dni] end,
		[direccion] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [direccion] end,
		[telefono] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [telefono] end,
		[email] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [email] end
	where [id_cliente] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[id_cliente] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[dbo].[clientes]', @param2=@primarykey_text, @param3=13233 
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
    @object_name = N'sp_MSupd_dboclientes',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'clientes'
go
if object_id(N'[sp_MSdel_dboclientes]', 'P') > 0
    drop proc [sp_MSdel_dboclientes]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboclientes'
go
create procedure [sp_MSdel_dboclientes]
		@pkc1 int
as
begin  

	declare @primarykey_text nvarchar(100) = ''
	delete [dbo].[clientes] 
	where [id_cliente] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[id_cliente] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[dbo].[clientes]', @param2=@primarykey_text, @param3=13234 
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
    @object_name = N'sp_MSdel_dboclientes',
    @publisher = N'DESKTOP-JGDQVEO\WILLIAMS_SERVI',
    @publisher_db = N'banco',
    @publication = N'CopiaBancoBD',
    @article = N'clientes'
go
if object_id(N'[dbo].[sp_MSdel_dboclientes_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboclientes_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboclientes_msrepl_ccs]
		@pkc1 int
as
begin  

	declare @primarykey_text nvarchar(100) = ''
	delete [dbo].[clientes] 
	where [id_cliente] = @pkc1
end  
go
