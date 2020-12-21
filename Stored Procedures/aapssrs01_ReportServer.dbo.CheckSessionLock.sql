USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CheckSessionLock] Script Date: 12/21/2020 8:30:25 AM ******/
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
