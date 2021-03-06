USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_Get_CAH_Dates_AllLoad]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_Get_CAH_Dates_AllLoad]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @T TABLE(DateKey INT)

	--Get dates not in SalesFact table
	INSERT INTO @T(DateKey)
	SELECT DISTINCT DateKey
	FROM Staging.CAH AS c
	--WHERE NOT EXISTS(SELECT 1
	--					FROM dbo.SalesFact_CAH AS x
	--					WHERE c.DateKey = x.DateKey	
	--				)
	ORDER BY DateKey ASC


	SELECT ca.RN
	, ca.DateKey
	, dt.PartitionNumber
	--INTO dbo.CAHPartitionsToReload
	FROM(SELECT ROW_NUMBER() OVER(ORDER BY DateKey ASC) AS RN
			, DateKey
			, 1 AS PartitionNumber
			FROM @T
		) AS dt
	CROSS APPLY(SELECT CASE
				WHEN dt.RN % 3 = 1 THEN 1
				WHEN dt.RN % 3 = 2 THEN 2
				ELSE 3
				END AS RN
				, DateKey
				FROM @T
				) AS ca
	WHERE dt.DateKey = ca.DateKey

	--DECLARE @TableName NVARCHAR(200) = N'Staging.CAH'
	
	--DECLARE @T TABLE(DateKey INT, PartitionNumber INT)

	--INSERT INTO @T(DateKey, PartitionNumber)
	--SELECT CONVERT(INT, rv.value)
	-- , CONVERT(INT, p.partition_number)
	--FROM sys.partitions p
	--INNER JOIN sys.indexes i
	--	 ON p.object_id = i.object_id
	--AND p.index_id = i.index_id
	--INNER JOIN sys.objects o
	--	 ON p.object_id = o.object_id
	--INNER JOIN sys.system_internals_allocation_units au
	--	 ON p.partition_id = au.container_id
	--INNER JOIN sys.partition_schemes ps
	--	 ON ps.data_space_id = i.data_space_id
	--INNER JOIN sys.partition_functions f
	--	 ON f.function_id = ps.function_id
	--INNER JOIN sys.destination_data_spaces dds
	--	 ON dds.partition_scheme_id = ps.data_space_id
	--	 AND dds.destination_id = p.partition_number
	--INNER JOIN sys.filegroups fg
	--	 ON dds.data_space_id = fg.data_space_id
	--LEFT OUTER JOIN sys.partition_range_values rv
	--	 ON f.function_id = rv.function_id
	--	 AND p.partition_number = rv.boundary_id
	--WHERE i.index_id < 2
	--	 AND o.object_id = OBJECT_ID(@TableName)
	--	 --AND rv.value > 20150101
	--	 --AND rv.value < 20180309
	--	 AND rows > 0
	--	 ORDER BY partition_number ASC


	--SELECT ca.RN
	--, ca.DateKey
	--, dt.PartitionNumber
	--FROM(SELECT ROW_NUMBER() OVER(ORDER BY DateKey ASC) AS RN
	--		, DateKey
	--		, PartitionNumber
	--		FROM @T
	--	) AS dt
	--CROSS APPLY(SELECT CASE
	--			WHEN dt.RN % 3 = 1 THEN 1
	--			WHEN dt.RN % 3 = 2 THEN 2
	--			ELSE 3
	--			END AS RN
	--			, DateKey
	--			FROM @T
	--			) AS ca
	--WHERE dt.DateKey = ca.DateKey

	
	

END










GO
