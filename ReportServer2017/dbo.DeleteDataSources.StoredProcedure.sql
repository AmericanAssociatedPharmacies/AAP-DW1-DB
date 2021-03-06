USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[DeleteDataSources]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteDataSources]
@ItemID [uniqueidentifier]
AS

DELETE
FROM [DataSource]
WHERE [ItemID] = @ItemID or [SubscriptionID] = @ItemID
DELETE
FROM [ReportServer2017TempDB].dbo.TempDataSources
WHERE [ItemID] = @ItemID
GO
