USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetIDPairsByLink] Script Date: 12/21/2020 9:13:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetIDPairsByLink]
@Link uniqueidentifier
AS
SELECT LinkSourceID, ItemID
FROM Catalog
WHERE LinkSourceID = @Link
