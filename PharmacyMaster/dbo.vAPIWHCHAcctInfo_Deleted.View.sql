USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vAPIWHCHAcctInfo_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAPIWHCHAcctInfo_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[Marker] ' THEN LastValue ELSE '' END) AS [Marker], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[Status] ' THEN LastValue ELSE '' END) AS [Status], 
 Max(Case ColumnName WHEN '[DEA#] ' THEN LastValue ELSE '' END) AS [DEA#], 
 Max(Case ColumnName WHEN '[Customer Name] ' THEN LastValue ELSE '' END) AS [Customer Name], 
 Max(Case ColumnName WHEN '[API acct] ' THEN LastValue ELSE '' END) AS [API acct], 
 Max(Case ColumnName WHEN '[AAP Number] ' THEN LastValue ELSE '' END) AS [AAP Number], 
 Max(Case ColumnName WHEN '[AAP Parent#] ' THEN LastValue ELSE '' END) AS [AAP Parent#], 
 Max(Case ColumnName WHEN '[UD#] ' THEN LastValue ELSE '' END) AS [UD#], 
 Max(Case ColumnName WHEN '[MCA on File] ' THEN LastValue ELSE '' END) AS [MCA on File], 
 Max(Case ColumnName WHEN '[Bs Class] ' THEN LastValue ELSE '' END) AS [Bs Class], 
 Max(Case ColumnName WHEN '[AAP Affiliate] ' THEN LastValue ELSE '' END) AS [AAP Affiliate], 
 Max(Case ColumnName WHEN '[CA Parent Code] ' THEN LastValue ELSE '' END) AS [CA Parent Code], 
 Max(Case ColumnName WHEN '[Cardinal Division#] ' THEN LastValue ELSE '' END) AS [Cardinal Division#], 
 Max(Case ColumnName WHEN '[Cardinal DC] ' THEN LastValue ELSE '' END) AS [Cardinal DC], 
 Max(Case ColumnName WHEN '[Primary CA Acct#] ' THEN LastValue ELSE '' END) AS [Primary CA Acct#], 
 Max(Case ColumnName WHEN '[2nd Cardinal cust] ' THEN LastValue ELSE '' END) AS [2nd Cardinal cust], 
 Max(Case ColumnName WHEN '[3rd Cardinal cust] ' THEN LastValue ELSE '' END) AS [3rd Cardinal cust], 
 Max(Case ColumnName WHEN '[POS Acct] ' THEN LastValue ELSE '' END) AS [POS Acct], 
 Max(Case ColumnName WHEN '[Scan-Toss Acct] ' THEN LastValue ELSE '' END) AS [Scan-Toss Acct], 
 Max(Case ColumnName WHEN '[CSOS Acct] ' THEN LastValue ELSE '' END) AS [CSOS Acct], 
 Max(Case ColumnName WHEN '[AAP Contract Date] ' THEN LastValue ELSE '' END) AS [AAP Contract Date], 
 Max(Case ColumnName WHEN '[Termination Date] ' THEN LastValue ELSE '' END) AS [Termination Date], 
 Max(Case ColumnName WHEN '[Multiple Store] ' THEN LastValue ELSE '' END) AS [Multiple Store], 
 Max(Case ColumnName WHEN '[Multiple Store Code] ' THEN LastValue ELSE '' END) AS [Multiple Store Code], 
 Max(Case ColumnName WHEN '[Group Code] ' THEN LastValue ELSE '' END) AS [Group Code], 
 Max(Case ColumnName WHEN '[Current Est Mo Sales] ' THEN LastValue ELSE '' END) AS [Current Est Mo Sales], 
 Max(Case ColumnName WHEN '[Current Grp Total] ' THEN LastValue ELSE '' END) AS [Current Grp Total], 
 Max(Case ColumnName WHEN '[Est Volume at Load] ' THEN LastValue ELSE '' END) AS [Est Volume at Load], 
 Max(Case ColumnName WHEN '[Last Review Date] ' THEN LastValue ELSE '' END) AS [Last Review Date], 
 Max(Case ColumnName WHEN '[Current API COG] ' THEN LastValue ELSE '' END) AS [Current API COG], 
 Max(Case ColumnName WHEN '[Current CA COG] ' THEN LastValue ELSE '' END) AS [Current CA COG], 
 Max(Case ColumnName WHEN '[QPS Store] ' THEN LastValue ELSE '' END) AS [QPS Store], 
 Max(Case ColumnName WHEN '[Payment Terms description] ' THEN LastValue ELSE '' END) AS [Payment Terms description], 
 Max(Case ColumnName WHEN '[Payment Terms Code] ' THEN LastValue ELSE '' END) AS [Payment Terms Code], 
 Max(Case ColumnName WHEN '[Pending Changes] ' THEN LastValue ELSE '' END) AS [Pending Changes], 
 Max(Case ColumnName WHEN '[Change Pending] ' THEN LastValue ELSE '' END) AS [Change Pending], 
 Max(Case ColumnName WHEN '[Notes COG Differences] ' THEN LastValue ELSE '' END) AS [Notes COG Differences], 
 Max(Case ColumnName WHEN '[Notes] ' THEN LastValue ELSE '' END) AS [Notes], 
 Max(Case ColumnName WHEN '[AAP Rep] ' THEN LastValue ELSE '' END) AS [AAP Rep], 
 Max(Case ColumnName WHEN '[Excpt to Matrix] ' THEN LastValue ELSE '' END) AS [Excpt to Matrix], 
 Max(Case ColumnName WHEN '[Optional Pay Terms] ' THEN LastValue ELSE '' END) AS [Optional Pay Terms], 
 Max(Case ColumnName WHEN '[Front Load-No Reb] ' THEN LastValue ELSE '' END) AS [Front Load-No Reb], 
 Max(Case ColumnName WHEN '[WAPD] ' THEN LastValue ELSE '' END) AS [WAPD], 
 Max(Case ColumnName WHEN '[DSO] ' THEN LastValue ELSE '' END) AS [DSO], 
 Max(Case ColumnName WHEN '[Last Update] ' THEN LastValue ELSE '' END) AS [Last Update], 
 Max(Case ColumnName WHEN '[WAPD 2nd Acct] ' THEN LastValue ELSE '' END) AS [WAPD 2nd Acct], 
 Max(Case ColumnName WHEN '[DSO 2nd Acct] ' THEN LastValue ELSE '' END) AS [DSO 2nd Acct], 
 Max(Case ColumnName WHEN '[Sublogic Change] ' THEN LastValue ELSE '' END) AS [Sublogic Change], 
 Max(Case ColumnName WHEN '[Notes on Terms] ' THEN LastValue ELSE '' END) AS [Notes on Terms]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.APIWHCHAcctInfo') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.APIWHCHAcctInfo') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.APIWHCHAcctInfo') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
