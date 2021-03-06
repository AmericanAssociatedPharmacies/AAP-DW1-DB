USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_DrugDim_Load]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_DrugDim_Load]

AS

SET NOCOUNT ON;


BEGIN 
BEGIN TRY

	BEGIN TRAN

	--Truncate Staging table
	TRUNCATE TABLE Staging.DrugDim

	--Load Staging
	INSERT INTO Staging.DrugDim(DrugKey, NDC, GPI, GPPC, DrugName, [Description], Manufacturer, DrugType, UnitofMeasure, Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure
								, ControlledDrugClass, WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, RowCreatedDate, DrugTypeLongDescription
								, DrugTypeShortDescription, IsGenericNonOTC, IsBrandNonOTC, [BrandNameCode], [BrandNameCodeDescription], StartDateKey, EndDateKey, MultiSourceCode, MultiSourceCodeDescription
								, [PackageQuantity], IsCAHGeneric, [IsAPITier1], [IsAPITier2], [APIGroupID]
								)
	SELECT DrugKey, NDC, GPI, GPPC, DrugName, [Description], Manufacturer, DrugType, UnitofMeasure, Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure
	, ControlledDrugClass, WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, RowCreatedDate, DrugTypeLongDescription
	, DrugTypeShortDescription, IsGenericNonOTC, IsBrandNonOTC, [BrandNameCode], [BrandNameCodeDescription], StartDateKey, EndDateKey, MultiSourceCode, MultiSourceCodeDescription
	, [PackageQuantity], IsCAHGeneric, [IsAPITier1], [IsAPITier2], [APIGroupID]
	FROM DrugMaster.dbo.DrugDim
	ORDER BY DrugKey ASC 

	--Drop DrugDim FK's
	IF (OBJECT_ID('FK_PriceFact_DrugKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[PriceFact] DROP CONSTRAINT FK_PriceFact_DrugKey

	END	

	--Truncate Archive table
	TRUNCATE TABLE Archive.DrugDim;
		
	--Switch data in and out to load new data
	ALTER TABLE dbo.DrugDim
	SWITCH TO Archive.DrugDim;

	ALTER TABLE Staging.DrugDim
	SWITCH TO dbo.DrugDim;

	--Recreate DrugDim FK's	
	IF (OBJECT_ID('FK_PriceFact_DrugKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[PriceFact]  WITH NOCHECK ADD  CONSTRAINT FK_PriceFact_DrugKey FOREIGN KEY([DrugKey])
		REFERENCES [dbo].[DrugDim] ([DrugKey])

	END

	UPDATE STATISTICS dbo.DrugDim;

	COMMIT TRAN

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


END TRY
BEGIN CATCH

	DECLARE @ErrorMessage NVARCHAR(4000)
        , @ErrorNumber INT
        , @ErrorSeverity INT
        , @ErrorState INT
        , @ErrorLine INT
        , @ErrorProcedure NVARCHAR(200)

		SELECT 
        @ErrorNumber = ERROR_NUMBER()
        , @ErrorSeverity = ERROR_SEVERITY()
        , @ErrorState = ERROR_STATE()
        , @ErrorLine = ERROR_LINE()
        , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-')
		, @ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (@ErrorMessage 
        , @ErrorSeverity, 1               
        , @ErrorNumber    -- parameter: original error number.
        , @ErrorSeverity  -- parameter: original error severity.
        , @ErrorState     -- parameter: original error state.
        , @ErrorProcedure -- parameter: original error procedure name.
        , @ErrorLine       -- parameter: original error line number.
        );

	
	--Rollback the entire transaction if any error occurs
	ROLLBACK TRAN


END CATCH
END








GO
