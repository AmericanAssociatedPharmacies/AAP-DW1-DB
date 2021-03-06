USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Switch_SalesFactRX30_StagingPreLoadtoProd]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_Switch_SalesFactRX30_StagingPreLoadtoProd]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	IF (SELECT COUNT(*)
		FROM sys.partitions AS A
		INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
		WHERE object_id = OBJECT_ID('Staging.ClaimFactRX30_PreLoad')
		AND index_id = 1
		AND A.rows > 0	
		) = 0

		BEGIN

			RETURN

		END

	ELSE


	BEGIN TRAN

		DECLARE @p1 INT
		DECLARE @T1 TABLE(PartitionID INT)
		DECLARE @T2 TABLE(PartitionID INT)

		--Get the Partition's that have data in them
		INSERT INTO @T1(PartitionID)
		SELECT A.partition_number
		FROM sys.partitions AS A
		INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
		WHERE object_id = OBJECT_ID('Staging.ClaimFactRX30_PreLoad')
		AND index_id = 1
		AND A.rows > 0

		--Get the Partition's that do not have date in them
		INSERT INTO @T2(PartitionID)
		SELECT A.partition_number
		FROM sys.partitions AS A
		INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
		WHERE object_id = OBJECT_ID('dbo.ClaimFactRX30')
		AND index_id = 1
		AND A.rows = 0

		/*The logic of the code below is "The partitions in the Production table are empty. We can swtich those in straight
		from the PreLoad table to the Production table."*/

		--Get valued for cursor
		DECLARE PS CURSOR FOR
		SELECT a.PartitionID
		FROM @T1 AS a
		WHERE EXISTS(SELECT 1
							FROM @T2 AS B
							WHERE a.PartitionID = b.PartitionID
						)

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
			ALTER TABLE [Staging].[ClaimFactRX30_PreLoad]
			SWITCH PARTITION @P1 
			TO [dbo].[ClaimFactRX30] PARTITION @P1

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
