USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[DeletePersistedStreams]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePersistedStreams]
@SessionID varchar(32)
AS
SET NOCOUNT OFF
delete top (10) p
from [ReportServer2017TempDB].dbo.PersistedStream p
where p.SessionID = @SessionID;
GO
