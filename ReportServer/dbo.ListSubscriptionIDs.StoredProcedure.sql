USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[ListSubscriptionIDs]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ListSubscriptionIDs]
AS

SELECT [SubscriptionID]
FROM [dbo].[Subscriptions] WITH (XLOCK, TABLOCK)
GO
