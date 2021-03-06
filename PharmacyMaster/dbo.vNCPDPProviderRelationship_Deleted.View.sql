USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vNCPDPProviderRelationship_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vNCPDPProviderRelationship_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[NCPDP] ' THEN LastValue ELSE '' END) AS [NCPDP], 
 Max(Case ColumnName WHEN '[Relationship ID] ' THEN LastValue ELSE '' END) AS [Relationship ID], 
 Max(Case ColumnName WHEN '[Payment Center ID] ' THEN LastValue ELSE '' END) AS [Payment Center ID], 
 Max(Case ColumnName WHEN '[Effective From Date] ' THEN LastValue ELSE '' END) AS [Effective From Date], 
 Max(Case ColumnName WHEN '[Effective Through Date] ' THEN LastValue ELSE '' END) AS [Effective Through Date], 
 Max(Case ColumnName WHEN '[filler] ' THEN LastValue ELSE '' END) AS [filler], 
 Max(Case ColumnName WHEN '[endline] ' THEN LastValue ELSE '' END) AS [endline]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.NCPDPProviderRelationship') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.NCPDPProviderRelationship') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.NCPDPProviderRelationship') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
