USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vtmp_PeachTree_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vtmp_PeachTree_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[pmid] ' THEN LastValue ELSE '' END) AS [pmid], 
 Max(Case ColumnName WHEN '[Corpname] ' THEN LastValue ELSE '' END) AS [Corpname], 
 Max(Case ColumnName WHEN '[address] ' THEN LastValue ELSE '' END) AS [address], 
 Max(Case ColumnName WHEN '[address2] ' THEN LastValue ELSE '' END) AS [address2], 
 Max(Case ColumnName WHEN '[city] ' THEN LastValue ELSE '' END) AS [city], 
 Max(Case ColumnName WHEN '[state] ' THEN LastValue ELSE '' END) AS [state], 
 Max(Case ColumnName WHEN '[zip] ' THEN LastValue ELSE '' END) AS [zip], 
 Max(Case ColumnName WHEN '[1099Type] ' THEN LastValue ELSE '' END) AS [1099Type], 
 Max(Case ColumnName WHEN '[phone] ' THEN LastValue ELSE '' END) AS [phone], 
 Max(Case ColumnName WHEN '[fax] ' THEN LastValue ELSE '' END) AS [fax], 
 Max(Case ColumnName WHEN '[email] ' THEN LastValue ELSE '' END) AS [email], 
 Max(Case ColumnName WHEN '[GLExpenseAccount] ' THEN LastValue ELSE '' END) AS [GLExpenseAccount], 
 Max(Case ColumnName WHEN '[FedID] ' THEN LastValue ELSE '' END) AS [FedID], 
 Max(Case ColumnName WHEN '[1099Setting] ' THEN LastValue ELSE '' END) AS [1099Setting]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_PeachTree') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_PeachTree') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.tmp_PeachTree') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
