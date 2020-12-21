USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteDrillthroughReports] Script Date: 12/21/2020 8:44:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteDrillthroughReports]
@ModelID uniqueidentifier,
@ModelItemID nvarchar(425)
AS
 DELETE ModelDrill WHERE ModelID = @ModelID and ModelItemID = @ModelItemID
