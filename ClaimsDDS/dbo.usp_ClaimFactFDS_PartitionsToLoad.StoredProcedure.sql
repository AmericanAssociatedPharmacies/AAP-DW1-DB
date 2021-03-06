USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactFDS_PartitionsToLoad]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_ClaimFactFDS_PartitionsToLoad]

AS

SET NOCOUNT ON;

BEGIN

	/*
	
	*A "1" means that partition has data in it. We can only execute a MERGE query on a non-empty partition. That data will need to be switched from the dbo table to the 
	Staging table and execute a MERGE query, and then switch the data back to the dbo table.
	
	A "2" means we have an empty partition in the Fact table and can switch that data from the PreLoad table straight into the production Fact table.
	*/

	SELECT dt.partition_number AS PartitionID
	FROM(SELECT A.partition_number
		FROM sys.partitions AS A
		INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
		WHERE object_id = OBJECT_ID('Staging.ClaimFactFDS_PreLoad')
		AND index_id = 1
		AND A.rows > 0
		) AS dt
	INNER JOIN (SELECT A.partition_number
				FROM sys.partitions AS A
				INNER JOIN sys.partition_range_values AS B ON A.partition_number = b.boundary_id
				WHERE object_id = OBJECT_ID('dbo.ClaimFactFDS')
				AND index_id = 1
				AND A.rows > 0
				) AS dt2 ON dt.partition_number = dt2.partition_number

	
	

END




GO
