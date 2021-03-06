USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vpm_memberprograms_bkp_103012_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vpm_memberprograms_bkp_103012_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[ProgramID] ' THEN LastValue ELSE '' END) AS [ProgramID], 
 Max(Case ColumnName WHEN '[StartDate] ' THEN LastValue ELSE '' END) AS [StartDate], 
 Max(Case ColumnName WHEN '[EndDate] ' THEN LastValue ELSE '' END) AS [EndDate], 
 Max(Case ColumnName WHEN '[Comment] ' THEN LastValue ELSE '' END) AS [Comment], 
 Max(Case ColumnName WHEN '[AAP] ' THEN LastValue ELSE '' END) AS [AAP]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_memberprograms_bkp_103012') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_memberprograms_bkp_103012') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.pm_memberprograms_bkp_103012') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
