USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vtmp_PP1Q2010_Sales_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vtmp_PP1Q2010_Sales_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[AAP#] ' THEN LastValue ELSE '' END) AS [AAP#], 
 Max(Case ColumnName WHEN '[Parent #] ' THEN LastValue ELSE '' END) AS [Parent #], 
 Max(Case ColumnName WHEN '[UD #] ' THEN LastValue ELSE '' END) AS [UD #], 
 Max(Case ColumnName WHEN '[API#] ' THEN LastValue ELSE '' END) AS [API#], 
 Max(Case ColumnName WHEN '[Account Name] ' THEN LastValue ELSE '' END) AS [Account Name], 
 Max(Case ColumnName WHEN '[city] ' THEN LastValue ELSE '' END) AS [city], 
 Max(Case ColumnName WHEN '[state] ' THEN LastValue ELSE '' END) AS [state], 
 Max(Case ColumnName WHEN '[territory] ' THEN LastValue ELSE '' END) AS [territory], 
 Max(Case ColumnName WHEN '[affiliate] ' THEN LastValue ELSE '' END) AS [affiliate], 
 Max(Case ColumnName WHEN '[Contact] ' THEN LastValue ELSE '' END) AS [Contact], 
 Max(Case ColumnName WHEN '[Volume] ' THEN LastValue ELSE '' END) AS [Volume], 
 Max(Case ColumnName WHEN '[Payment] ' THEN LastValue ELSE '' END) AS [Payment]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_PP1Q2010_Sales') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_PP1Q2010_Sales') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.tmp_PP1Q2010_Sales') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
