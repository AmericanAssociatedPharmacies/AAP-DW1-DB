USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[DeleteActiveSubscription]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteActiveSubscription]
@ActiveID uniqueidentifier
AS

delete from ActiveSubscriptions where ActiveID = @ActiveID
GO
