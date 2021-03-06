USE [PharmacyMaster]
GO
/****** Object:  View [Staging].[vw_VendorAccts]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [Staging].[vw_VendorAccts]

AS



SELECT dt.PMID
, dt.new_wholesalername
, dt.VendorID
, dt.IsPrimary
, dt.VendAcctNum
, dt.PVA
, dt.PaymentTerms
, dt.Source
, dt.PVAEffectiveDate
, dt.RowVersion
FROM(SELECT ROW_NUMBER() OVER(PARTITION BY new_PMID ORDER BY (SELECT NULL)) AS RN
		, new_PMID AS PMID
		, new_wholesalername
		, 37 AS VendorID
		--, CASE 
		--	WHEN new_wholesalername LIKE '%Cardinal' THEN 37
		--	WHEN new_wholesalername LIKE '%Miami%' THEN 44
		--	ELSE 37
		--	END AS VendorID
		, 1 AS IsPrimary
		, 0 AS [VendAcctNum]
		, NULL AS PVA
		, NULL AS PaymentTerms
		, 'AAP' AS Source
		, NULL AS PVAEffectiveDate
		, 1 AS RowVersion
		--FROM ODSIntake.Staging.CRM_AccountEntity
		FROM DynamicsODS.[dbo].[CRM_AccountEntity_User]
		WHERE new_PMID IS NOT NULL
		) AS dt
WHERE dt.RN = 1




GO
