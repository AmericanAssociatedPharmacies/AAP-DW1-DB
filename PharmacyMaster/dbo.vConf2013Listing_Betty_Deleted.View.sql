USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vConf2013Listing_Betty_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vConf2013Listing_Betty_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[Individual Authorized to Vote] ' THEN LastValue ELSE '' END) AS [Individual Authorized to Vote], 
 Max(Case ColumnName WHEN '[Account DBA] ' THEN LastValue ELSE '' END) AS [Account DBA], 
 Max(Case ColumnName WHEN '[AAP Effective Date] ' THEN LastValue ELSE '' END) AS [AAP Effective Date], 
 Max(Case ColumnName WHEN '[AAP Quit Date] ' THEN LastValue ELSE '' END) AS [AAP Quit Date], 
 Max(Case ColumnName WHEN '[AAP Store #] ' THEN LastValue ELSE '' END) AS [AAP Store #], 
 Max(Case ColumnName WHEN '[AAP Parent Store #] ' THEN LastValue ELSE '' END) AS [AAP Parent Store #], 
 Max(Case ColumnName WHEN '[Mailing Address 1] ' THEN LastValue ELSE '' END) AS [Mailing Address 1], 
 Max(Case ColumnName WHEN '[Mailing Address 2] ' THEN LastValue ELSE '' END) AS [Mailing Address 2], 
 Max(Case ColumnName WHEN '[Mailing City] ' THEN LastValue ELSE '' END) AS [Mailing City], 
 Max(Case ColumnName WHEN '[Mailing State] ' THEN LastValue ELSE '' END) AS [Mailing State], 
 Max(Case ColumnName WHEN '[Mailing Zip] ' THEN LastValue ELSE '' END) AS [Mailing Zip]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.Conf2013Listing_Betty') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.Conf2013Listing_Betty') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.Conf2013Listing_Betty') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
