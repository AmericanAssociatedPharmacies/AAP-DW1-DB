USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeletePersistedStreams] Script Date: 12/21/2020 8:50:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeletePersistedStreams]
@SessionID varchar(32)
AS
SET NOCOUNT OFF
delete top (10) p
from [aapssrs01_ReportServerTempDB].dbo.PersistedStream p
where p.SessionID = @SessionID;
