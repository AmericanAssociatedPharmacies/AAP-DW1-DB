USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vVendorsTestOld_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vVendorsTestOld_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[vendor_id] ' THEN LastValue ELSE '' END) AS [vendor_id], 
 Max(Case ColumnName WHEN '[PPFeeNote] ' THEN LastValue ELSE '' END) AS [PPFeeNote], 
 Max(Case ColumnName WHEN '[Website Program Description] ' THEN LastValue ELSE '' END) AS [Website Program Description], 
 Max(Case ColumnName WHEN '[PPContract Billed] ' THEN LastValue ELSE '' END) AS [PPContract Billed], 
 Max(Case ColumnName WHEN '[PPContract Pd] ' THEN LastValue ELSE '' END) AS [PPContract Pd], 
 Max(Case ColumnName WHEN '[Contract Pricing Start Date] ' THEN LastValue ELSE '' END) AS [Contract Pricing Start Date], 
 Max(Case ColumnName WHEN '[Contract Pricing End Date] ' THEN LastValue ELSE '' END) AS [Contract Pricing End Date], 
 Max(Case ColumnName WHEN '[Corporate Rebate] ' THEN LastValue ELSE '' END) AS [Corporate Rebate], 
 Max(Case ColumnName WHEN '[Pat Rebate] ' THEN LastValue ELSE '' END) AS [Pat Rebate], 
 Max(Case ColumnName WHEN '[Rebate To FPN] ' THEN LastValue ELSE '' END) AS [Rebate To FPN], 
 Max(Case ColumnName WHEN '[Rebate From FPN to United] ' THEN LastValue ELSE '' END) AS [Rebate From FPN to United], 
 Max(Case ColumnName WHEN '[CustomerServicePhone] ' THEN LastValue ELSE '' END) AS [CustomerServicePhone], 
 Max(Case ColumnName WHEN '[Customer Service Toll Free] ' THEN LastValue ELSE '' END) AS [Customer Service Toll Free], 
 Max(Case ColumnName WHEN '[Customer Service Fax] ' THEN LastValue ELSE '' END) AS [Customer Service Fax], 
 Max(Case ColumnName WHEN '[CustomerServiceE-mail] ' THEN LastValue ELSE '' END) AS [CustomerServiceE-mail], 
 Max(Case ColumnName WHEN '[WEBSITE] ' THEN LastValue ELSE '' END) AS [WEBSITE], 
 Max(Case ColumnName WHEN '[CorpAddr1] ' THEN LastValue ELSE '' END) AS [CorpAddr1], 
 Max(Case ColumnName WHEN '[CorpAddr2] ' THEN LastValue ELSE '' END) AS [CorpAddr2], 
 Max(Case ColumnName WHEN '[CorpCity] ' THEN LastValue ELSE '' END) AS [CorpCity], 
 Max(Case ColumnName WHEN '[CorpSt] ' THEN LastValue ELSE '' END) AS [CorpSt], 
 Max(Case ColumnName WHEN '[CorpZip] ' THEN LastValue ELSE '' END) AS [CorpZip], 
 Max(Case ColumnName WHEN '[CORP800] ' THEN LastValue ELSE '' END) AS [CORP800], 
 Max(Case ColumnName WHEN '[CorpPhone] ' THEN LastValue ELSE '' END) AS [CorpPhone], 
 Max(Case ColumnName WHEN '[CorpFax] ' THEN LastValue ELSE '' END) AS [CorpFax], 
 Max(Case ColumnName WHEN '[Last Modified] ' THEN LastValue ELSE '' END) AS [Last Modified], 
 Max(Case ColumnName WHEN '[Why Modified] ' THEN LastValue ELSE '' END) AS [Why Modified], 
 Max(Case ColumnName WHEN '[PPContract  Effective] ' THEN LastValue ELSE '' END) AS [PPContract  Effective], 
 Max(Case ColumnName WHEN '[PPContract  Expiration] ' THEN LastValue ELSE '' END) AS [PPContract  Expiration], 
 Max(Case ColumnName WHEN '[Tier] ' THEN LastValue ELSE '' END) AS [Tier], 
 Max(Case ColumnName WHEN '[PreferedPartnerSince] ' THEN LastValue ELSE '' END) AS [PreferedPartnerSince], 
 Max(Case ColumnName WHEN '[Contract Term Date] ' THEN LastValue ELSE '' END) AS [Contract Term Date], 
 Max(Case ColumnName WHEN '[Active] ' THEN LastValue ELSE '' END) AS [Active], 
 Max(Case ColumnName WHEN '[PIPCo Program] ' THEN LastValue ELSE '' END) AS [PIPCo Program], 
 Max(Case ColumnName WHEN '[United PIPCoUses] ' THEN LastValue ELSE '' END) AS [United PIPCoUses], 
 Max(Case ColumnName WHEN '[NotesPPPStatus] ' THEN LastValue ELSE '' END) AS [NotesPPPStatus], 
 Max(Case ColumnName WHEN '[Vendor Type] ' THEN LastValue ELSE '' END) AS [Vendor Type], 
 Max(Case ColumnName WHEN '[Annual Renewal LetterSent] ' THEN LastValue ELSE '' END) AS [Annual Renewal LetterSent], 
 Max(Case ColumnName WHEN '[Welcome E-mail Infor Form] ' THEN LastValue ELSE '' END) AS [Welcome E-mail Infor Form], 
 Max(Case ColumnName WHEN '[InfoFormReturned] ' THEN LastValue ELSE '' END) AS [InfoFormReturned], 
 Max(Case ColumnName WHEN '[WelcomeLetterMarketingCalendar] ' THEN LastValue ELSE '' END) AS [WelcomeLetterMarketingCalendar], 
 Max(Case ColumnName WHEN '[MKt BannerStart Date] ' THEN LastValue ELSE '' END) AS [MKt BannerStart Date], 
 Max(Case ColumnName WHEN '[Mkt BannerEnd Date] ' THEN LastValue ELSE '' END) AS [Mkt BannerEnd Date], 
 Max(Case ColumnName WHEN '[SSI] ' THEN LastValue ELSE '' END) AS [SSI], 
 Max(Case ColumnName WHEN '[Spin Reports United] ' THEN LastValue ELSE '' END) AS [Spin Reports United], 
 Max(Case ColumnName WHEN '[Spin Reports Partner] ' THEN LastValue ELSE '' END) AS [Spin Reports Partner], 
 Max(Case ColumnName WHEN '[Spin Report Notes] ' THEN LastValue ELSE '' END) AS [Spin Report Notes], 
 Max(Case ColumnName WHEN '[Spin Reports N A] ' THEN LastValue ELSE '' END) AS [Spin Reports N A], 
 Max(Case ColumnName WHEN '[Spin Reports FPN] ' THEN LastValue ELSE '' END) AS [Spin Reports FPN], 
 Max(Case ColumnName WHEN '[DirectorySent] ' THEN LastValue ELSE '' END) AS [DirectorySent], 
 Max(Case ColumnName WHEN '[LinkedURL] ' THEN LastValue ELSE '' END) AS [LinkedURL], 
 Max(Case ColumnName WHEN '[Phone Website] ' THEN LastValue ELSE '' END) AS [Phone Website], 
 Max(Case ColumnName WHEN '[RFP] ' THEN LastValue ELSE '' END) AS [RFP], 
 Max(Case ColumnName WHEN '[Purchase From] ' THEN LastValue ELSE '' END) AS [Purchase From]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.VendorsTestOld') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.VendorsTestOld') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.VendorsTestOld') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
