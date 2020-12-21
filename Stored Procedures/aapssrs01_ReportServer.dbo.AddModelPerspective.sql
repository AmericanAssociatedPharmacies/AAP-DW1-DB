USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[AddModelPerspective] Script Date: 12/21/2020 8:26:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddModelPerspective]
@ModelID as uniqueidentifier,
@PerspectiveID as ntext,
@PerspectiveName as ntext = null,
@PerspectiveDescription as ntext = null
AS

INSERT
INTO [ModelPerspective]
    ([ID], [ModelID], [PerspectiveID], [PerspectiveName], [PerspectiveDescription])
VALUES
    (newid(), @ModelID, @PerspectiveID, @PerspectiveName, @PerspectiveDescription)
