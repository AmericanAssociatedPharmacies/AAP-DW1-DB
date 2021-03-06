USE [aapssrs01_ReportServer]
GO
/****** Object:  View [dbo].[ExtendedDataSets]    Script Date: 12/22/2020 5:44:05 AM ******/
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
FROM [aapssrs01_ReportServerTempDB].dbo.TempDataSets
GO
