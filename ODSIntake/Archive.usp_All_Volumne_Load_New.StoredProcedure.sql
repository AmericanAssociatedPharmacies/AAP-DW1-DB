USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Archive].[usp_All_Volumne_Load_New]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Archive].[usp_All_Volumne_Load_New]

AS


SET NOCOUNT ON;

BEGIN


INSERT INTO [Archive].[ALL_Volume_New](Date, PMID, CHAccountNo, DCNum, DCCity, AccountName, Address, City, State, ZIP, APIAccountNo, AAPAccountNo, UDAccountNo, DEA, APICOGAppliedSales, APINetSales
	, APIGENRx, APIGENTotalSrc, APIGENTotalP2P3, APIGENTotal, APIBrand, APIOTC, APIOther, APIGBRPerc, AAPCOGAppliedSales, AAPNetSales, AAPBrand, AAPGENTotal, AAPGENTotalSrc
	, AAPGENExcl, AAPOTC, AAPOther, AAPTotalRX, AAPExcludedFromTotalRX, AAPNonRXOTCandHH, AAPSourceCompliance, UDNetSales, UDBrand, UDGENTotalSrc, UDGENTotal, UDOTC, UDOther
	, UDAdminOnly, CombNetSales, CombBrands, CombOTC, CombGENTotal, CombGENTotalSrc, CombOther, CombAdminOnly, WHAPIBrand, WHAPIBrandUnits, WHAPIGeneric, WHAPIGenericUnits, WHAPIOTC
	, WHAPIOTCUnits, WHAPITotal, MLTotal, AndaTotal, RowCreatedDate, RowUpdatedDate, RowversionID
	)									
SELECT Date, PMID, CHAccountNo, DCNum, DCCity, AccountName, Address, City, State, ZIP, APIAccountNo, AAPAccountNo, UDAccountNo, DEA, APICOGAppliedSales, APINetSales
, APIGENRx, APIGENTotalSrc, APIGENTotalP2P3, APIGENTotal, APIBrand, APIOTC, APIOther, APIGBRPerc, AAPCOGAppliedSales, AAPNetSales, AAPBrand, AAPGENTotal, AAPGENTotalSrc
, AAPGENExcl, AAPOTC, AAPOther, AAPTotalRX, AAPExcludedFromTotalRX, AAPNonRXOTCandHH, AAPSourceCompliance, UDNetSales, UDBrand, UDGENTotalSrc, UDGENTotal, UDOTC, UDOther
, UDAdminOnly, CombNetSales, CombBrands, CombOTC, CombGENTotal, CombGENTotalSrc, CombOther, CombAdminOnly, WHAPIBrand, WHAPIBrandUnits, WHAPIGeneric, WHAPIGenericUnits, WHAPIOTC
, WHAPIOTCUnits, WHAPITotal, MLTotal, AndaTotal, RowCreatedDate, RowUpdatedDate, RowversionID
FROM Staging.ALL_Volume_New 

END
GO
