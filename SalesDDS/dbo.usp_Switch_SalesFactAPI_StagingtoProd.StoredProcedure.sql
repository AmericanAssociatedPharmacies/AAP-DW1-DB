USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Switch_SalesFactAPI_StagingtoProd]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_Switch_SalesFactAPI_StagingtoProd]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	IF (SELECT COUNT(*)
		FROM sys.partitions AS A
		INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
		WHERE object_id = OBJECT_ID('Staging.SalesFact_API')
		AND index_id = 1
		AND A.rows > 0	
		) = 0

		BEGIN

			RETURN

		END

	ELSE



	BEGIN TRAN

	DECLARE @p1 INT

	--Get valued for cursor
	DECLARE PS CURSOR FOR
	SELECT A.partition_number
	FROM sys.partitions AS A
	INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
	WHERE object_id = OBJECT_ID('Staging.SalesFact_API')
	AND index_id = 1
	AND A.rows > 0

	--Open cursor
	OPEN PS

	--Get 1st from cursor
	FETCH NEXT
	FROM PS
	INTO @P1

	--While the cursor isn't doing anything, execute SQL script
	WHILE @@FETCH_STATUS = 0
	BEGIN

		--Switch data from Staging into Prod
		ALTER TABLE Staging.SalesFact_API
		SWITCH PARTITION @P1 
		TO dbo.SalesFact_API PARTITION @P1

		--Get next row to process
		FETCH NEXT
		FROM PS
		INTO @P1

	END

	--Close cursor
	CLOSE PS
	--Deallocate cursor from memory
	DEALLOCATE PS

	COMMIT TRAN

END TRY
BEGIN CATCH

	--Close cursor
	CLOSE PS
	--Deallocate cursor from memory
	DEALLOCATE PS
	
	DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);

		SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-'),
		@ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );

		ROLLBACK TRAN
	

END CATCH

END







GO
