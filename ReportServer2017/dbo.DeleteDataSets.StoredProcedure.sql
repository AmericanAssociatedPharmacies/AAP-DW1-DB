USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[DeleteDataSets]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteDataSets]
@ItemID [uniqueidentifier]
AS
DELETE
FROM [DataSets]
WHERE [ItemID] = @ItemID
DELETE
FROM [ReportServer2017TempDB].dbo.TempDataSets
WHERE [ItemID] = @ItemID
GO
