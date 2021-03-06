USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[SetNotificationAttempt]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetNotificationAttempt]
@Attempt int,
@SecondsToAdd int,
@NotificationID uniqueidentifier
AS

update
    [Notifications]
set
    [ProcessStart] = NULL,
    [Attempt] = @Attempt,
    [ProcessAfter] = DateAdd(second, @SecondsToAdd, GetUtcDate())
where
    [NotificationID] = @NotificationID
GO
