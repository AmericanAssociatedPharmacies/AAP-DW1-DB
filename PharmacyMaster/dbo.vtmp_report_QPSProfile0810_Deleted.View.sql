USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vtmp_report_QPSProfile0810_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vtmp_report_QPSProfile0810_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[AAP#] ' THEN LastValue ELSE '' END) AS [AAP#], 
 Max(Case ColumnName WHEN '[API#] ' THEN LastValue ELSE '' END) AS [API#], 
 Max(Case ColumnName WHEN '[Name] ' THEN LastValue ELSE '' END) AS [Name], 
 Max(Case ColumnName WHEN '[City] ' THEN LastValue ELSE '' END) AS [City], 
 Max(Case ColumnName WHEN '[St] ' THEN LastValue ELSE '' END) AS [St], 
 Max(Case ColumnName WHEN '[TM] ' THEN LastValue ELSE '' END) AS [TM], 
 Max(Case ColumnName WHEN '[Effective] ' THEN LastValue ELSE '' END) AS [Effective], 
 Max(Case ColumnName WHEN '[APIStatus] ' THEN LastValue ELSE '' END) AS [APIStatus], 
 Max(Case ColumnName WHEN '[Chain] ' THEN LastValue ELSE '' END) AS [Chain], 
 Max(Case ColumnName WHEN '[M.Care] ' THEN LastValue ELSE '' END) AS [M.Care], 
 Max(Case ColumnName WHEN '[CHSales_Q2] ' THEN LastValue ELSE '' END) AS [CHSales_Q2], 
 Max(Case ColumnName WHEN '[CHSales_0610] ' THEN LastValue ELSE '' END) AS [CHSales_0610], 
 Max(Case ColumnName WHEN '[API_Q2] ' THEN LastValue ELSE '' END) AS [API_Q2], 
 Max(Case ColumnName WHEN '[API_0610] ' THEN LastValue ELSE '' END) AS [API_0610]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_report_QPSProfile0810') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_report_QPSProfile0810') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.tmp_report_QPSProfile0810') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
