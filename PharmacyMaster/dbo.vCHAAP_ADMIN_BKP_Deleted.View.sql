USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vCHAAP_ADMIN_BKP_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCHAAP_ADMIN_BKP_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[Date] ' THEN LastValue ELSE '' END) AS [Date], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[CHAccountNo] ' THEN LastValue ELSE '' END) AS [CHAccountNo], 
 Max(Case ColumnName WHEN '[DCNum] ' THEN LastValue ELSE '' END) AS [DCNum], 
 Max(Case ColumnName WHEN '[DCCity] ' THEN LastValue ELSE '' END) AS [DCCity], 
 Max(Case ColumnName WHEN '[AccountName] ' THEN LastValue ELSE '' END) AS [AccountName], 
 Max(Case ColumnName WHEN '[AAPAccountNo] ' THEN LastValue ELSE '' END) AS [AAPAccountNo], 
 Max(Case ColumnName WHEN '[DEA] ' THEN LastValue ELSE '' END) AS [DEA], 
 Max(Case ColumnName WHEN '[GENQual] ' THEN LastValue ELSE '' END) AS [GENQual], 
 Max(Case ColumnName WHEN '[GENExcl] ' THEN LastValue ELSE '' END) AS [GENExcl], 
 Max(Case ColumnName WHEN '[GENTotal] ' THEN LastValue ELSE '' END) AS [GENTotal], 
 Max(Case ColumnName WHEN '[Brand] ' THEN LastValue ELSE '' END) AS [Brand], 
 Max(Case ColumnName WHEN '[Extended] ' THEN LastValue ELSE '' END) AS [Extended], 
 Max(Case ColumnName WHEN '[VolAdminFee] ' THEN LastValue ELSE '' END) AS [VolAdminFee]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.CHAAP_ADMIN_BKP') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.CHAAP_ADMIN_BKP') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.CHAAP_ADMIN_BKP') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
