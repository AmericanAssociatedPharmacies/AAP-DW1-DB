USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetFirstPortionPersistedStream] Script Date: 12/21/2020 9:13:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetFirstPortionPersistedStream]
@SessionID varchar(32)
AS

SELECT
    TOP 1
    TEXTPTR(P.Content),
    DATALENGTH(P.Content),
    P.[Index],
    P.[Name],
    P.MimeType,
    P.Extension,
    P.Encoding,
    P.Error
FROM
    [aapssrs01_ReportServerTempDB].dbo.PersistedStream P WITH (XLOCK)
WHERE
    P.SessionID = @SessionID
