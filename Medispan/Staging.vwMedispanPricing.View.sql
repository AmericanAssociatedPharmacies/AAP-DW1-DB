USE [Medispan]
GO
/****** Object:  View [Staging].[vwMedispanPricing]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  View [Staging].[vw_Medispan]    Script Date: 12/6/2017 9:15:12 AM ******/
CREATE VIEW [Staging].[vwMedispanPricing]

AS


SELECT AWP.AWP
, dp.DirectPrice
, CMSFUL
, WAC.WAC
, AWP.StartDate
FROM [Medispan_Staging].[dbo].[MF2NDC_H] AS x
CROSS JOIN(SELECT  [NDC_UPC_HRI]
			, Last_Change_Date AS StartDate
			, CONVERT(MONEY, Package_Price) AS AWP
			FROM [Medispan_Staging].[dbo].[MF2PRC_M]
			WHERE Price_Code = 'A'
		) AS AWP
CROSS JOIN(SELECT  [NDC_UPC_HRI]
			, CONVERT(MONEY, Package_Price) AS DirectPrice
			FROM [Medispan_Staging].[dbo].[MF2PRC_M]
			WHERE Price_Code = 'D'
				) AS DP
CROSS JOIN(SELECT  [NDC_UPC_HRI]
			, CONVERT(MONEY, Package_Price) AS CMSFUL
			FROM [Medispan_Staging].[dbo].[MF2PRC_M]
			WHERE Price_Code = 'H'
				) AS CMS
CROSS JOIN(SELECT  [NDC_UPC_HRI]
			, CONVERT(MONEY, Package_Price) AS WAC
			FROM [Medispan_Staging].[dbo].[MF2PRC_M]
			WHERE Price_Code = 'W'
				) AS WAC
WHERE x.NDC_UPC_HRI = AWP.NDC_UPC_HRI
AND x.NDC_UPC_HRI = DP.NDC_UPC_HRI
AND x.NDC_UPC_HRI = CMS.NDC_UPC_HRI
AND x.NDC_UPC_HRI = WAC.NDC_UPC_HRI


GO
