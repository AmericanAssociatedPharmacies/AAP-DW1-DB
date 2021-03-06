USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vReport_Def_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vReport_Def_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[ID] ' THEN LastValue ELSE '' END) AS [ID], 
 Max(Case ColumnName WHEN '[ReportDescription] ' THEN LastValue ELSE '' END) AS [ReportDescription], 
 Max(Case ColumnName WHEN '[ReportName] ' THEN LastValue ELSE '' END) AS [ReportName], 
 Max(Case ColumnName WHEN '[Requestor] ' THEN LastValue ELSE '' END) AS [Requestor], 
 Max(Case ColumnName WHEN '[Developer] ' THEN LastValue ELSE '' END) AS [Developer], 
 Max(Case ColumnName WHEN '[StoredProcName] ' THEN LastValue ELSE '' END) AS [StoredProcName], 
 Max(Case ColumnName WHEN '[Frequency] ' THEN LastValue ELSE '' END) AS [Frequency], 
 Max(Case ColumnName WHEN '[Documents] ' THEN LastValue ELSE '' END) AS [Documents], 
 Max(Case ColumnName WHEN '[HassleFactor] ' THEN LastValue ELSE '' END) AS [HassleFactor], 
 Max(Case ColumnName WHEN '[Notes] ' THEN LastValue ELSE '' END) AS [Notes]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.Report_Def') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.Report_Def') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.Report_Def') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
