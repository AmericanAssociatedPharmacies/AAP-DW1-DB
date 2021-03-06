USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Switch_SalesFactRX30_StagingtoProd]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_Switch_SalesFactRX30_StagingtoProd]

	

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY
	
	DECLARE @PartitionID INT
	, @RowCount INT

	--Check row count
	SELECT @RowCount = COUNT(*)
	FROM(SELECT A.partition_number
		FROM sys.partitions AS A
		INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
		WHERE object_id = OBJECT_ID('Staging.ClaimFactRX30_PreLoad')
		AND index_id = 1
		AND A.rows > 0
		) AS dt
	INNER JOIN (SELECT A.partition_number
				FROM sys.partitions AS A
				INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
				WHERE object_id = OBJECT_ID('dbo.ClaimFactRX30')
				AND index_id = 1
				AND A.rows = 0
				) AS dt2 ON dt.partition_number = dt2.partition_number
	

	--If not rows to process, exit sproc
	IF @RowCount = 0
	BEGIN

		RETURN

	END

	ELSE

	BEGIN TRAN

	DECLARE C1 CURSOR FOR 
	SELECT CONVERT(INT, dt.partition_number) AS PartitionID
	FROM(SELECT A.partition_number
		FROM sys.partitions AS A
		INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
		WHERE object_id = OBJECT_ID('Staging.ClaimFactRX30_PreLoad')
		AND index_id = 1
		AND A.rows > 0
		) AS dt
	INNER JOIN (SELECT A.partition_number
				FROM sys.partitions AS A
				INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
				WHERE object_id = OBJECT_ID('dbo.ClaimFactRX30')
				AND index_id = 1
				AND A.rows = 0
				) AS dt2 ON dt.partition_number = dt2.partition_number
	ORDER BY dt.partition_number ASC

	OPEN C1

	FETCH NEXT
	FROM C1
	INTO @PartitionID


	WHILE @@FETCH_STATUS = 0
	BEGIN

		--Switch data from Staging Preload into Prod
		ALTER TABLE [Staging].[ClaimFactRX30_PreLoad]
		SWITCH PARTITION @PartitionID 
		TO [dbo].[ClaimFactRX30] PARTITION @PartitionID

		--Get next row
		FETCH NEXT
		FROM C1
		INTO @PartitionID

	END

	CLOSE C1
	DEALLOCATE C1

		
	COMMIT TRAN

END TRY
BEGIN CATCH

	ROLLBACK TRAN

	CLOSE C1
	DEALLOCATE C1

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


	

END CATCH

END











GO
