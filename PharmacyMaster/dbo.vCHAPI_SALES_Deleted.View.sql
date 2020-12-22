USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vCHAPI_SALES_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCHAPI_SALES_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[Date] ' THEN LastValue ELSE '' END) AS [Date], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[CHAccountNo] ' THEN LastValue ELSE '' END) AS [CHAccountNo], 
 Max(Case ColumnName WHEN '[DCNum] ' THEN LastValue ELSE '' END) AS [DCNum], 
 Max(Case ColumnName WHEN '[DCCity] ' THEN LastValue ELSE '' END) AS [DCCity], 
 Max(Case ColumnName WHEN '[AccountName] ' THEN LastValue ELSE '' END) AS [AccountName], 
 Max(Case ColumnName WHEN '[Address] ' THEN LastValue ELSE '' END) AS [Address], 
 Max(Case ColumnName WHEN '[City] ' THEN LastValue ELSE '' END) AS [City], 
 Max(Case ColumnName WHEN '[State] ' THEN LastValue ELSE '' END) AS [State], 
 Max(Case ColumnName WHEN '[ZIP] ' THEN LastValue ELSE '' END) AS [ZIP], 
 Max(Case ColumnName WHEN '[APIAccountNo] ' THEN LastValue ELSE '' END) AS [APIAccountNo], 
 Max(Case ColumnName WHEN '[AAPAccountNo] ' THEN LastValue ELSE '' END) AS [AAPAccountNo], 
 Max(Case ColumnName WHEN '[DEA] ' THEN LastValue ELSE '' END) AS [DEA], 
 Max(Case ColumnName WHEN '[APICOGAppliedSales] ' THEN LastValue ELSE '' END) AS [APICOGAppliedSales], 
 Max(Case ColumnName WHEN '[APINetSales] ' THEN LastValue ELSE '' END) AS [APINetSales], 
 Max(Case ColumnName WHEN '[APIGENRx] ' THEN LastValue ELSE '' END) AS [APIGENRx], 
 Max(Case ColumnName WHEN '[APIGENTotalSrc] ' THEN LastValue ELSE '' END) AS [APIGENTotalSrc], 
 Max(Case ColumnName WHEN '[APIGENTotalP2P3] ' THEN LastValue ELSE '' END) AS [APIGENTotalP2P3], 
 Max(Case ColumnName WHEN '[APIGENTotal] ' THEN LastValue ELSE '' END) AS [APIGENTotal], 
 Max(Case ColumnName WHEN '[APIBrand] ' THEN LastValue ELSE '' END) AS [APIBrand], 
 Max(Case ColumnName WHEN '[APIOTC] ' THEN LastValue ELSE '' END) AS [APIOTC], 
 Max(Case ColumnName WHEN '[APIOther] ' THEN LastValue ELSE '' END) AS [APIOther], 
 Max(Case ColumnName WHEN '[APIGBRPerc] ' THEN LastValue ELSE '' END) AS [APIGBRPerc], 
 Max(Case ColumnName WHEN '[AAPCOGAppliedSales] ' THEN LastValue ELSE '' END) AS [AAPCOGAppliedSales], 
 Max(Case ColumnName WHEN '[AAPNetSales] ' THEN LastValue ELSE '' END) AS [AAPNetSales], 
 Max(Case ColumnName WHEN '[AAPBrand] ' THEN LastValue ELSE '' END) AS [AAPBrand], 
 Max(Case ColumnName WHEN '[AAPGENTotal] ' THEN LastValue ELSE '' END) AS [AAPGENTotal], 
 Max(Case ColumnName WHEN '[AAPGENTotalSrc] ' THEN LastValue ELSE '' END) AS [AAPGENTotalSrc], 
 Max(Case ColumnName WHEN '[AAPGENExcl] ' THEN LastValue ELSE '' END) AS [AAPGENExcl], 
 Max(Case ColumnName WHEN '[AAPOTC] ' THEN LastValue ELSE '' END) AS [AAPOTC], 
 Max(Case ColumnName WHEN '[AAPOther] ' THEN LastValue ELSE '' END) AS [AAPOther], 
 Max(Case ColumnName WHEN '[CombNetSales] ' THEN LastValue ELSE '' END) AS [CombNetSales], 
 Max(Case ColumnName WHEN '[CombBrands] ' THEN LastValue ELSE '' END) AS [CombBrands], 
 Max(Case ColumnName WHEN '[CombOTC] ' THEN LastValue ELSE '' END) AS [CombOTC], 
 Max(Case ColumnName WHEN '[CombGENTotal] ' THEN LastValue ELSE '' END) AS [CombGENTotal], 
 Max(Case ColumnName WHEN '[CombGENTotalSrc] ' THEN LastValue ELSE '' END) AS [CombGENTotalSrc]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.CHAPI_SALES') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.CHAPI_SALES') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.CHAPI_SALES') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
