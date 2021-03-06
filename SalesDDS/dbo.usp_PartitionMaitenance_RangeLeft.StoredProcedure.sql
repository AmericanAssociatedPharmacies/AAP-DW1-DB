USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_PartitionMaitenance_RangeLeft]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_PartitionMaitenance_RangeLeft]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	BEGIN TRAN

	--ALTER INDEX [NCC_ClaimFactDDS] ON [dbo].[ClaimFactFDS] DISABLE;
	--ALTER INDEX [NCC_EventDimFDS] ON [dbo].[EventDimFDS] DISABLE;

	DECLARE @p1 INT
	, @p2 INT
	, @Partitions INT

	--Get max partition value
	SELECT @p1 = CONVERT(INT, MAX(Value))
	FROM sys.partition_range_values AS r
	INNER JOIN sys.partition_functions pf on pf.function_id = r.function_id
	WHERE pf.name = 'pfSalesFact_RangeLeft'

	/*Get current date plus 30 day. Always, always, always add 30 day. The max partition must always be empty to make any PARTITION SWITCH be a DDL operation. 
	Otherwise, it will be a DML operation, and it will move each row as a RBAR (Row By Agonziing Row) operation. A DDL operation will move all rows
	in about 100 milliseconds.
	*/

	SET @p2 = CONVERT(INT, CONVERT(VARCHAR(20), DATEADD(DAY, 30, GETDATE()),112))

	--If there are enough active partitions, no work to be done and just exit the sproc
	IF (@p1 >= @p2)
	BEGIN

		RETURN
		
	END

	--If there are not enough active partitions, will need to perform a SPLIT on the PARTITION FUNCTION 
	IF (@p1 < @p2)
	BEGIN


		ALTER PARTITION SCHEME [psSalesFact_RangeLeft]
		NEXT USED [SalesFactFG];

		--Get list of partitions to split, aka "create"
		DECLARE C1 CURSOR FOR
		SELECT DateKey
		FROM dbo.DateDim
		WHERE DateKey > @p1
		AND DateKey <= @p2
		ORDER BY DateKey ASC

		--Open cursor
		OPEN C1

		--Get 1st row to process
		FETCH NEXT
		FROM C1
		INTO @Partitions

		WHILE @@FETCH_STATUS = 0
		BEGIN

			--"Split" the PARTITION FUNCTION for new values
			ALTER PARTITION FUNCTION [pfSalesFact_RangeLeft]()
			SPLIT RANGE (@Partitions);

			ALTER PARTITION SCHEME [psSalesFact_RangeLeft]
			NEXT USED [SalesFactFG];

			--Get next row to be processed, if any
			FETCH NEXT
			FROM C1
			INTO @Partitions

		END

		--Close and Deallocate cursor
		CLOSE C1
		DEALLOCATE C1

	COMMIT TRAN

	END

END TRY
BEGIN CATCH


	ROLLBACK TRAN

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



END CATCH

END













GO
