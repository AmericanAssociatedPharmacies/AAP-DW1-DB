USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_Load_DrugDim_PackageQty]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Load_DrugDim_PackageQty]

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [dbo].[DrugDim_PackageQty](NDC, GPI, GPPC, DrugName, Description, Manufacturer, DrugType, UnitofMeasure
		  , Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure, ControlledDrugClass
		  , WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, DrugTypeLongDescription, DrugTypeShortDescription
		  , Package_Quantity)
	SELECT NDC, GPI, GPPC, DrugName, Description, Manufacturer, DrugType, UnitofMeasure
		  , Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure, ControlledDrugClass
		  , WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, [DrugTypeLongDescription], [DrugTypeShortDescription]
		  , [Package_Quantity]
	FROM DrugMaster.[dbo].[DrugDim_PackageQty] AS d
	WHERE NOT EXISTS(SELECT 1
						FROM dbo.DrugDim_PackageQty AS dd
						WHERE d.NDC = dd.NDC
							)
	ORDER BY d.NDC ASC


END


--TRUNCATE TABLE DrugMaster.[dbo].[DrugDim]
GO
