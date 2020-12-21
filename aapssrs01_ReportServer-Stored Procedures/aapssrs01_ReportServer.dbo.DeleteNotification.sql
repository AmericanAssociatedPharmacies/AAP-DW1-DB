USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteNotification] Script Date: 12/21/2020 8:46:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteNotification]
@ID uniqueidentifier
AS
delete from [Notifications] where [NotificationID] = @ID
