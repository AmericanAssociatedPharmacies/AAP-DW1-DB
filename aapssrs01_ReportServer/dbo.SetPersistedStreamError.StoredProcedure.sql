USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[SetPersistedStreamError]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetPersistedStreamError]
@SessionID varchar(32),
@Index int,
@AllRows bit,
@Error nvarchar(512)
AS

if @AllRows = 0
BEGIN
    UPDATE [aapssrs01_ReportServerTempDB].dbo.PersistedStream SET Error = @Error WHERE SessionID = @SessionID and [Index] = @Index
END
ELSE
BEGIN
    UPDATE [aapssrs01_ReportServerTempDB].dbo.PersistedStream SET Error = @Error WHERE SessionID = @SessionID
END
GO
