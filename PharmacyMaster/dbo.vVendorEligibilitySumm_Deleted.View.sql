USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vVendorEligibilitySumm_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vVendorEligibilitySumm_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[volumeamt] ' THEN LastValue ELSE '' END) AS [volumeamt], 
 Max(Case ColumnName WHEN '[rebateamt] ' THEN LastValue ELSE '' END) AS [rebateamt], 
 Max(Case ColumnName WHEN '[paymentamt] ' THEN LastValue ELSE '' END) AS [paymentamt], 
 Max(Case ColumnName WHEN '[eligible] ' THEN LastValue ELSE '' END) AS [eligible], 
 Max(Case ColumnName WHEN '[PaytoPMID] ' THEN LastValue ELSE '' END) AS [PaytoPMID]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.VendorEligibilitySumm') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.VendorEligibilitySumm') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.VendorEligibilitySumm') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
