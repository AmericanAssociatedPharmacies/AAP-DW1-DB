USE [Medispan_HazDrug]
GO
/****** Object:  StoredProcedure [dbo].[DropPrimaryKey]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DropPrimaryKey] @tableName Varchar(255) AS DECLARE @dropSql varchar(4000) DECLARE @pkName Varchar(255) begin SET @pkName= (SELECT [name] FROM sysobjects WHERE [xtype]= 'PK' AND [parent_obj]= OBJECT_ID(N'[dbo].['+@tableName+N']')) SET @dropSql='ALTER TABLE [dbo].['+@tableName+'] DROP CONSTRAINT ['+ @PkName+']' EXEC(@dropSql) end IF (@pkName is null) begin set @pkName=(SELECT [name] FROM sysobjects WHERE [xtype]= 'PK' AND [parent_obj]= OBJECT_ID(N'['+@tableName+N']')) SET @dropSql='ALTER TABLE ['+@tableName+'] DROP CONSTRAINT ['+@PkName+']' EXEC(@dropSql) end;
GO
