USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vTopGenerics053111_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTopGenerics053111_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[Description] ' THEN LastValue ELSE '' END) AS [Description], 
 Max(Case ColumnName WHEN '[Size] ' THEN LastValue ELSE '' END) AS [Size], 
 Max(Case ColumnName WHEN '[Supplier] ' THEN LastValue ELSE '' END) AS [Supplier], 
 Max(Case ColumnName WHEN '[AWP] ' THEN LastValue ELSE '' END) AS [AWP], 
 Max(Case ColumnName WHEN '[AAP Top Generics Sell Price] ' THEN LastValue ELSE '' END) AS [AAP Top Generics Sell Price], 
 Max(Case ColumnName WHEN '[AAP Top Generics Price Per Unit] ' THEN LastValue ELSE '' END) AS [AAP Top Generics Price Per Unit], 
 Max(Case ColumnName WHEN '[Brand Name] ' THEN LastValue ELSE '' END) AS [Brand Name], 
 Max(Case ColumnName WHEN '[Form] ' THEN LastValue ELSE '' END) AS [Form], 
 Max(Case ColumnName WHEN '[Color] ' THEN LastValue ELSE '' END) AS [Color], 
 Max(Case ColumnName WHEN '[NDC/UPC] ' THEN LastValue ELSE '' END) AS [NDC/UPC], 
 Max(Case ColumnName WHEN '[CIN] ' THEN LastValue ELSE '' END) AS [CIN], 
 Max(Case ColumnName WHEN '[DP#] ' THEN LastValue ELSE '' END) AS [DP#], 
 Max(Case ColumnName WHEN '[GPI_ID] ' THEN LastValue ELSE '' END) AS [GPI_ID], 
 Max(Case ColumnName WHEN '[GCN] ' THEN LastValue ELSE '' END) AS [GCN], 
 Max(Case ColumnName WHEN '[GCN SEQNO] ' THEN LastValue ELSE '' END) AS [GCN SEQNO]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.TopGenerics053111') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.TopGenerics053111') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.TopGenerics053111') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
