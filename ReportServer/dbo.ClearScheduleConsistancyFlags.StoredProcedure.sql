USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[ClearScheduleConsistancyFlags]    Script Date: 12/22/2020 7:41:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ClearScheduleConsistancyFlags]
AS
update [Schedule] with (tablock, xlock) set [ConsistancyCheck] = NULL
GO
