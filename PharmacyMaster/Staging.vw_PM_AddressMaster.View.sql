USE [PharmacyMaster]
GO
/****** Object:  View [Staging].[vw_PM_AddressMaster]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [Staging].[vw_PM_AddressMaster]

AS

SELECT odt.PMID
, odt.[Address_Type_Id]
, odt.[Address]
, odt.[Address2]
, odt.City
, odt.County
, odt.[State]
, odt.Zip
, odt.[ContactFullName]
, odt.Fax
, odt.Phone
, odt.[AlternatePhone]
, odt.Email
, odt.[Modified]
, odt.[RowVersion]
, odt.DateKey
FROM(SELECT ROW_NUMBER() OVER(PARTITION BY dt.PMID, dt.Address_Type_Id ORDER BY(SELECT NULL)) AS RN
		, CONVERT(INT, dt.PMID) AS PMID
		, CONVERT(INT, dt.Address_Type_Id) AS [Address_Type_Id]
		, CONVERT(VARCHAR(100), dt.Address) AS [Address]
		, CONVERT(VARCHAR(100), dt.Address2) AS [Address2]
		, CONVERT(VARCHAR(50), dt.City) AS City
		, CONVERT(VARCHAR(100), dt.County) AS County
		, CONVERT(VARCHAR(2), dt.State) AS [State]
		, CONVERT(VARCHAR(50), dt.Zip) AS Zip
		, CONVERT(VARCHAR(255), dt.ContactFullName) AS [ContactFullName]
		, CONVERT(VARCHAR(50), dt.Fax) AS Fax
		, CONVERT(VARCHAR(50), dt.Phone) AS Phone
		, CONVERT(VARCHAR(12), dt.AlternatePhone) AS [AlternatePhone]
		, CONVERT(VARCHAR(150), dt.Email) AS Email
		, CONVERT(DATETIME, dt.Modified) AS [Modified]
		, CONVERT(INT, dt.RowVersion) AS [RowVersion]
		, CONVERT(INT, dt.DateKey) AS DateKey
		FROM(SELECT 1 AS [Address_Type_Id] -- Physical Address
				, c.new_pmid AS PMID
				, a.address1_line1 AS [Address]
				, a.address1_line2 AS [Address2]
				, a.address1_city AS City
				, a.address1_county AS County
				, a.address1_stateorprovince AS [State]
				, a.address1_postalcode AS Zip
				, c.new_pharmacyownerlookupname AS ContactFullName
				, b.fax AS Fax
				, b.telephone1 AS Phone
				, b.telephone2 AS [AlternatePhone]
				, a.emailaddress1 AS Email
				, GETDATE() AS [Modified] 
				, 1 AS [RowVersion]
				, a.DateKey
				FROM [DynamicsODS].[dbo].[CRM_AccountEntity_Address] AS a
				INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_sys] AS b ON a.accountid = b.accountid 
				INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_User] AS c ON a.accountid = c.accountid 
				WHERE new_pmid IS NOT NULL
				AND b.statuscodename <> 'Prospect'

				UNION 

				SELECT 2 AS [Address_Type_Id] -- Mailing Address
				, CONVERT(INT, new_pmid) AS PMID
				, a.address2_line1 AS [Address]
				, a.address2_line2 AS [Address2]
				, a.address2_city AS City
				, a.address2_county AS County
				, a.address2_stateorprovince AS [State]
				, a.address2_postalcode AS Zip
				, c.new_pharmacyownerlookupname AS ContactFullName
				, b.fax AS Fax
				, b.telephone1 AS Phone
				, b.telephone2 AS [AlternatePhone]
				, a.emailaddress1 AS Email
				, GETDATE() AS [Modified] 
				, 1 AS [RowVersion]
				, a.DateKey
				FROM [DynamicsODS].[dbo].[CRM_AccountEntity_Address] AS a
				INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_sys] AS b ON a.accountid = b.accountid 
				INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_User] AS c ON a.accountid = c.accountid  
				WHERE new_pmid IS NOT NULL
				AND b.statuscodename <> 'Prospect'

				UNION

				SELECT 3 AS [Address_Type_Id] -- Financial Address
				, CONVERT(INT, new_pmid) AS PMID
				, a.new_financialstreet1 AS [Address]
				, a.new_financialstreet2 AS [Address2]
				, a.new_financialcity AS City
				, a.address1_county AS County
				, a.new_financialstate AS [State]
				, a.new_financialzip AS Zip
				, c.new_pharmacyownerlookupname AS ContactFullName
				, b.fax AS Fax
				, b.telephone1 AS Phone
				, b.telephone2 AS [AlternatePhone]
				, a.emailaddress2 AS Email
				, GETDATE() AS [Modified] 
				, 1 AS [RowVersion]
				, a.DateKey
				FROM [DynamicsODS].[dbo].[CRM_AccountEntity_Address] AS a
				INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_sys] AS b ON a.accountid = b.accountid 
				INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_User] AS c ON a.accountid = c.accountid  
				WHERE new_pmid IS NOT NULL
				AND b.statuscodename <> 'Prospect'

			) AS dt
) AS odt
WHERE odt.RN = 1




GO
