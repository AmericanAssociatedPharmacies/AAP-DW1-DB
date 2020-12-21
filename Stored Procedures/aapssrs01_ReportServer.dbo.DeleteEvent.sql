USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteEvent] Script Date: 12/21/2020 8:44:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteEvent]
@ID uniqueidentifier
AS
delete from [Event] where [EventID] = @ID
