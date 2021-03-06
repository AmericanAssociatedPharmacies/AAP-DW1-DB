USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_Load_DrugDim_old_RES_20191001]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Load_DrugDim_old_RES_20191001]

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [dbo].[DrugDim](NDC, GPI, GPPC, DrugName, Description, Manufacturer, DrugType, UnitofMeasure
		  , Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure, ControlledDrugClass
		  , WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, DrugTypeLongDescription, DrugTypeShortDescription)
	SELECT NDC, GPI, GPPC, DrugName, Description, Manufacturer, DrugType, UnitofMeasure
		  , Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure, ControlledDrugClass
		  , WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, [DrugTypeLongDescription], [DrugTypeShortDescription]
	FROM DrugMaster.[dbo].[DrugDim] AS d
	WHERE NOT EXISTS(SELECT 1
						FROM dbo.DrugDim AS dd
						WHERE d.NDC = dd.NDC
							)
	ORDER BY d.NDC ASC

	--Update for IsGenericCAH column

	--Generics
	UPDATE x
	SET IsCAHGeneric =  1
	FROM [dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'N'

	--Brands
	UPDATE x
	SET IsCAHGeneric =  0
	FROM [dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'B'


END


--TRUNCATE TABLE DrugMaster.[dbo].[DrugDim]

GO
