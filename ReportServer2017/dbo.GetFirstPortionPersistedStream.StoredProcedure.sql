USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetFirstPortionPersistedStream]    Script Date: 12/22/2020 7:43:21 AM ******/
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
    [ReportServer2017TempDB].dbo.PersistedStream P WITH (XLOCK)
WHERE
    P.SessionID = @SessionID
GO
