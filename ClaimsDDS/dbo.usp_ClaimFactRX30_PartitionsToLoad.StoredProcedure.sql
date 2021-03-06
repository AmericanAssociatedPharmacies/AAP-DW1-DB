USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactRX30_PartitionsToLoad]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ClaimFactRX30_PartitionsToLoad]

AS

SET NOCOUNT ON;

BEGIN

	/*This sproc is to get the list of Partition's where both tables below have data in them. */

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
				AND A.rows > 0
				) AS dt2 ON dt.partition_number = dt2.partition_number
	
	

END


GO
