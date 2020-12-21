USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteExpiredPersistedStreams] Script Date: 12/21/2020 8:44:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteExpiredPersistedStreams]
AS
SET NOCOUNT OFF
SET DEADLOCK_PRIORITY LOW
declare @now as datetime = GETDATE();
delete top (10) p
from [aapssrs01_ReportServerTempDB].dbo.PersistedStream p with(readpast)
where p.RefCount = 0 AND p.ExpirationDate < @now;
