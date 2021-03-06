USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_DrugDim_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
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
								, [PackageQuantity], IsCAHGeneric, [IsAPITier1], [IsAPITier2], [APIGroupID], IsGeneric, IsSPX, GPIKey
								)
	SELECT DrugKey, NDC, GPI, GPPC, DrugName, [Description], Manufacturer, DrugType, UnitofMeasure, Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure
	, ControlledDrugClass, WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, RowCreatedDate, DrugTypeLongDescription
	, DrugTypeShortDescription, IsGenericNonOTC, IsBrandNonOTC, [BrandNameCode], [BrandNameCodeDescription], StartDateKey, EndDateKey, MultiSourceCode, MultiSourceCodeDescription
	, [PackageQuantity], IsCAHGeneric, [IsAPITier1], [IsAPITier2], [APIGroupID], IsGeneric, IsSPX, GPIKey
	FROM DrugMaster.dbo.DrugDim
	ORDER BY DrugKey ASC 

	--Drop DrugDim FK's
	IF (OBJECT_ID('FK_ClaimFactFDS_DrugKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactFDS] DROP CONSTRAINT [FK_ClaimFactFDS_DrugKey]

	END	

	IF (OBJECT_ID('FK_ClaimFactRX30_DrugKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30] DROP CONSTRAINT [FK_ClaimFactRX30_DrugKey]

	END

	----Drop partitioned index on indexed view
	--IF EXISTS(SELECT 1
	--		FROM sys.sysindexes
	--		WHERE name = 'CI_vwMACAnalysis'
	--		)

	--BEGIN

	--	DROP INDEX [CI_vwMACAnalysis] ON [dbo].[vwMACAnalysis] WITH ( ONLINE = OFF )

	--END

		--Truncate Archive table
		TRUNCATE TABLE Archive.DrugDim;
		
		--Switch data in and out to load new data
		ALTER TABLE dbo.DrugDim
		SWITCH TO Archive.DrugDim;

		ALTER TABLE Staging.DrugDim
		SWITCH TO dbo.DrugDim;

	--Recreate DrugDim FK's	
	IF (OBJECT_ID('FK_ClaimFactFDS_DrugKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactFDS]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactFDS_DrugKey] FOREIGN KEY([DrugKey])
		REFERENCES [dbo].[DrugDim] ([DrugKey])

	END

	IF (OBJECT_ID('FK_ClaimFactRX30_DrugKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactRX30_DrugKey] FOREIGN KEY([DrugKey])
		REFERENCES [dbo].[DrugDim] ([DrugKey])

	END

	----Recreate partitioned index on indexed view
	--IF NOT EXISTS(SELECT 1
	--			FROM sys.sysindexes
	--			WHERE name = 'CI_vwMACAnalysis'
	--			)

	--BEGIN

	--	SET NUMERIC_ROUNDABORT OFF;  
	--	SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,  
	--	QUOTED_IDENTIFIER, ANSI_NULLS ON;  


	--	CREATE UNIQUE CLUSTERED INDEX CI_vwMACAnalysis
	--	ON dbo.vwMACAnalysis(PharmacyKey, DrugKey, EventKey, DateOfServiceKey)
	--	ON [psClaimFact](DateOfServiceKey)

	--END

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
