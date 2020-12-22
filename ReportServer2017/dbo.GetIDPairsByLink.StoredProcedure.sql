USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetIDPairsByLink]    Script Date: 12/22/2020 7:43:21 AM ******/
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
GO
