USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vVendorVolumeRebate_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vVendorVolumeRebate_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[ID] ' THEN LastValue ELSE '' END) AS [ID], 
 Max(Case ColumnName WHEN '[VendorID] ' THEN LastValue ELSE '' END) AS [VendorID], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[UDNo] ' THEN LastValue ELSE '' END) AS [UDNo], 
 Max(Case ColumnName WHEN '[StoreName] ' THEN LastValue ELSE '' END) AS [StoreName], 
 Max(Case ColumnName WHEN '[VolumeAmt] ' THEN LastValue ELSE '' END) AS [VolumeAmt], 
 Max(Case ColumnName WHEN '[RebateAmt] ' THEN LastValue ELSE '' END) AS [RebateAmt], 
 Max(Case ColumnName WHEN '[AccruedStartdt] ' THEN LastValue ELSE '' END) AS [AccruedStartdt], 
 Max(Case ColumnName WHEN '[AccruedEnddt] ' THEN LastValue ELSE '' END) AS [AccruedEnddt], 
 Max(Case ColumnName WHEN '[FileID] ' THEN LastValue ELSE '' END) AS [FileID], 
 Max(Case ColumnName WHEN '[TransactionID] ' THEN LastValue ELSE '' END) AS [TransactionID], 
 Max(Case ColumnName WHEN '[Eligibility] ' THEN LastValue ELSE '' END) AS [Eligibility], 
 Max(Case ColumnName WHEN '[PayTo] ' THEN LastValue ELSE '' END) AS [PayTo], 
 Max(Case ColumnName WHEN '[Affiliate] ' THEN LastValue ELSE '' END) AS [Affiliate], 
 Max(Case ColumnName WHEN '[StorePaidDt] ' THEN LastValue ELSE '' END) AS [StorePaidDt]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.VendorVolumeRebate') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.VendorVolumeRebate') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.VendorVolumeRebate') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
