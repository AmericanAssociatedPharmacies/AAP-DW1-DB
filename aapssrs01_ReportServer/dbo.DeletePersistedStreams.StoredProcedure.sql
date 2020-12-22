USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[DeletePersistedStreams]    Script Date: 12/22/2020 5:44:05 AM ******/
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
GO
