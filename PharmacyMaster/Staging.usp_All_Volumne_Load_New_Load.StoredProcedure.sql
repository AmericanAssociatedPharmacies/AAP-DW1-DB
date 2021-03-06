USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [Staging].[usp_All_Volumne_Load_New_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Staging].[usp_All_Volumne_Load_New_Load]

AS


SET NOCOUNT ON;

BEGIN

	TRUNCATE TABLE [Staging].[ALL_Volume_New];

	SET IDENTITY_INSERT [Staging].[ALL_Volume_New] ON


	INSERT INTO [Staging].[ALL_Volume_New](RowID, Date, PMID, CHAccountNo, DCNum, DCCity, AccountName, Address, City, State, ZIP, APIAccountNo, AAPAccountNo, UDAccountNo, DEA, APICOGAppliedSales, APINetSales
		, APIGENRx, APIGENTotalSrc, APIGENTotalP2P3, APIGENTotal, APIBrand, APIOTC, APIOther, APIGBRPerc, AAPCOGAppliedSales, AAPNetSales, AAPBrand, AAPGENTotal, AAPGENTotalSrc
		, AAPGENExcl, AAPOTC, AAPOther, AAPTotalRX, AAPExcludedFromTotalRX, AAPNonRXOTCandHH, AAPSourceCompliance, UDNetSales, UDBrand, UDGENTotalSrc, UDGENTotal, UDOTC, UDOther
		, UDAdminOnly, CombNetSales, CombBrands, CombOTC, CombGENTotal, CombGENTotalSrc, CombOther, CombAdminOnly, WHAPIBrand, WHAPIBrandUnits, WHAPIGeneric, WHAPIGenericUnits, WHAPIOTC
		, WHAPIOTCUnits, WHAPITotal, MLTotal, AndaTotal, RowCreatedDate, RowUpdatedDate, RowversionID
		)									
	SELECT RowID, Date, PMID, CHAccountNo, DCNum, DCCity, AccountName, Address, City, State, ZIP, APIAccountNo, AAPAccountNo, UDAccountNo, DEA, APICOGAppliedSales, APINetSales
	, APIGENRx, APIGENTotalSrc, APIGENTotalP2P3, APIGENTotal, APIBrand, APIOTC, APIOther, APIGBRPerc, AAPCOGAppliedSales, AAPNetSales, AAPBrand, AAPGENTotal, AAPGENTotalSrc
	, AAPGENExcl, AAPOTC, AAPOther, AAPTotalRX, AAPExcludedFromTotalRX, AAPNonRXOTCandHH, AAPSourceCompliance, UDNetSales, UDBrand, UDGENTotalSrc, UDGENTotal, UDOTC, UDOther
	, UDAdminOnly, CombNetSales, CombBrands, CombOTC, CombGENTotal, CombGENTotalSrc, CombOther, CombAdminOnly, WHAPIBrand, WHAPIBrandUnits, WHAPIGeneric, WHAPIGenericUnits, WHAPIOTC
	, WHAPIOTCUnits, WHAPITotal, MLTotal, AndaTotal, RowCreatedDate, RowUpdatedDate, RowversionID
	FROM ODSIntake.Staging.ALL_Volume_New 
	ORDER BY RowID ASC

	SET IDENTITY_INSERT [Staging].[ALL_Volume_New] OFF

END
GO
