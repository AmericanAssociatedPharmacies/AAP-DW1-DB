USE [ReportServer2017]
GO
/****** Object:  View [dbo].[ExtendedDataSets]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ExtendedDataSets]
AS
SELECT
    ID, LinkID, [Name], ItemID
FROM DataSets
UNION ALL
SELECT
    ID, LinkID, [Name], ItemID
FROM [ReportServer2017TempDB].dbo.TempDataSets
GO
