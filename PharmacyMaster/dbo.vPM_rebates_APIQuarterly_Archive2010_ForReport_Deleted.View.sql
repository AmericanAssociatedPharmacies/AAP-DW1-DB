USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vPM_rebates_APIQuarterly_Archive2010_ForReport_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPM_rebates_APIQuarterly_Archive2010_ForReport_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[period] ' THEN LastValue ELSE '' END) AS [period], 
 Max(Case ColumnName WHEN '[date_start] ' THEN LastValue ELSE '' END) AS [date_start], 
 Max(Case ColumnName WHEN '[date_end] ' THEN LastValue ELSE '' END) AS [date_end], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[Pay Account] ' THEN LastValue ELSE '' END) AS [Pay Account], 
 Max(Case ColumnName WHEN '[Gross Qtr Rebate] ' THEN LastValue ELSE '' END) AS [Gross Qtr Rebate], 
 Max(Case ColumnName WHEN '[Less Negative Rebates] ' THEN LastValue ELSE '' END) AS [Less Negative Rebates], 
 Max(Case ColumnName WHEN '[Unpaid Finance Charges] ' THEN LastValue ELSE '' END) AS [Unpaid Finance Charges], 
 Max(Case ColumnName WHEN '[Leader Net Rebate] ' THEN LastValue ELSE '' END) AS [Leader Net Rebate], 
 Max(Case ColumnName WHEN '[Net Rebate to Pay Acct/Admin] ' THEN LastValue ELSE '' END) AS [Net Rebate to Pay Acct/Admin], 
 Max(Case ColumnName WHEN '[Less Group Admin] ' THEN LastValue ELSE '' END) AS [Less Group Admin], 
 Max(Case ColumnName WHEN '[Net Qtr Rebate to Store] ' THEN LastValue ELSE '' END) AS [Net Qtr Rebate to Store], 
 Max(Case ColumnName WHEN '[Cardinal Program Rebate] ' THEN LastValue ELSE '' END) AS [Cardinal Program Rebate], 
 Max(Case ColumnName WHEN '[API Program Rebate] ' THEN LastValue ELSE '' END) AS [API Program Rebate], 
 Max(Case ColumnName WHEN '[API Acct#] ' THEN LastValue ELSE '' END) AS [API Acct#], 
 Max(Case ColumnName WHEN '[Pharmacy Name] ' THEN LastValue ELSE '' END) AS [Pharmacy Name], 
 Max(Case ColumnName WHEN '[Primary CA#] ' THEN LastValue ELSE '' END) AS [Primary CA#], 
 Max(Case ColumnName WHEN '[CA Division] ' THEN LastValue ELSE '' END) AS [CA Division], 
 Max(Case ColumnName WHEN '[Grand Total Purchases] ' THEN LastValue ELSE '' END) AS [Grand Total Purchases], 
 Max(Case ColumnName WHEN '[Total Cardinal Sales] ' THEN LastValue ELSE '' END) AS [Total Cardinal Sales], 
 Max(Case ColumnName WHEN '[Cardinal Non-Net Sales] ' THEN LastValue ELSE '' END) AS [Cardinal Non-Net Sales], 
 Max(Case ColumnName WHEN '[Vol Admin Fee] ' THEN LastValue ELSE '' END) AS [Vol Admin Fee], 
 Max(Case ColumnName WHEN '[CA Brand Sales] ' THEN LastValue ELSE '' END) AS [CA Brand Sales], 
 Max(Case ColumnName WHEN '[CA Generic Contract Sales] ' THEN LastValue ELSE '' END) AS [CA Generic Contract Sales], 
 Max(Case ColumnName WHEN '[CA Generic Rebate] ' THEN LastValue ELSE '' END) AS [CA Generic Rebate], 
 Max(Case ColumnName WHEN '[CA Rebate to Pay out] ' THEN LastValue ELSE '' END) AS [CA Rebate to Pay out], 
 Max(Case ColumnName WHEN '[API ADMIN FEE] ' THEN LastValue ELSE '' END) AS [API ADMIN FEE], 
 Max(Case ColumnName WHEN '[API -TO PAY Cardinal Side-NO P2] ' THEN LastValue ELSE '' END) AS [API -TO PAY Cardinal Side-NO P2], 
 Max(Case ColumnName WHEN '[CA-P2P3 SALES] ' THEN LastValue ELSE '' END) AS [CA-P2P3 SALES], 
 Max(Case ColumnName WHEN '[CA-P2P3 REBATES] ' THEN LastValue ELSE '' END) AS [CA-P2P3 REBATES], 
 Max(Case ColumnName WHEN '[API Generic Sales] ' THEN LastValue ELSE '' END) AS [API Generic Sales], 
 Max(Case ColumnName WHEN '[API Brand Sales] ' THEN LastValue ELSE '' END) AS [API Brand Sales], 
 Max(Case ColumnName WHEN '[API OTC Sales] ' THEN LastValue ELSE '' END) AS [API OTC Sales], 
 Max(Case ColumnName WHEN '[API Whse Sales] ' THEN LastValue ELSE '' END) AS [API Whse Sales], 
 Max(Case ColumnName WHEN '[API WHSE REBATE] ' THEN LastValue ELSE '' END) AS [API WHSE REBATE], 
 Max(Case ColumnName WHEN '[Brand Credits Disbursed] ' THEN LastValue ELSE '' END) AS [Brand Credits Disbursed], 
 Max(Case ColumnName WHEN '[Accelerated Pay Discount] ' THEN LastValue ELSE '' END) AS [Accelerated Pay Discount], 
 Max(Case ColumnName WHEN '[ECOG] ' THEN LastValue ELSE '' END) AS [ECOG], 
 Max(Case ColumnName WHEN '[Donepezil Rebate] ' THEN LastValue ELSE '' END) AS [Donepezil Rebate], 
 Max(Case ColumnName WHEN '[Avg Rebate Percentage] ' THEN LastValue ELSE '' END) AS [Avg Rebate Percentage], 
 Max(Case ColumnName WHEN '[Affiliate] ' THEN LastValue ELSE '' END) AS [Affiliate]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PM_rebates_APIQuarterly_Archive2010_ForReport') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PM_rebates_APIQuarterly_Archive2010_ForReport') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.PM_rebates_APIQuarterly_Archive2010_ForReport') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
