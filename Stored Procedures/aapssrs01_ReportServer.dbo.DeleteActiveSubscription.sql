USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteActiveSubscription] Script Date: 12/21/2020 8:42:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteActiveSubscription]
@ActiveID uniqueidentifier
AS

delete from ActiveSubscriptions where ActiveID = @ActiveID
