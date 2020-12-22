USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vNCPDPTaxonomyInfo_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vNCPDPTaxonomyInfo_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[NCPDP] ' THEN LastValue ELSE '' END) AS [NCPDP], 
 Max(Case ColumnName WHEN '[Taxonomy Code] ' THEN LastValue ELSE '' END) AS [Taxonomy Code], 
 Max(Case ColumnName WHEN '[Dispenser Type Code] ' THEN LastValue ELSE '' END) AS [Dispenser Type Code], 
 Max(Case ColumnName WHEN '[Delete Date] ' THEN LastValue ELSE '' END) AS [Delete Date]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.NCPDPTaxonomyInfo') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.NCPDPTaxonomyInfo') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.NCPDPTaxonomyInfo') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
