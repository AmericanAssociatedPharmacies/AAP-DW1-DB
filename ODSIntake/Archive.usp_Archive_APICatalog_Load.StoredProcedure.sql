USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Archive].[usp_Archive_APICatalog_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Archive].[usp_Archive_APICatalog_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [Archive].[APICatalog] AS t
	USING(SELECT FileRowID
			, DateKey
			, NDC
			, UPC
			, VIN
			, [Desc]
			, PkgSize
			, DispUnt
			, AcqCost
			, ListPrice
			, FileProcessed
			, RowCreatedDate
		FROM [Staging].[APICatalog]
		) AS s (FileRowID, DateKey, NDC, UPC, VIN, [Desc], PkgSize, DispUnt, AcqCost, ListPrice, FileProcessed, RowCreatedDate)
	ON t.DateKey = s.DateKey
		AND t.NDC = s.NDC

	WHEN MATCHED THEN
	UPDATE SET FileRowID = s.FileRowID
			, UPC = s.UPC
			, VIN = s.VIN
			, [Desc] = s.[Desc]
			, PkgSize = s.PkgSize
			, DispUnt = s.DispUnt
			, AcqCost = s.AcqCost
			, ListPrice = s.ListPrice
			, FileProcessed = s.FileProcessed
			, RowCreatedDate = s.RowCreatedDate


	WHEN NOT MATCHED THEN

	INSERT(FileRowID
			, DateKey
			, NDC
			, UPC
			, VIN
			, [Desc]
			, PkgSize
			, DispUnt
			, AcqCost
			, ListPrice
			, FileProcessed
			)

	VALUES(s.FileRowID
			, s.DateKey
			, s.NDC
			, s.UPC
			, s.VIN
			, s.[Desc]
			, s.PkgSize
			, s.DispUnt
			, s.AcqCost
			, s.ListPrice
			, s.FileProcessed
			);

END
GO
