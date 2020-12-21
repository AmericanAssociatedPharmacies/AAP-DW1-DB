USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CleanExpiredJobs] Script Date: 12/21/2020 8:32:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CleanExpiredJobs]
AS
SET NOCOUNT OFF
DELETE FROM RunningJobs WHERE DATEADD(s, Timeout, StartDate) < GETDATE()
