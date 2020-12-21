USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteModelPerspectives] Script Date: 12/21/2020 8:46:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteModelPerspectives]
@ModelID as uniqueidentifier
AS

DELETE
FROM [ModelPerspective]
WHERE [ModelID] = @ModelID
