USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[DeleteNotification]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteNotification]
@ID uniqueidentifier
AS
delete from [Notifications] where [NotificationID] = @ID
GO
