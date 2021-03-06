USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vtmp_import_QPSRx30_090110_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vtmp_import_QPSRx30_090110_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[Pharm ID] ' THEN LastValue ELSE '' END) AS [Pharm ID], 
 Max(Case ColumnName WHEN '[Store Name] ' THEN LastValue ELSE '' END) AS [Store Name], 
 Max(Case ColumnName WHEN '[Total Sales] ' THEN LastValue ELSE '' END) AS [Total Sales], 
 Max(Case ColumnName WHEN '[ClaimsCount] ' THEN LastValue ELSE '' END) AS [ClaimsCount], 
 Max(Case ColumnName WHEN '[Total Paid] ' THEN LastValue ELSE '' END) AS [Total Paid], 
 Max(Case ColumnName WHEN '[TotalSales-TotalPaid] ' THEN LastValue ELSE '' END) AS [TotalSales-TotalPaid]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_import_QPSRx30_090110') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_import_QPSRx30_090110') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.tmp_import_QPSRx30_090110') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
