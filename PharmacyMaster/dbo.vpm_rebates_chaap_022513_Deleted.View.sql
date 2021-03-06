USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vpm_rebates_chaap_022513_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vpm_rebates_chaap_022513_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[Date] ' THEN LastValue ELSE '' END) AS [Date], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[PrimaryCANo] ' THEN LastValue ELSE '' END) AS [PrimaryCANo], 
 Max(Case ColumnName WHEN '[Division] ' THEN LastValue ELSE '' END) AS [Division], 
 Max(Case ColumnName WHEN '[APIAccountNo] ' THEN LastValue ELSE '' END) AS [APIAccountNo], 
 Max(Case ColumnName WHEN '[AccountName] ' THEN LastValue ELSE '' END) AS [AccountName], 
 Max(Case ColumnName WHEN '[ExtendedSales] ' THEN LastValue ELSE '' END) AS [ExtendedSales], 
 Max(Case ColumnName WHEN '[AAPVolumeAdminFee] ' THEN LastValue ELSE '' END) AS [AAPVolumeAdminFee], 
 Max(Case ColumnName WHEN '[RxPlusAdminFee] ' THEN LastValue ELSE '' END) AS [RxPlusAdminFee], 
 Max(Case ColumnName WHEN '[Affiliate] ' THEN LastValue ELSE '' END) AS [Affiliate], 
 Max(Case ColumnName WHEN '[BusCls] ' THEN LastValue ELSE '' END) AS [BusCls], 
 Max(Case ColumnName WHEN '[AAPVolumeAdminFeePaidToAffiliate] ' THEN LastValue ELSE '' END) AS [AAPVolumeAdminFeePaidToAffiliate], 
 Max(Case ColumnName WHEN '[BrandRxSales] ' THEN LastValue ELSE '' END) AS [BrandRxSales], 
 Max(Case ColumnName WHEN '[SourceGenericSales] ' THEN LastValue ELSE '' END) AS [SourceGenericSales], 
 Max(Case ColumnName WHEN '[ExcludedGenericSales] ' THEN LastValue ELSE '' END) AS [ExcludedGenericSales], 
 Max(Case ColumnName WHEN '[TotalGenericSales] ' THEN LastValue ELSE '' END) AS [TotalGenericSales], 
 Max(Case ColumnName WHEN '[AAPGenericAdminFee] ' THEN LastValue ELSE '' END) AS [AAPGenericAdminFee], 
 Max(Case ColumnName WHEN '[AAPGenericAdminFeePaidToPipco] ' THEN LastValue ELSE '' END) AS [AAPGenericAdminFeePaidToPipco], 
 Max(Case ColumnName WHEN '[GenericRebate] ' THEN LastValue ELSE '' END) AS [GenericRebate], 
 Max(Case ColumnName WHEN '[LeaderRebate] ' THEN LastValue ELSE '' END) AS [LeaderRebate], 
 Max(Case ColumnName WHEN '[MSIRebate] ' THEN LastValue ELSE '' END) AS [MSIRebate], 
 Max(Case ColumnName WHEN '[PayToStore] ' THEN LastValue ELSE '' END) AS [PayToStore], 
 Max(Case ColumnName WHEN '[PayToAffiliateOffice] ' THEN LastValue ELSE '' END) AS [PayToAffiliateOffice], 
 Max(Case ColumnName WHEN '[TotalToPayOut] ' THEN LastValue ELSE '' END) AS [TotalToPayOut], 
 Max(Case ColumnName WHEN '[TM] ' THEN LastValue ELSE '' END) AS [TM], 
 Max(Case ColumnName WHEN '[PayAccount] ' THEN LastValue ELSE '' END) AS [PayAccount], 
 Max(Case ColumnName WHEN '[EffRebatePerc] ' THEN LastValue ELSE '' END) AS [EffRebatePerc], 
 Max(Case ColumnName WHEN '[HRTA] ' THEN LastValue ELSE '' END) AS [HRTA], 
 Max(Case ColumnName WHEN '[SortCode] ' THEN LastValue ELSE '' END) AS [SortCode], 
 Max(Case ColumnName WHEN '[RebateType] ' THEN LastValue ELSE '' END) AS [RebateType]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_rebates_chaap_022513') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_rebates_chaap_022513') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.pm_rebates_chaap_022513') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
