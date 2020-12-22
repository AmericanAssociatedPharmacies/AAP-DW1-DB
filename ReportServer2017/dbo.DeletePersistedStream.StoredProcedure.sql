USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[DeletePersistedStream]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePersistedStream]
@SessionID varchar(32),
@Index int
AS

delete from [ReportServer2017TempDB].dbo.PersistedStream where SessionID = @SessionID and [Index] = @Index
GO
