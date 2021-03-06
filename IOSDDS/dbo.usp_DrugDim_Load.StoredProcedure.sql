USE [IOSDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_DrugDim_Load]    Script Date: 12/22/2020 7:05:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_DrugDim_Load]

AS

SET NOCOUNT ON;


BEGIN 
BEGIN TRY

	RETURN

	--BEGIN TRAN

	----Truncate Staging table
	--TRUNCATE TABLE Staging.DrugDim

	----Load Staging
	--INSERT INTO Staging.DrugDim(DrugKey, NDC, GPI, GPPC, DrugName, [Description], Manufacturer, DrugType, UnitofMeasure, Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure
	--							, ControlledDrugClass, WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, RowCreatedDate, DrugTypeLongDescription
	--							, DrugTypeShortDescription, IsGenericNonOTC, IsBrandNonOTC, [BrandNameCode], [BrandNameCodeDescription], StartDateKey, EndDateKey, MultiSourceCode, MultiSourceCodeDescription
	--							)
	--SELECT DrugKey, NDC, GPI, GPPC, DrugName, [Description], Manufacturer, DrugType, UnitofMeasure, Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure
	--, ControlledDrugClass, WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, RowCreatedDate, DrugTypeLongDescription
	--, DrugTypeShortDescription, IsGenericNonOTC, IsBrandNonOTC, [BrandNameCode], [BrandNameCodeDescription], StartDateKey, EndDateKey, MultiSourceCode, MultiSourceCodeDescription
	--FROM DrugMaster.dbo.DrugDim
	--ORDER BY DrugKey ASC 

	----Check to see if FK exist for the DrugDim. If so, drop the FK from the Fact Tables to DrugDim
	--IF (OBJECT_ID('FK_SalesFact_API_DrugKey', 'F') IS NOT NULL)
	--BEGIN

	--	ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_DrugKey]

	--END

	--IF (OBJECT_ID('FK_SalesFact_CAH_DrugKey', 'F') IS NOT NULL)
	--BEGIN

	--	ALTER TABLE [dbo].[SalesFact_CAH] DROP CONSTRAINT [FK_SalesFact_CAH_DrugKey]

	--END
	

	--	--Truncate Archive table
	--	TRUNCATE TABLE Archive.DrugDim;
		
	--	--Switch data in and out to load new data
	--	ALTER TABLE dbo.DrugDim
	--	SWITCH TO Archive.DrugDim;

	--	ALTER TABLE Staging.DrugDim
	--	SWITCH TO dbo.DrugDim;

		
	--	----[Re]Create the FK on the SalesFact_API table
	--	--IF (OBJECT_ID('FK_SalesFact_API_DrugKey', 'F') IS NULL)
	--	--BEGIN

	--	--	ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_DrugKey] FOREIGN KEY([DrugKey])
	--	--	REFERENCES [dbo].[DrugDim] ([DrugKey])

	--	--END

	--	----[Re]Create the FK on the SalesFact_CAH table
	--	--IF (OBJECT_ID('FK_SalesFact_CAH_DrugKey', 'F') IS NULL)
	--	--BEGIN
		
	--	--	ALTER TABLE [dbo].[SalesFact_CAH]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_CAH_DrugKey] FOREIGN KEY([DrugKey])
	--	--	REFERENCES [dbo].[DrugDim] ([DrugKey]);

	--	--END

	--	UPDATE STATISTICS dbo.DrugDim;

	--COMMIT TRAN


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
