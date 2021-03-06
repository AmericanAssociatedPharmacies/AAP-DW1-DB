USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vCOG_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCOG_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[Ship To Division] ' THEN LastValue ELSE '' END) AS [Ship To Division], 
 Max(Case ColumnName WHEN '[Ship To Division Name] ' THEN LastValue ELSE '' END) AS [Ship To Division Name], 
 Max(Case ColumnName WHEN '[Ship To Number] ' THEN LastValue ELSE '' END) AS [Ship To Number], 
 Max(Case ColumnName WHEN '[Ship To Name] ' THEN LastValue ELSE '' END) AS [Ship To Name], 
 Max(Case ColumnName WHEN '[Ship To Address 1] ' THEN LastValue ELSE '' END) AS [Ship To Address 1], 
 Max(Case ColumnName WHEN '[Ship To City] ' THEN LastValue ELSE '' END) AS [Ship To City], 
 Max(Case ColumnName WHEN '[Ship To State] ' THEN LastValue ELSE '' END) AS [Ship To State], 
 Max(Case ColumnName WHEN '[DEA Registration Number] ' THEN LastValue ELSE '' END) AS [DEA Registration Number], 
 Max(Case ColumnName WHEN '[Default Buy Plan %] ' THEN LastValue ELSE '' END) AS [Default Buy Plan %], 
 Max(Case ColumnName WHEN '[AR2000 Terms Code] ' THEN LastValue ELSE '' END) AS [AR2000 Terms Code], 
 Max(Case ColumnName WHEN '[AR2000 Terms Code Description] ' THEN LastValue ELSE '' END) AS [AR2000 Terms Code Description], 
 Max(Case ColumnName WHEN '[Contract Group Number] ' THEN LastValue ELSE '' END) AS [Contract Group Number], 
 Max(Case ColumnName WHEN '[Contract Group Effective Date] ' THEN LastValue ELSE '' END) AS [Contract Group Effective Date], 
 Max(Case ColumnName WHEN '[Actual WAPD 90 days] ' THEN LastValue ELSE '' END) AS [Actual WAPD 90 days], 
 Max(Case ColumnName WHEN '[MMP DSO 90 days] ' THEN LastValue ELSE '' END) AS [MMP DSO 90 days]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.COG') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.COG') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.COG') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
