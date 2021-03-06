USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vNCPDPParentOrganization_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vNCPDPParentOrganization_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[Parent Organization ID] ' THEN LastValue ELSE '' END) AS [Parent Organization ID], 
 Max(Case ColumnName WHEN '[Parent Organization Name] ' THEN LastValue ELSE '' END) AS [Parent Organization Name], 
 Max(Case ColumnName WHEN '[Address 1] ' THEN LastValue ELSE '' END) AS [Address 1], 
 Max(Case ColumnName WHEN '[Address 2] ' THEN LastValue ELSE '' END) AS [Address 2], 
 Max(Case ColumnName WHEN '[City] ' THEN LastValue ELSE '' END) AS [City], 
 Max(Case ColumnName WHEN '[State Code] ' THEN LastValue ELSE '' END) AS [State Code], 
 Max(Case ColumnName WHEN '[Zip Code] ' THEN LastValue ELSE '' END) AS [Zip Code], 
 Max(Case ColumnName WHEN '[Phone Number] ' THEN LastValue ELSE '' END) AS [Phone Number], 
 Max(Case ColumnName WHEN '[Extension] ' THEN LastValue ELSE '' END) AS [Extension], 
 Max(Case ColumnName WHEN '[FAX Number] ' THEN LastValue ELSE '' END) AS [FAX Number], 
 Max(Case ColumnName WHEN '[Contact Name] ' THEN LastValue ELSE '' END) AS [Contact Name], 
 Max(Case ColumnName WHEN '[Contact Title] ' THEN LastValue ELSE '' END) AS [Contact Title], 
 Max(Case ColumnName WHEN '[E-Mail Address] ' THEN LastValue ELSE '' END) AS [E-Mail Address], 
 Max(Case ColumnName WHEN '[NPI] ' THEN LastValue ELSE '' END) AS [NPI], 
 Max(Case ColumnName WHEN '[Delete Date] ' THEN LastValue ELSE '' END) AS [Delete Date]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.NCPDPParentOrganization') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.NCPDPParentOrganization') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.NCPDPParentOrganization') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
