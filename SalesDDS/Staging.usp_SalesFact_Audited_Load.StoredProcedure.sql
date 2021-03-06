USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_SalesFact_Audited_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_SalesFact_Audited_Load]

AS

SET NOCOUNT ON;

BEGIN

	TRUNCATE TABLE [Staging].[SalesFact_Audited];


	INSERT INTO [Staging].[SalesFact_Audited] (DateKey, PharmacyKey, APICOGAppliedSales, APINetSales, APIGENRx, APIGENTotalSrc, APIGENTotalP2P3, APIGENTotal, APIBrand, APIOTC, APIOther, APIGBRPerc, AAPCOGAppliedSales, AAPNetSales
	, AAPBrand, AAPGENTotal, AAPGENTotalSrc, AAPGENExcl, AAPOTC, AAPOther, AAPTotalRX, AAPExcludedFromTotalRX, AAPNonRXOTCandHH, AAPSourceCompliance, UDNetSales, UDBrand, UDGENTotalSrc
	, UDGENTotal, UDOTC, UDOther, UDAdminOnly, CombNetSales, CombBrands, CombOTC, CombGENTotal, CombGENTotalSrc, CombOther, CombAdminOnly, WHAPIBrand, WHAPIBrandUnits, WHAPIGeneric
	, WHAPIGenericUnits, WHAPIOTC, WHAPIOTCUnits, WHAPITotal, MLTotal, AndaTotal)
	SELECT DateKey, PharmacyKey, APICOGAppliedSales, APINetSales, APIGENRx, APIGENTotalSrc, APIGENTotalP2P3, APIGENTotal, APIBrand, APIOTC, APIOther, APIGBRPerc, AAPCOGAppliedSales, AAPNetSales
	, AAPBrand, AAPGENTotal, AAPGENTotalSrc, AAPGENExcl, AAPOTC, AAPOther, AAPTotalRX, AAPExcludedFromTotalRX, AAPNonRXOTCandHH, AAPSourceCompliance, UDNetSales, UDBrand, UDGENTotalSrc
	, UDGENTotal, UDOTC, UDOther, UDAdminOnly, CombNetSales, CombBrands, CombOTC, CombGENTotal, CombGENTotalSrc, CombOther, CombAdminOnly, WHAPIBrand, WHAPIBrandUnits, WHAPIGeneric
	, WHAPIGenericUnits, WHAPIOTC, WHAPIOTCUnits, WHAPITotal, MLTotal, AndaTotal
	FROM [Staging].[vwSalesFact_Audited]
	ORDER BY DateKey ASC, PharmacyKey ASC

	UPDATE STATISTICS [Staging].[SalesFact_Audited]

END



GO
