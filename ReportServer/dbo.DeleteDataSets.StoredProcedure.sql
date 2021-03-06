USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[DeleteDataSets]    Script Date: 12/22/2020 7:41:11 AM ******/
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
FROM [ReportServerTempDB].dbo.TempDataSets
WHERE [ItemID] = @ItemID
GO
