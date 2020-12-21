USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteModelItemPolicy] Script Date: 12/21/2020 8:45:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteModelItemPolicy]
@CatalogItemID as uniqueidentifier,
@ModelItemID as nvarchar(425)
AS
SET NOCOUNT OFF
DECLARE @PolicyID uniqueidentifier
SELECT @PolicyID = (SELECT PolicyID FROM ModelItemPolicy WHERE CatalogItemID = @CatalogItemID AND ModelItemID = @ModelItemID)
DELETE Policies FROM Policies WHERE Policies.PolicyID = @PolicyID
