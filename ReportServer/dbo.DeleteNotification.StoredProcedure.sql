USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[DeleteNotification]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteNotification]
@ID uniqueidentifier
AS
delete from [Notifications] where [NotificationID] = @ID
GO
