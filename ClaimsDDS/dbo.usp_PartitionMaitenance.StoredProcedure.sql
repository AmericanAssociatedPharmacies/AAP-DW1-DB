USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_PartitionMaitenance]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [dbo].[usp_PartitionMaitenance]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	BEGIN TRAN

	ALTER INDEX [NCC_ClaimFactDDS] ON [dbo].[ClaimFactFDS] DISABLE;
	ALTER INDEX [NCC_EventDimFDS] ON [dbo].[EventDimFDS] DISABLE;

	DECLARE @p1 INT
	, @p2 INT
	, @Partitions INT

	--Get max partition value
	SELECT @p1 = CONVERT(INT, MAX(Value))
	FROM sys.partition_range_values

	/*Get current date plus 1 day. Always, always, always add 1 day. The max partition must always be empty to make any PARTITION SWITCH be a DDL operation. 
	Otherwise, it will be a DML operation, and it will move each row as a RBAR (Row By Agonziing Row) operation. A DDL operation will move all rows
	in about 100 milliseconds.
	*/

	SET @p2 = CONVERT(INT, CONVERT(VARCHAR(20), DATEADD(DAY, 30, GETDATE()),112))

		--Make sure after each SPLIT or MERGE this code is executed. It may be executed any time.

		ALTER PARTITION SCHEME [psClaimFact]
		NEXT USED ClaimFactFG ;

		ALTER PARTITION SCHEME [psEventDim]
		NEXT USED EventDimFG;

		ALTER PARTITION SCHEME [psClaimFactFDS]
		NEXT USED ClaimFactFDS;

		--Get list of partitions to split, aka "create"
		DECLARE C1 CURSOR FOR
		SELECT DateKey
		FROM dbo.DateDim
		WHERE DateKey > @p1
		AND DateKey <= @p2

		--Open cursor
		OPEN C1

		--Get 1st row to process
		FETCH NEXT
		FROM C1
		INTO @Partitions

		WHILE @@FETCH_STATUS = 0
		BEGIN

			--"Split" the PARTITION FUNCTION for new values
			ALTER PARTITION FUNCTION [pfClaimDDS]()
			SPLIT RANGE (@Partitions);

			ALTER PARTITION SCHEME [psClaimFact]
			NEXT USED ClaimFactFG;

			ALTER PARTITION SCHEME [psEventDim]
			NEXT USED EventDimFG;

			ALTER PARTITION SCHEME [psClaimFactFDS]
			NEXT USED ClaimFactFDS;

			--Get next row to be processed, if any
			FETCH NEXT
			FROM C1
			INTO @Partitions

		END

		--Close and Deallocate cursor
		CLOSE C1
		DEALLOCATE C1

		--Make sure after each SPLIT or MERGE this code is executed. It may be executed any time.
		ALTER PARTITION SCHEME [psClaimFact]
		NEXT USED ClaimFactFG;

		ALTER PARTITION SCHEME [psEventDim]
		NEXT USED EventDimFG;

		ALTER PARTITION SCHEME [psClaimFactFDS]
		NEXT USED ClaimFactFDS;

	ALTER INDEX [NCC_ClaimFactDDS] ON [dbo].[ClaimFactFDS] REBUILD;
	ALTER INDEX [NCC_EventDimFDS] ON [dbo].[EventDimFDS] REBUILD;

	COMMIT TRAN

	

END TRY
BEGIN CATCH

	--Make sure to close and deallocate CURSOR
	CLOSE C1
	DEALLOCATE C1

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

	ROLLBACK TRAN

END CATCH

END











GO
