USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vNCPDPProviderInformation_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vNCPDPProviderInformation_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[NCPDP] ' THEN LastValue ELSE '' END) AS [NCPDP], 
 Max(Case ColumnName WHEN '[Legal Business Name] ' THEN LastValue ELSE '' END) AS [Legal Business Name], 
 Max(Case ColumnName WHEN '[Name] ' THEN LastValue ELSE '' END) AS [Name], 
 Max(Case ColumnName WHEN '[Store Number] ' THEN LastValue ELSE '' END) AS [Store Number], 
 Max(Case ColumnName WHEN '[Physical Location Address 1] ' THEN LastValue ELSE '' END) AS [Physical Location Address 1], 
 Max(Case ColumnName WHEN '[Physical Location Address 2] ' THEN LastValue ELSE '' END) AS [Physical Location Address 2], 
 Max(Case ColumnName WHEN '[Physical Location City] ' THEN LastValue ELSE '' END) AS [Physical Location City], 
 Max(Case ColumnName WHEN '[Physical Location State Code] ' THEN LastValue ELSE '' END) AS [Physical Location State Code], 
 Max(Case ColumnName WHEN '[Physical Location Zip code] ' THEN LastValue ELSE '' END) AS [Physical Location Zip code], 
 Max(Case ColumnName WHEN '[Physical Location Phone Number] ' THEN LastValue ELSE '' END) AS [Physical Location Phone Number], 
 Max(Case ColumnName WHEN '[Physical Location Extension] ' THEN LastValue ELSE '' END) AS [Physical Location Extension], 
 Max(Case ColumnName WHEN '[Physical Location FAX] ' THEN LastValue ELSE '' END) AS [Physical Location FAX], 
 Max(Case ColumnName WHEN '[Physical Location E-Mail Address] ' THEN LastValue ELSE '' END) AS [Physical Location E-Mail Address], 
 Max(Case ColumnName WHEN '[Physical Location Cross Street or Directions] ' THEN LastValue ELSE '' END) AS [Physical Location Cross Street or Directions], 
 Max(Case ColumnName WHEN '[Physical Location County or Parish] ' THEN LastValue ELSE '' END) AS [Physical Location County or Parish], 
 Max(Case ColumnName WHEN '[Physical Location MSA] ' THEN LastValue ELSE '' END) AS [Physical Location MSA], 
 Max(Case ColumnName WHEN '[Physical Location PMSA] ' THEN LastValue ELSE '' END) AS [Physical Location PMSA], 
 Max(Case ColumnName WHEN '[Physical Location 24 Hour Operation Flag] ' THEN LastValue ELSE '' END) AS [Physical Location 24 Hour Operation Flag], 
 Max(Case ColumnName WHEN '[Physical Location Provider Hours] ' THEN LastValue ELSE '' END) AS [Physical Location Provider Hours], 
 Max(Case ColumnName WHEN '[Physical Location Accepts E-Prescriptions] ' THEN LastValue ELSE '' END) AS [Physical Location Accepts E-Prescriptions], 
 Max(Case ColumnName WHEN '[Physical Location Delivery Service] ' THEN LastValue ELSE '' END) AS [Physical Location Delivery Service], 
 Max(Case ColumnName WHEN '[Physical Location Compounding Service] ' THEN LastValue ELSE '' END) AS [Physical Location Compounding Service], 
 Max(Case ColumnName WHEN '[Physical Location Drive-up Window] ' THEN LastValue ELSE '' END) AS [Physical Location Drive-up Window], 
 Max(Case ColumnName WHEN '[Physical Location Durable Medical Equipment] ' THEN LastValue ELSE '' END) AS [Physical Location Durable Medical Equipment], 
 Max(Case ColumnName WHEN '[Physical Location Congressional Voting District] ' THEN LastValue ELSE '' END) AS [Physical Location Congressional Voting District], 
 Max(Case ColumnName WHEN '[Physical Location Language Code 1] ' THEN LastValue ELSE '' END) AS [Physical Location Language Code 1], 
 Max(Case ColumnName WHEN '[Physical Location Language Code 2] ' THEN LastValue ELSE '' END) AS [Physical Location Language Code 2], 
 Max(Case ColumnName WHEN '[Physical Location Language Code 3] ' THEN LastValue ELSE '' END) AS [Physical Location Language Code 3], 
 Max(Case ColumnName WHEN '[Physical Location Language Code 4] ' THEN LastValue ELSE '' END) AS [Physical Location Language Code 4], 
 Max(Case ColumnName WHEN '[Physical Location Language Code 5] ' THEN LastValue ELSE '' END) AS [Physical Location Language Code 5], 
 Max(Case ColumnName WHEN '[Physical Location Handicap Access Flag] ' THEN LastValue ELSE '' END) AS [Physical Location Handicap Access Flag], 
 Max(Case ColumnName WHEN '[Physical Location Store Open Date] ' THEN LastValue ELSE '' END) AS [Physical Location Store Open Date], 
 Max(Case ColumnName WHEN '[Physical Location Store Closure Date] ' THEN LastValue ELSE '' END) AS [Physical Location Store Closure Date], 
 Max(Case ColumnName WHEN '[Mailing Address 1] ' THEN LastValue ELSE '' END) AS [Mailing Address 1], 
 Max(Case ColumnName WHEN '[Mailing Address 2] ' THEN LastValue ELSE '' END) AS [Mailing Address 2], 
 Max(Case ColumnName WHEN '[Mailing Address City] ' THEN LastValue ELSE '' END) AS [Mailing Address City], 
 Max(Case ColumnName WHEN '[Mailing Address State Code] ' THEN LastValue ELSE '' END) AS [Mailing Address State Code], 
 Max(Case ColumnName WHEN '[Mailing Address Zip Code] ' THEN LastValue ELSE '' END) AS [Mailing Address Zip Code], 
 Max(Case ColumnName WHEN '[Contact Last Name] ' THEN LastValue ELSE '' END) AS [Contact Last Name], 
 Max(Case ColumnName WHEN '[Contact First Name] ' THEN LastValue ELSE '' END) AS [Contact First Name], 
 Max(Case ColumnName WHEN '[Contact Middle Initial] ' THEN LastValue ELSE '' END) AS [Contact Middle Initial], 
 Max(Case ColumnName WHEN '[Contact Title] ' THEN LastValue ELSE '' END) AS [Contact Title], 
 Max(Case ColumnName WHEN '[Contact Phone Number] ' THEN LastValue ELSE '' END) AS [Contact Phone Number], 
 Max(Case ColumnName WHEN '[Contact Extension] ' THEN LastValue ELSE '' END) AS [Contact Extension], 
 Max(Case ColumnName WHEN '[Contact E-mail Address] ' THEN LastValue ELSE '' END) AS [Contact E-mail Address], 
 Max(Case ColumnName WHEN '[Dispenser Class Code] ' THEN LastValue ELSE '' END) AS [Dispenser Class Code], 
 Max(Case ColumnName WHEN '[Primary Dispenser Type Code] ' THEN LastValue ELSE '' END) AS [Primary Dispenser Type Code], 
 Max(Case ColumnName WHEN '[Secondary Dispenser Type Code] ' THEN LastValue ELSE '' END) AS [Secondary Dispenser Type Code], 
 Max(Case ColumnName WHEN '[Tertiary Dispenser Type Code] ' THEN LastValue ELSE '' END) AS [Tertiary Dispenser Type Code], 
 Max(Case ColumnName WHEN '[Medicare Provider (supplier) ID] ' THEN LastValue ELSE '' END) AS [Medicare Provider (supplier) ID], 
 Max(Case ColumnName WHEN '[NPI] ' THEN LastValue ELSE '' END) AS [NPI], 
 Max(Case ColumnName WHEN '[DEA] ' THEN LastValue ELSE '' END) AS [DEA], 
 Max(Case ColumnName WHEN '[Federal Tax ID Number] ' THEN LastValue ELSE '' END) AS [Federal Tax ID Number], 
 Max(Case ColumnName WHEN '[State License Number] ' THEN LastValue ELSE '' END) AS [State License Number], 
 Max(Case ColumnName WHEN '[State Income Tax ID NUmber] ' THEN LastValue ELSE '' END) AS [State Income Tax ID NUmber], 
 Max(Case ColumnName WHEN '[Delete Date] ' THEN LastValue ELSE '' END) AS [Delete Date], 
 Max(Case ColumnName WHEN '[Transaction Code] ' THEN LastValue ELSE '' END) AS [Transaction Code], 
 Max(Case ColumnName WHEN '[Transaction Date] ' THEN LastValue ELSE '' END) AS [Transaction Date], 
 Max(Case ColumnName WHEN '[Filler] ' THEN LastValue ELSE '' END) AS [Filler], 
 Max(Case ColumnName WHEN '[EndLine] ' THEN LastValue ELSE '' END) AS [EndLine]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.NCPDPProviderInformation') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.NCPDPProviderInformation') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.NCPDPProviderInformation') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
