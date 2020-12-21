USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[ClearScheduleConsistancyFlags] Script Date: 12/21/2020 8:34:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ClearScheduleConsistancyFlags]
AS
update [Schedule] with (tablock, xlock) set [ConsistancyCheck] = NULL
