USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[CheckSessionLock]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckSessionLock]
@SessionID as varchar(32),
@LockVersion  int OUTPUT
AS
DECLARE @Selected nvarchar(32)
SELECT @Selected=SessionID, @LockVersion = LockVersion FROM [aapssrs01_ReportServerTempDB].dbo.SessionLock WITH (ROWLOCK) WHERE SessionID = @SessionID
GO
