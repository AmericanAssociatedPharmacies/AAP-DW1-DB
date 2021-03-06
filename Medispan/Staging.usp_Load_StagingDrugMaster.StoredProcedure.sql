USE [Medispan]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_StagingDrugMaster]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_Load_StagingDrugMaster]


AS


SET NOCOUNT ON;

BEGIN

	INSERT INTO Staging.DrugMaster(NDC, GPI, DrugName, MFG, DrugType, DrugTypeShort, Unit, Form, PS, PD, RxOTC, Repack, GPIDesc, Strength
									, Strength_Unit_Measure, OBSDTEC, DEA, WACPkg, WAC, WACEffDate, AWPPkg, AWP, BBDC, MSC, BNC, CSP, DESI, DEA_Class_Code
									, RouteAdmin, RX_OTC_Indicator_Code, [Unit_Dose_Unit_of_Use_Package], AHFSCC_Therapeutic_Class_Code, GPPC, NDC_10, IDCode
									, PackageQuantity
									)
	SELECT NDC, GPI, DrugName, MFG, DrugType, DrugTypeShort, Unit, Form, PS, PD, RxOTC, Repack, GPIDesc, Strength
	, Strength_Unit_of_Measure, OBSDTEC, DEA, WACPkg, WAC, WACEffDate, AWPPkg, AWP, BBDC, MSC, BNC, CSP, DESI, DEA_Class_Code
	, RouteAdmin, RX_OTC_Indicator_Code, Unit_DoseUnit_of_Use_Package, AHFSCC_Therapeutic_Class_Code, GPPC, NDC_10, IDCode
	, PackageQuantity
	FROM Staging.vwDrugMaster

END

GO
