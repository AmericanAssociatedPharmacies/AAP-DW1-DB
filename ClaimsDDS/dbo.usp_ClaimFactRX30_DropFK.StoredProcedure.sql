USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactRX30_DropFK]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ClaimFactRX30_DropFK]

AS

SET NOCOUNT ON;

BEGIN


	IF (OBJECT_ID('FK_ClaimFactRX30_DateKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30] DROP CONSTRAINT [FK_ClaimFactRX30_DateKey]

	END
	
	IF (OBJECT_ID('FK_ClaimFactRX30_DrugKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30] DROP CONSTRAINT [FK_ClaimFactRX30_DrugKey]

	END

	IF (OBJECT_ID('FK_ClaimFactRX30_EventDimRX30', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30] DROP CONSTRAINT [FK_ClaimFactRX30_EventDimRX30]

	END

	IF (OBJECT_ID('FK_ClaimFactRX30_PharmacyKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30] DROP CONSTRAINT [FK_ClaimFactRX30_PharmacyKey]

	END



END


GO
