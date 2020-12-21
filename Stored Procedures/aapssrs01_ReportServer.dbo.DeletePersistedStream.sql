USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeletePersistedStream] Script Date: 12/21/2020 8:49:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeletePersistedStream]
@SessionID varchar(32),
@Index int
AS

delete from [aapssrs01_ReportServerTempDB].dbo.PersistedStream where SessionID = @SessionID and [Index] = @Index
