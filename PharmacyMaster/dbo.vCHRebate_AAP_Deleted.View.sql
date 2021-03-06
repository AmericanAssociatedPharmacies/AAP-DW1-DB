USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vCHRebate_AAP_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCHRebate_AAP_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[date] ' THEN LastValue ELSE '' END) AS [date], 
 Max(Case ColumnName WHEN '[Primary CA#] ' THEN LastValue ELSE '' END) AS [Primary CA#], 
 Max(Case ColumnName WHEN '[Division] ' THEN LastValue ELSE '' END) AS [Division], 
 Max(Case ColumnName WHEN '[API#] ' THEN LastValue ELSE '' END) AS [API#], 
 Max(Case ColumnName WHEN '[Account Name] ' THEN LastValue ELSE '' END) AS [Account Name], 
 Max(Case ColumnName WHEN '[City] ' THEN LastValue ELSE '' END) AS [City], 
 Max(Case ColumnName WHEN '[ST] ' THEN LastValue ELSE '' END) AS [ST], 
 Max(Case ColumnName WHEN '[SumOfExtended Sales] ' THEN LastValue ELSE '' END) AS [SumOfExtended Sales], 
 Max(Case ColumnName WHEN '[AAP Volume Admin Fee] ' THEN LastValue ELSE '' END) AS [AAP Volume Admin Fee], 
 Max(Case ColumnName WHEN '[Bs Class] ' THEN LastValue ELSE '' END) AS [Bs Class], 
 Max(Case ColumnName WHEN '[Affiliation] ' THEN LastValue ELSE '' END) AS [Affiliation], 
 Max(Case ColumnName WHEN '[Affiliate Admin Fee] ' THEN LastValue ELSE '' END) AS [Affiliate Admin Fee], 
 Max(Case ColumnName WHEN '[SumOfBrand Rx Sales] ' THEN LastValue ELSE '' END) AS [SumOfBrand Rx Sales], 
 Max(Case ColumnName WHEN '[SumOfCCA = AAP Generics 872, 25676, 25677] ' THEN LastValue ELSE '' END) AS [SumOfCCA = AAP Generics 872, 25676, 25677], 
 Max(Case ColumnName WHEN '[SumOfCCA = 26776 AAP Excluded Generic Rx Prod] ' THEN LastValue ELSE '' END) AS [SumOfCCA = 26776 AAP Excluded Generic Rx Prod], 
 Max(Case ColumnName WHEN '[SumOfTotal Generics] ' THEN LastValue ELSE '' END) AS [SumOfTotal Generics], 
 Max(Case ColumnName WHEN '[Est Generic Admin Fee] ' THEN LastValue ELSE '' END) AS [Est Generic Admin Fee], 
 Max(Case ColumnName WHEN '[Generic Admin Fee -PIPCO only] ' THEN LastValue ELSE '' END) AS [Generic Admin Fee -PIPCO only], 
 Max(Case ColumnName WHEN '[Calculated generic rebate] ' THEN LastValue ELSE '' END) AS [Calculated generic rebate], 
 Max(Case ColumnName WHEN '[Leader Rebate] ' THEN LastValue ELSE '' END) AS [Leader Rebate], 
 Max(Case ColumnName WHEN '[Pay to Store] ' THEN LastValue ELSE '' END) AS [Pay to Store], 
 Max(Case ColumnName WHEN '[Pay to Affiliate Office] ' THEN LastValue ELSE '' END) AS [Pay to Affiliate Office], 
 Max(Case ColumnName WHEN '[Total to Pay Out] ' THEN LastValue ELSE '' END) AS [Total to Pay Out], 
 Max(Case ColumnName WHEN '[Territory Manager] ' THEN LastValue ELSE '' END) AS [Territory Manager], 
 Max(Case ColumnName WHEN '[Pay Account] ' THEN LastValue ELSE '' END) AS [Pay Account], 
 Max(Case ColumnName WHEN '[Effective Rebate%] ' THEN LastValue ELSE '' END) AS [Effective Rebate%], 
 Max(Case ColumnName WHEN '[Sort Code] ' THEN LastValue ELSE '' END) AS [Sort Code]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.CHRebate_AAP') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.CHRebate_AAP') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.CHRebate_AAP') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
