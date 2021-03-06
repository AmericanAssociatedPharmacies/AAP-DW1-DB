USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vPM_CHAccounts_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPM_CHAccounts_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[Contract] ' THEN LastValue ELSE '' END) AS [Contract], 
 Max(Case ColumnName WHEN '[DivisionName] ' THEN LastValue ELSE '' END) AS [DivisionName], 
 Max(Case ColumnName WHEN '[Division] ' THEN LastValue ELSE '' END) AS [Division], 
 Max(Case ColumnName WHEN '[CAAccountNo] ' THEN LastValue ELSE '' END) AS [CAAccountNo], 
 Max(Case ColumnName WHEN '[AccountName] ' THEN LastValue ELSE '' END) AS [AccountName], 
 Max(Case ColumnName WHEN '[Address1] ' THEN LastValue ELSE '' END) AS [Address1], 
 Max(Case ColumnName WHEN '[City] ' THEN LastValue ELSE '' END) AS [City], 
 Max(Case ColumnName WHEN '[State] ' THEN LastValue ELSE '' END) AS [State], 
 Max(Case ColumnName WHEN '[DEA] ' THEN LastValue ELSE '' END) AS [DEA], 
 Max(Case ColumnName WHEN '[BuyPlanPerc] ' THEN LastValue ELSE '' END) AS [BuyPlanPerc], 
 Max(Case ColumnName WHEN '[AR2000TermsCode] ' THEN LastValue ELSE '' END) AS [AR2000TermsCode], 
 Max(Case ColumnName WHEN '[AR2000TermsCodeDesc] ' THEN LastValue ELSE '' END) AS [AR2000TermsCodeDesc], 
 Max(Case ColumnName WHEN '[ContractGroupNo] ' THEN LastValue ELSE '' END) AS [ContractGroupNo], 
 Max(Case ColumnName WHEN '[WAPD] ' THEN LastValue ELSE '' END) AS [WAPD], 
 Max(Case ColumnName WHEN '[DSO] ' THEN LastValue ELSE '' END) AS [DSO], 
 Max(Case ColumnName WHEN '[ContractGroupEffDate] ' THEN LastValue ELSE '' END) AS [ContractGroupEffDate], 
 Max(Case ColumnName WHEN '[LoadDate] ' THEN LastValue ELSE '' END) AS [LoadDate]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PM_CHAccounts') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PM_CHAccounts') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.PM_CHAccounts') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
