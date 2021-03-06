USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vrebate_PPartnerPaymentsByVendor4Q2010_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vrebate_PPartnerPaymentsByVendor4Q2010_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[vendor_id] ' THEN LastValue ELSE '' END) AS [vendor_id], 
 Max(Case ColumnName WHEN '[vendorpair] ' THEN LastValue ELSE '' END) AS [vendorpair], 
 Max(Case ColumnName WHEN '[vendor] ' THEN LastValue ELSE '' END) AS [vendor], 
 Max(Case ColumnName WHEN '[rebatereportdisplayname] ' THEN LastValue ELSE '' END) AS [rebatereportdisplayname], 
 Max(Case ColumnName WHEN '[Volume] ' THEN LastValue ELSE '' END) AS [Volume], 
 Max(Case ColumnName WHEN '[Rebate] ' THEN LastValue ELSE '' END) AS [Rebate], 
 Max(Case ColumnName WHEN '[payment] ' THEN LastValue ELSE '' END) AS [payment], 
 Max(Case ColumnName WHEN '[NumStoresPaid] ' THEN LastValue ELSE '' END) AS [NumStoresPaid]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.rebate_PPartnerPaymentsByVendor4Q2010') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.rebate_PPartnerPaymentsByVendor4Q2010') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.rebate_PPartnerPaymentsByVendor4Q2010') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
