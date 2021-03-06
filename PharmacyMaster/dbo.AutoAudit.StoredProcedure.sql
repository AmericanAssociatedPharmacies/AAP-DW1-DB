USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[AutoAudit]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[AutoAudit] (
   @SchemaName VARCHAR(50),
   @TableName VARCHAR(50)
) 
AS 
SET NoCount ON

-- script to create autoAudit triggers
DECLARE 
   @SQL NVARCHAR(max),
   @SQLEXTENDED NVARCHAR(max),	
   @ColumnName  sysname,
   @PKColumnName sysname,
   @PKColumnName2 sysname,
   @PKColumnName3 sysname,
   @PKColumnName4 sysname,	
   @PKColumnName5 sysname
   

-- drop existing insert trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Insert' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert'
EXEC (@SQL)

-- drop existing update trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Update' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update'
EXEC (@SQL)

-- drop existing modified trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Modified' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified'
EXEC (@SQL)

-- drop existing delete trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Delete' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete'
EXEC (@SQL)

-- drop existing delete view
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''v' + @TableName + '_Deleted' + ''' )'
       + ' DROP VIEW ' + @SchemaName + '.v' + @TableName + '_Deleted'
EXEC (@SQL)



-- add created column 
IF not exists (select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = 'created')
  BEGIN
    SET @SQL = 'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD Created DateTime NOT NULL DEFAULT(GetDate())'
    EXEC (@SQL)
  END

-- add modified column 
IF not exists( select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = 'modified')
  BEGIN   
    SET @SQL = 'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD Modified DateTime NOT NULL DEFAULT(GetDate())'
    EXEC (@SQL)
  END

-- add RowVersion column 
IF not exists( select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = 'RowVersion')
  BEGIN   
    SET @SQL = 'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD RowVersion INT NOT NULL DEFAULT(1)'
    EXEC (@SQL)
  END


-- get PK Column (1)  
select @PKColumnName = c.name
  from sys.tables t
    join sys.schemas s
      on s.schema_id = t.schema_id
    join sys.indexes i
      on t.object_id = i.object_id
    join sys.index_columns ic
  	  on i.object_id = ic.object_id
      and i.index_id = ic.index_id
    join sys.columns c
      on ic.object_id = c.object_id
      and ic.column_id = c.column_id
  where is_primary_key = 1 AND t.name = @TableName AND s.name = @SchemaName AND ic.index_column_id = 1

-- get PK Column (2)  
select @PKColumnName2 = c.name
  from sys.tables t
    join sys.schemas s
      on s.schema_id = t.schema_id
    join sys.indexes i
      on t.object_id = i.object_id
    join sys.index_columns ic
  	  on i.object_id = ic.object_id
      and i.index_id = ic.index_id
    join sys.columns c
      on ic.object_id = c.object_id
      and ic.column_id = c.column_id
  where is_primary_key = 1 AND t.name = @TableName AND s.name = @SchemaName AND ic.index_column_id = 2

-- get PK Column (3)  
select @PKColumnName3 = c.name
  from sys.tables t
    join sys.schemas s
      on s.schema_id = t.schema_id
    join sys.indexes i
      on t.object_id = i.object_id
    join sys.index_columns ic
  	  on i.object_id = ic.object_id
      and i.index_id = ic.index_id
    join sys.columns c
      on ic.object_id = c.object_id
      and ic.column_id = c.column_id
  where is_primary_key = 1 AND t.name = @TableName AND s.name = @SchemaName AND ic.index_column_id = 3

-- get PK Column (4)  
select @PKColumnName4 = c.name
  from sys.tables t
    join sys.schemas s
      on s.schema_id = t.schema_id
    join sys.indexes i
      on t.object_id = i.object_id
    join sys.index_columns ic
  	  on i.object_id = ic.object_id
      and i.index_id = ic.index_id
    join sys.columns c
      on ic.object_id = c.object_id
      and ic.column_id = c.column_id
  where is_primary_key = 1 AND t.name = @TableName AND s.name = @SchemaName AND ic.index_column_id = 4

-- get PK Column (5)  
select @PKColumnName5 = c.name
  from sys.tables t
    join sys.schemas s
      on s.schema_id = t.schema_id
    join sys.indexes i
      on t.object_id = i.object_id
    join sys.index_columns ic
  	  on i.object_id = ic.object_id
      and i.index_id = ic.index_id
    join sys.columns c
      on ic.object_id = c.object_id
      and ic.column_id = c.column_id
  where is_primary_key = 1 AND t.name = @TableName AND s.name = @SchemaName AND ic.index_column_id = 5

-- build modified trigger 


       
	   IF (@PKColumnName2) IS NULL and @PKColumnName3 IS NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
       BEGIN
	   SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)

       + ' If Trigger_NestLevel() > 1 Return;' + Char(13) + Char(10)
       + ' If (Update(Created) or Update(Modified)) AND Trigger_NestLevel() = 1' + Char(13) + Char(10)
       + ' Begin; Raiserror(''Update failed.'', 16, 1); Rollback;  Return; End;' + Char(13) + Char(10)

       + ' -- Update the Modified date' + Char(13) + Char(10)
       + ' UPDATE [' + @SchemaName + '].[' + @TableName + ']'+ Char(13) + Char(10)
       + ' SET Modified = getdate(), ' + Char(13) + Char(10)
       + '        [RowVersion] = [' + @TableName + '].[RowVersion] + 1 ' + Char(13) + Char(10)
       + '   FROM [' + @SchemaName + '].[' + @TableName + ']' + Char(13) + Char(10)
       + '     JOIN Inserted'  + Char(13) + Char(10)
	   + '       ON [' + @TableName + '].[' + @PKColumnName + '] = Inserted.[' + @PKColumnName + ']'
       END
	
	   IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
	   BEGIN 
	   SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)

       + ' If Trigger_NestLevel() > 1 Return;' + Char(13) + Char(10)
       + ' If (Update(Created) or Update(Modified)) AND Trigger_NestLevel() = 1' + Char(13) + Char(10)
       + ' Begin; Raiserror(''Update failed.'', 16, 1); Rollback;  Return; End;' + Char(13) + Char(10)

       + ' -- Update the Modified date' + Char(13) + Char(10)
       + ' UPDATE [' + @SchemaName + '].[' + @TableName + ']'+ Char(13) + Char(10)
       + ' SET Modified = getdate(), ' + Char(13) + Char(10)
       + '        [RowVersion] = [' + @TableName + '].[RowVersion] + 1 ' + Char(13) + Char(10)
       + '   FROM [' + @SchemaName + '].[' + @TableName + ']' + Char(13) + Char(10)
       + '     JOIN Inserted'  + Char(13) + Char(10)
	   + '       ON [' + @TableName + '].[' + @PKColumnName + '] = Inserted.[' + @PKColumnName + '] AND [' + @TableName + '].[' + @PKColumnName2 + '] = Inserted.[' + @PKColumnName2 + ']'
	   END

	   IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
	   BEGIN
	   SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)

       + ' If Trigger_NestLevel() > 1 Return;' + Char(13) + Char(10)
       + ' If (Update(Created) or Update(Modified)) AND Trigger_NestLevel() = 1' + Char(13) + Char(10)
       + ' Begin; Raiserror(''Update failed.'', 16, 1); Rollback;  Return; End;' + Char(13) + Char(10)

       + ' -- Update the Modified date' + Char(13) + Char(10)
       + ' UPDATE [' + @SchemaName + '].[' + @TableName + ']'+ Char(13) + Char(10)
       + ' SET Modified = getdate(), ' + Char(13) + Char(10)
       + '        [RowVersion] = [' + @TableName + '].[RowVersion] + 1 ' + Char(13) + Char(10)
       + '   FROM [' + @SchemaName + '].[' + @TableName + ']' + Char(13) + Char(10)
       + '     JOIN Inserted'  + Char(13) + Char(10)
	   + '       ON [' + @TableName + '].[' + @PKColumnName + '] = Inserted.[' + @PKColumnName + '] AND [' + @TableName + '].[' + @PKColumnName2 + '] = Inserted.[' + @PKColumnName2 + '] AND [' + @TableName + '].[' + @PKColumnName3 + '] = Inserted.[' + @PKColumnName3 + ']'
	   END

	   IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND (@PKColumnName4) IS NOT NULL and @PKColumnName5 IS NULL
	   BEGIN
	   SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)

       + ' If Trigger_NestLevel() > 1 Return;' + Char(13) + Char(10)
       + ' If (Update(Created) or Update(Modified)) AND Trigger_NestLevel() = 1' + Char(13) + Char(10)
       + ' Begin; Raiserror(''Update failed.'', 16, 1); Rollback;  Return; End;' + Char(13) + Char(10)

       + ' -- Update the Modified date' + Char(13) + Char(10)
       + ' UPDATE [' + @SchemaName + '].[' + @TableName + ']'+ Char(13) + Char(10)
       + ' SET Modified = getdate(), ' + Char(13) + Char(10)
       + '        [RowVersion] = [' + @TableName + '].[RowVersion] + 1 ' + Char(13) + Char(10)
       + '   FROM [' + @SchemaName + '].[' + @TableName + ']' + Char(13) + Char(10)
       + '     JOIN Inserted'  + Char(13) + Char(10)
	   + '       ON [' + @TableName + '].[' + @PKColumnName + '] = Inserted.[' + @PKColumnName + '] AND [' + @TableName + '].[' + @PKColumnName2 + '] = Inserted.[' + @PKColumnName2 + '] AND [' + @TableName + '].[' + @PKColumnName3 + '] = Inserted.[' + @PKColumnName3 + '] AND [' + @TableName + '].[' + @PKColumnName4 + '] = Inserted.[' + @PKColumnName4 + ']'
	   END

	   IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND (@PKColumnName4) IS NOT NULL and @PKColumnName5 IS NOT NULL
	   BEGIN
	   SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)

       + ' If Trigger_NestLevel() > 1 Return;' + Char(13) + Char(10)
       + ' If (Update(Created) or Update(Modified)) AND Trigger_NestLevel() = 1' + Char(13) + Char(10)
       + ' Begin; Raiserror(''Update failed.'', 16, 1); Rollback;  Return; End;' + Char(13) + Char(10)

       + ' -- Update the Modified date' + Char(13) + Char(10)
       + ' UPDATE [' + @SchemaName + '].[' + @TableName + ']'+ Char(13) + Char(10)
       + ' SET Modified = getdate(), ' + Char(13) + Char(10)
       + '        [RowVersion] = [' + @TableName + '].[RowVersion] + 1 ' + Char(13) + Char(10)
       + '   FROM [' + @SchemaName + '].[' + @TableName + ']' + Char(13) + Char(10)
       + '     JOIN Inserted'  + Char(13) + Char(10)
	   + '       ON [' + @TableName + '].[' + @PKColumnName + '] = Inserted.[' + @PKColumnName + '] AND [' + @TableName + '].[' + @PKColumnName2 + '] = Inserted.[' + @PKColumnName2 + '] AND [' + @TableName + '].[' + @PKColumnName3 + '] = Inserted.[' + @PKColumnName3 + '] AND [' + @TableName + '].[' + @PKColumnName4 + '] = Inserted.[' + @PKColumnName4 + '] AND [' + @TableName + '].[' + @PKColumnName5 + '] = Inserted.[' + @PKColumnName5 + ']'
	   END

    EXEC (@SQL)

-------------------------------------------
-- build insert trigger 
IF (@PKColumnName2) IS NULL and @PKColumnName3 IS NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Insert' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)


-- for each column
	select @SQL = @SQL + 
  	     '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, RowDescription, SecondaryRow, ColumnName, NewValue)' + Char(13) + Char(10)
          + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
          + '''' + @SchemaName + '.' + @TableName + ''', ''i'','   
          + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
          + '        NULL,     -- -- Row Description (e.g. Order Number)' + Char(13) + Char(10)
          + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
          + '        ''[' + c.name + ']'','   
          + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
          + '          FROM Inserted' + Char(13) + Char(10)
          + '          WHERE Inserted.['+ c.name + '] is not null' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id


END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Insert' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
		     '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, RowDescription, SecondaryRow, ColumnName, NewValue)' + Char(13) + Char(10)
          + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
          + '''' + @SchemaName + '.' + @TableName + ''', ''i'','   
          + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
		  + ' Inserted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
		  + '        NULL,     -- -- Row Description (e.g. Order Number)' + Char(13) + Char(10)
          + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
          + '        ''[' + c.name + ']'','   
          + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
          + '          FROM Inserted' + Char(13) + Char(10)
          + '          WHERE Inserted.['+ c.name + '] is not null' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id
END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Insert' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
		     '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3, RowDescription, SecondaryRow, ColumnName, NewValue)' + Char(13) + Char(10)
          + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
          + '''' + @SchemaName + '.' + @TableName + ''', ''i'','   
          + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
		  + ' Inserted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
		  + ' Inserted.[' + @PKColumnName3 + '],' + Char(13) + Char(10) 
		  + '        NULL,     -- -- Row Description (e.g. Order Number)' + Char(13) + Char(10)
          + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
          + '        ''[' + c.name + ']'','   
          + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
          + '          FROM Inserted' + Char(13) + Char(10)
          + '          WHERE Inserted.['+ c.name + '] is not null' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id
END


IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND @PKColumnName4 IS NOT NULL AND @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Insert' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
		     '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3, PrimaryKey4, RowDescription, SecondaryRow, ColumnName, NewValue)' + Char(13) + Char(10)
          + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
          + '''' + @SchemaName + '.' + @TableName + ''', ''i'','   
          + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
		  + ' Inserted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
		  + ' Inserted.[' + @PKColumnName3 + '],' + Char(13) + Char(10) 
          + ' Inserted.[' + @PKColumnName4 + '],' + Char(13) + Char(10) 
		  + '        NULL,     -- -- Row Description (e.g. Order Number)' + Char(13) + Char(10)
          + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
          + '        ''[' + c.name + ']'','   
          + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
          + '          FROM Inserted' + Char(13) + Char(10)
          + '          WHERE Inserted.['+ c.name + '] is not null' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id
END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND @PKColumnName4 IS NOT NULL AND @PKColumnName5 IS NOT NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Insert' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
		     '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3, PrimaryKey4, PrimaryKey5, RowDescription, SecondaryRow, ColumnName, NewValue)' + Char(13) + Char(10)
          + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
          + '''' + @SchemaName + '.' + @TableName + ''', ''i'','   
          + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
		  + ' Inserted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
		  + ' Inserted.[' + @PKColumnName3 + '],' + Char(13) + Char(10) 
          + ' Inserted.[' + @PKColumnName4 + '],' + Char(13) + Char(10) 
          + ' Inserted.[' + @PKColumnName5 + '],' + Char(13) + Char(10) 
		  + '        NULL,     -- -- Row Description (e.g. Order Number)' + Char(13) + Char(10)
          + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
          + '        ''[' + c.name + ']'','   
          + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
          + '          FROM Inserted' + Char(13) + Char(10)
          + '          WHERE Inserted.['+ c.name + '] is not null' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id
END

EXEC (@SQL)

--------------------------
-- build update trigger 
IF (@PKColumnName2) IS NULL and @PKColumnName3 IS NULL AND @PKColumnName4 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
	   +  ' IF UPDATE([' + c.name + '])' + Char(13) + Char(10)
       + '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, RowDescription, SecondaryRow, ColumnName, OldValue, NewValue)' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''u'','   
       + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
       + '        NULL,     -- Row Description (e.g. Order Number)' + Char(13) + Char(10)   
       + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
       + '        ''[' + c.name+ ']'','   
       + ' Cast(Deleted.[' + c.name + '] as VARCHAR(50)), ' 
       + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
       + '          FROM Inserted' + Char(13) + Char(10)
       + '             JOIN Deleted' + Char(13) + Char(10)
       + '               ON Inserted.[' + @PKColumnName + '] = Deleted.[' + @PKColumnName + ']' + Char(13) + Char(10)
       + '               AND isnull(Inserted.[' + c.name + '],'''') <> isnull(Deleted.[' + c.name + '],'''')' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id

END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
	   +  ' IF UPDATE([' + c.name + '])' + Char(13) + Char(10)
       + '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, RowDescription, SecondaryRow, ColumnName, OldValue, NewValue)' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''u'','   
       + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
 	   + ' Inserted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
       + '        NULL,     -- Row Description (e.g. Order Number)' + Char(13) + Char(10)   
       + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
       + '        ''[' + c.name+ ']'','   
       + ' Cast(Deleted.[' + c.name + '] as VARCHAR(50)), ' 
       + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
       + '          FROM Inserted' + Char(13) + Char(10)
       + '             JOIN Deleted' + Char(13) + Char(10)
       + '               ON Inserted.[' + @PKColumnName + '] = Deleted.[' + @PKColumnName + '] AND Inserted.[' + @PKColumnName2 + '] = Deleted.[' + @PKColumnName2 + ']' + Char(13) + Char(10)
       + '               AND isnull(Inserted.[' + c.name + '],'''') <> isnull(Deleted.[' + c.name + '],'''')' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id

END
IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND @PKColumnName4 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
	   +  ' IF UPDATE([' + c.name + '])' + Char(13) + Char(10)
       + '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3, RowDescription, SecondaryRow, ColumnName, OldValue, NewValue)' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''u'','   
       + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
 	   + ' Inserted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
 	   + ' Inserted.[' + @PKColumnName3 + '],' + Char(13) + Char(10) 
       + '        NULL,     -- Row Description (e.g. Order Number)' + Char(13) + Char(10)   
       + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
       + '        ''[' + c.name+ ']'','   
       + ' Cast(Deleted.[' + c.name + '] as VARCHAR(50)), ' 
       + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
       + '          FROM Inserted' + Char(13) + Char(10)
       + '             JOIN Deleted' + Char(13) + Char(10)
       + '               ON Inserted.[' + @PKColumnName + '] = Deleted.[' + @PKColumnName + '] AND Inserted.[' + @PKColumnName2 + '] = Deleted.[' + @PKColumnName2 + '] AND Inserted.[' + @PKColumnName3 + '] = Deleted.[' + @PKColumnName3 + ']' + Char(13) + Char(10)
       + '               AND isnull(Inserted.[' + c.name + '],'''') <> isnull(Deleted.[' + c.name + '],'''')' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id
END

IF @PKColumnName2 IS NOT NULL AND @PKColumnName3 IS NOT NULL AND (@PKColumnName4) IS NOT NULL and @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
	   +  ' IF UPDATE([' + c.name + '])' + Char(13) + Char(10)
       + '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3, PrimaryKey4, RowDescription, SecondaryRow, ColumnName, OldValue, NewValue)' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''u'','   
       + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
 	   + ' Inserted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
 	   + ' Inserted.[' + @PKColumnName3 + '],' + Char(13) + Char(10) 
       + ' Inserted.[' + @PKColumnName4 + '],' + Char(13) + Char(10) 
       + '        NULL,     -- Row Description (e.g. Order Number)' + Char(13) + Char(10)   
       + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
       + '        ''[' + c.name+ ']'','   
       + ' Cast(Deleted.[' + c.name + '] as VARCHAR(50)), ' 
       + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
       + '          FROM Inserted' + Char(13) + Char(10)
       + '             JOIN Deleted' + Char(13) + Char(10)
       + '               ON Inserted.[' + @PKColumnName + '] = Deleted.[' + @PKColumnName + '] AND Inserted.[' + @PKColumnName2 + '] = Deleted.[' + @PKColumnName2 + '] AND Inserted.[' + @PKColumnName3 + '] = Deleted.[' + @PKColumnName3 + '] AND Inserted.[' + @PKColumnName4 + '] = Deleted.[' + @PKColumnName4 + ']' + Char(13) + Char(10)
       + '               AND isnull(Inserted.[' + c.name + '],'''') <> isnull(Deleted.[' + c.name + '],'''')' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id
END

IF @PKColumnName2 IS NOT NULL AND @PKColumnName3 IS NOT NULL AND (@PKColumnName4) IS NOT NULL and @PKColumnName5 IS NOT NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
	   +  ' IF UPDATE([' + c.name + '])' + Char(13) + Char(10)
       + '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3, PrimaryKey4, Primarykey5,RowDescription, SecondaryRow, ColumnName, OldValue, NewValue)' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''u'','   
       + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
 	   + ' Inserted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
 	   + ' Inserted.[' + @PKColumnName3 + '],' + Char(13) + Char(10) 
       + ' Inserted.[' + @PKColumnName4 + '],' + Char(13) + Char(10) 
       + ' Inserted.[' + @PKColumnName5 + '],' + Char(13) + Char(10) 
       + '        NULL,     -- Row Description (e.g. Order Number)' + Char(13) + Char(10)   
       + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
       + '        ''[' + c.name+ ']'','   
       + ' Cast(Deleted.[' + c.name + '] as VARCHAR(50)), ' 
       + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
       + '          FROM Inserted' + Char(13) + Char(10)
       + '             JOIN Deleted' + Char(13) + Char(10)
       + '               ON Inserted.[' + @PKColumnName + '] = Deleted.[' + @PKColumnName + '] AND Inserted.[' + @PKColumnName2 + '] = Deleted.[' + @PKColumnName2 + '] AND Inserted.[' + @PKColumnName3 + '] = Deleted.[' + @PKColumnName3 + '] AND Inserted.[' + @PKColumnName4 + '] = Deleted.[' + @PKColumnName4 + ']' + ' AND Inserted.[' + @PKColumnName5 + '] = Deleted.[' + @PKColumnName5 + ']' + Char(13) + Char(10)
       + '               AND isnull(Inserted.[' + c.name + '],'''') <> isnull(Deleted.[' + c.name + '],'''')' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id
END

EXEC (@SQL)

--------------------------
-- build delete trigger 
IF (@PKColumnName2) IS NULL and @PKColumnName3 IS NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Delete' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

       +  '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey)' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''d'','   
       + ' Deleted.[' + @PKColumnName + ']' + Char(13) + Char(10) 
       + '          FROM Deleted' + Char(13) + Char(10)
END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Delete' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

       +  '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2)' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''d'','   
       + ' Deleted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName2 + ']' + Char(13) + Char(10) 
       + '          FROM Deleted' + Char(13) + Char(10)
END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND @PKColumnName4 IS NULL AND @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Delete' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

       +  '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3 )' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''d'','   
       + ' Deleted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName3 + ']' + Char(13) + Char(10) 
       + '          FROM Deleted' + Char(13) + Char(10)
END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND (@PKColumnName4) IS NOT NULL and @PKColumnName5 IS NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Delete' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys TARGET' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

       +  '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3,Primarykey4 )' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''d'','   
       + ' Deleted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName3 + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName4 + ']' + Char(13) + Char(10) 
       + '          FROM Deleted' + Char(13) + Char(10)
END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NOT NULL AND (@PKColumnName4) IS NOT NULL and @PKColumnName5 IS NOT NULL
BEGIN
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Delete' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen but revised by Rudy Hinojosa to handle up to 5 composite keys' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)

       +  '   INSERT dbo.Audit (AuditDate, SysUser, Application, TableName, Operation, PrimaryKey, PrimaryKey2, PrimaryKey3, PrimaryKey4, PrimaryKey5 )' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(),' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''d'','   
       + ' Deleted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName2 + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName3 + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName4 + '],' + Char(13) + Char(10) 
       + ' Deleted.[' + @PKColumnName5 + ']' + Char(13) + Char(10) 
       + '          FROM Deleted' + Char(13) + Char(10)
END

EXEC (@SQL)

--------------------------
-- build _delete view

/* Sample: 
CREATE VIEW HumanResources.vDepartment_Deleted
as
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM 
	(SELECT PrimaryKey,
	  Max(Case ColumnName WHEN '[DepartmentID]' THEN LastValue ELSE '' END) AS DepartmentID,
	  Max(Case ColumnName WHEN '[Name]' THEN LastValue ELSE '' END) AS [Name],
	  Max(Case ColumnName WHEN '[GroupName]' THEN LastValue ELSE '' END) AS GroupName
	  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
					 Where Operation IN ('i', 'u') 
						AND AuditID IN (
							Select Max(AuditID) 
							  FROM dbo.audit a
								JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'HumanResources.Department') d
								  on a.tablename = d.tablename and a.primarykey = d.primarykey
							  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
	  GROUP BY PrimaryKey) Col
	JOIN 
		(SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
			  FROM dbo.Audit a
				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'HumanResources.Department') d
					on a.tablename = d.tablename and a.primarykey = d.primarykey
			  Where Operation IN ('i', 'u')
			  GROUP BY a.TableName, a.PrimaryKey ) CM
			ON Col.PrimaryKey = CM.PrimaryKey
    JOIN 
		(SELECT PrimaryKey, AuditDate as Deleted 
            FROM dbo.audit 
            WHERE operation = 'd' 
            AND TableName = 'HumanResources.Department') DD
			ON Col.PrimaryKey = DD.PrimaryKey

*/

IF (@PKColumnName2) IS NULL and @PKColumnName3 IS NULL AND @PKCOLUMNNAME4 IS NULL AND @PKCOLUMNNAME5 IS NULL
BEGIN

SET @SQL = 'CREATE VIEW ' + @SchemaName + '.v' + @TableName + '_Deleted' + Char(13) + Char(10)
       + 'AS ' + Char(13) + Char(10) + 'SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM ' 
	   + ' (SELECT PrimaryKey'  + Char(13) + Char(10)

-- for each column
	SELECT @SQL = @SQL 
      + ', ' +  Char(13) + Char(10) + ' Max(Case ColumnName WHEN ''[' + c.name + '] '' THEN LastValue ELSE '''' END) AS [' + c.name +']'
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id

    SET @SQL = @SQL +  Char(13) + Char(10)
    + '  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  ' +  Char(13) + Char(10)
    + '  		 Where Operation IN (''i'', ''u'') ' +  Char(13) + Char(10)
    + '  				AND AuditID IN (' +  Char(13) + Char(10)
    + '  					Select Max(AuditID)'  +  Char(13) + Char(10)
    + '  				  FROM dbo.audit a' +  Char(13) + Char(10)
    + '  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = ''d'' AND TableName = ''' + @SchemaName + '.' + @TableName + ''') d' +  Char(13) + Char(10)
    + '  						  on a.tablename = d.tablename and a.primarykey = d.primarykey' +  Char(13) + Char(10)
    + '  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q' +  Char(13) + Char(10)
    + '  GROUP BY PrimaryKey) Col' +  Char(13) + Char(10)
    + '  JOIN ' +  Char(13) + Char(10)
    + '  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified' +  Char(13) + Char(10)
    + '  			  FROM dbo.Audit a' +  Char(13) + Char(10)
    + '  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = ''d'' AND TableName = ''' + @SchemaName + '.' + @TableName + ''') d' +  Char(13) + Char(10)
    + '  					on a.tablename = d.tablename and a.primarykey = d.primarykey' +  Char(13) + Char(10)
    + '  			  Where Operation IN (''i'', ''u'')' +  Char(13) + Char(10)
    + '  			  GROUP BY a.TableName, a.PrimaryKey ) CM' +  Char(13) + Char(10)
    + '  			ON Col.PrimaryKey = CM.PrimaryKey' +  Char(13) + Char(10)
    + '      JOIN ' +  Char(13) + Char(10)
    + '  		(SELECT PrimaryKey, AuditDate as Deleted ' +  Char(13) + Char(10)
    + '              FROM dbo.audit ' +  Char(13) + Char(10)
    + '              WHERE operation = ''d'' ' +  Char(13) + Char(10)
    + '              AND TableName = ''' + @SchemaName + '.' + @TableName + ''') DD' +  Char(13) + Char(10)
    + '  			ON Col.PrimaryKey = DD.PrimaryKey' +  Char(13) + Char(10)
END

IF (@PKColumnName2) IS NOT NULL and @PKColumnName3 IS NULL AND @PKCOLUMNNAME4 IS NULL AND @PKCOLUMNNAME5 IS NULL
BEGIN

SET @SQL = 'CREATE VIEW ' + @SchemaName + '.v' + @TableName + '_Deleted' + Char(13) + Char(10)
       + 'AS ' + Char(13) + Char(10) + 'SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM ' 
	   + ' (SELECT PrimaryKey, PrimaryKey2'  + Char(13) + Char(10)

-- for each column
	SELECT @SQL = @SQL 
      + ', ' +  Char(13) + Char(10) + ' Max(Case ColumnName WHEN ''[' + c.name + '] '' THEN LastValue ELSE '''' END) AS [' + c.name +']'
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name NOT IN ('xml', 'varbinary', 'image', 'text', 'geography')
	  order by c.column_id

    SET @SQL = @SQL +  Char(13) + Char(10)
    + '  FROM (Select PrimaryKey, PrimaryKey2, ColumnName, NewValue as LastValue from dbo.audit  ' +  Char(13) + Char(10)
    + '  		 Where Operation IN (''i'', ''u'') ' +  Char(13) + Char(10)
    + '  				AND AuditID IN (' +  Char(13) + Char(10)
    + '  					Select Max(AuditID)'  +  Char(13) + Char(10)
    + '  				  FROM dbo.audit a' +  Char(13) + Char(10)
    + '  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = ''d'' AND TableName = ''' + @SchemaName + '.' + @TableName + ''') d' +  Char(13) + Char(10)
    + '  						  on a.tablename = d.tablename and (a.primarykey = d.primarykey and a.primarykey2 = d.primarykey2)' +  Char(13) + Char(10)
    + '  					  GROUP BY a.TableName, a.PrimaryKey, a.PrimaryKey2, a.ColumnName )) q' +  Char(13) + Char(10)
    + '  GROUP BY PrimaryKey) Col' +  Char(13) + Char(10)
    + '  JOIN ' +  Char(13) + Char(10)
    + '  (SELECT a.TableName, a.PrimaryKey, a.PrimaryKey2, Min(AuditDate) as Created, Max(AuditDate) as Modified' +  Char(13) + Char(10)
    + '  			  FROM dbo.Audit a' +  Char(13) + Char(10)
    + '  				JOIN (SELECT TableName, PrimaryKey, Primarykey2 FROM dbo.audit where operation = ''d'' AND TableName = ''' + @SchemaName + '.' + @TableName + ''') d' +  Char(13) + Char(10)
    + '  					on a.tablename = d.tablename and (a.primarykey = d.primarykey and a.primarykey2 = d.primarykey2)' +  Char(13) + Char(10)
    + '  			  Where Operation IN (''i'', ''u'')' +  Char(13) + Char(10)
    + '  			  GROUP BY a.TableName, a.PrimaryKey, a.PrimaryKey2 ) CM' +  Char(13) + Char(10)
    + '  			ON Col.PrimaryKey = CM.PrimaryKey and Col.PrimaryKey2 = CM.PrimaryKey2' +  Char(13) + Char(10)
    + '      JOIN ' +  Char(13) + Char(10)
    + '  		(SELECT PrimaryKey, PrimaryKey2, AuditDate as Deleted ' +  Char(13) + Char(10)
    + '              FROM dbo.audit ' +  Char(13) + Char(10)
    + '              WHERE operation = ''d'' ' +  Char(13) + Char(10)
    + '              AND TableName = ''' + @SchemaName + '.' + @TableName + ''') DD' +  Char(13) + Char(10)
    + '  			ON Col.PrimaryKey = DD.PrimaryKey and Col.PrimaryKey2 = DD.PrimaryKey2' +  Char(13) + Char(10)
END

EXEC (@SQL)

RETURN -- END OF SPROC











GO
