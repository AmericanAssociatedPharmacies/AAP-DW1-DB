USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[DeletePersistedStream]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePersistedStream]
@SessionID varchar(32),
@Index int
AS

delete from [aapssrs01_ReportServerTempDB].dbo.PersistedStream where SessionID = @SessionID and [Index] = @Index
GO
