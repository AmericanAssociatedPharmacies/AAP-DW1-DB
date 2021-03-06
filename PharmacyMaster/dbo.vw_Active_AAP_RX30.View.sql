USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vw_Active_AAP_RX30]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Active_AAP_RX30]

AS



	SELECT TOP 100 PERCENT dt.ServiceProviderID, dt.AccountName
	FROM(SELECT LTRIM(RTRIM(NCPDP)) AS ServiceProviderID
		, LTRIM(RTRIM([AccountName])) AS AccountName
		FROM [dbo].[PM_Pharmacy]
		WHERE AAPQuitDate IS NULL
		AND NCPDP IS NOT NULL

		UNION ALL

		SELECT NPI
		, LTRIM(RTRIM([AccountName])) AS AccountName
		FROM [dbo].[PM_Pharmacy]
		WHERE AAPQuitDate IS NULL
		AND NPI IS NOT NULL
		) AS dt
ORDER BY dt.AccountName ASC

GO
