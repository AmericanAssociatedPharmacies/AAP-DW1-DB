USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[LockPersistedStream]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LockPersistedStream]
@SessionID varchar(32),
@Index int
AS

SELECT [Index] FROM [ReportServer2017TempDB].dbo.PersistedStream WITH (XLOCK) WHERE SessionID = @SessionID AND [Index] = @Index
GO
