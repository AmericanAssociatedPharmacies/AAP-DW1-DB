USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[TakeEventFromQueue]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TakeEventFromQueue]
@EventType AS NVARCHAR(520)
AS

-- READPAST hint skip any row being locked (used by other query)
DELETE FROM [Event]
OUTPUT DELETED.*
WHERE EventID IN
(
    SELECT TOP 1 EventID
    FROM [Event] WITH (READPAST)
    WHERE EventType=@EventType
    ORDER BY TimeEntered ASC
)
GO
