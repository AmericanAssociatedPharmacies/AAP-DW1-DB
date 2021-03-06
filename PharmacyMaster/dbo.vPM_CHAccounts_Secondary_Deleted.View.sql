USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vPM_CHAccounts_Secondary_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPM_CHAccounts_Secondary_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[DEA] ' THEN LastValue ELSE '' END) AS [DEA], 
 Max(Case ColumnName WHEN '[Second Division] ' THEN LastValue ELSE '' END) AS [Second Division], 
 Max(Case ColumnName WHEN '[2nd Primary Number] ' THEN LastValue ELSE '' END) AS [2nd Primary Number], 
 Max(Case ColumnName WHEN '[2nd 2nd] ' THEN LastValue ELSE '' END) AS [2nd 2nd], 
 Max(Case ColumnName WHEN '[2nd 3rd] ' THEN LastValue ELSE '' END) AS [2nd 3rd], 
 Max(Case ColumnName WHEN '[2nd POS] ' THEN LastValue ELSE '' END) AS [2nd POS], 
 Max(Case ColumnName WHEN '[2nd CSOS] ' THEN LastValue ELSE '' END) AS [2nd CSOS], 
 Max(Case ColumnName WHEN '[2nd CST] ' THEN LastValue ELSE '' END) AS [2nd CST], 
 Max(Case ColumnName WHEN '[Third Division] ' THEN LastValue ELSE '' END) AS [Third Division], 
 Max(Case ColumnName WHEN '[3rd Primary Number] ' THEN LastValue ELSE '' END) AS [3rd Primary Number], 
 Max(Case ColumnName WHEN '[3rd 2nd] ' THEN LastValue ELSE '' END) AS [3rd 2nd], 
 Max(Case ColumnName WHEN '[3rd POS] ' THEN LastValue ELSE '' END) AS [3rd POS], 
 Max(Case ColumnName WHEN '[3rd CSOS] ' THEN LastValue ELSE '' END) AS [3rd CSOS], 
 Max(Case ColumnName WHEN '[3rd CST] ' THEN LastValue ELSE '' END) AS [3rd CST]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PM_CHAccounts_Secondary') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PM_CHAccounts_Secondary') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.PM_CHAccounts_Secondary') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
