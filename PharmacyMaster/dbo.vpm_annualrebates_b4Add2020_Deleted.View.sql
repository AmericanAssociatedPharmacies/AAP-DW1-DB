USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vpm_annualrebates_b4Add2020_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vpm_annualrebates_b4Add2020_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[ID] ' THEN LastValue ELSE '' END) AS [ID], 
 Max(Case ColumnName WHEN '[Year] ' THEN LastValue ELSE '' END) AS [Year], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[TM] ' THEN LastValue ELSE '' END) AS [TM], 
 Max(Case ColumnName WHEN '[APIAccountNo] ' THEN LastValue ELSE '' END) AS [APIAccountNo], 
 Max(Case ColumnName WHEN '[AccountName] ' THEN LastValue ELSE '' END) AS [AccountName], 
 Max(Case ColumnName WHEN '[BusClass] ' THEN LastValue ELSE '' END) AS [BusClass], 
 Max(Case ColumnName WHEN '[TotalGenerics] ' THEN LastValue ELSE '' END) AS [TotalGenerics], 
 Max(Case ColumnName WHEN '[GenericIncentive] ' THEN LastValue ELSE '' END) AS [GenericIncentive], 
 Max(Case ColumnName WHEN '[PlanOGramRebate] ' THEN LastValue ELSE '' END) AS [PlanOGramRebate], 
 Max(Case ColumnName WHEN '[PatronageDividend] ' THEN LastValue ELSE '' END) AS [PatronageDividend], 
 Max(Case ColumnName WHEN '[PatDivFirstPayment] ' THEN LastValue ELSE '' END) AS [PatDivFirstPayment], 
 Max(Case ColumnName WHEN '[PatDivSecondPayment] ' THEN LastValue ELSE '' END) AS [PatDivSecondPayment]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_annualrebates_b4Add2020') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_annualrebates_b4Add2020') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.pm_annualrebates_b4Add2020') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
