USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactFDS_DropFK]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_ClaimFactFDS_DropFK]

AS

SET NOCOUNT ON;

BEGIN


	IF (OBJECT_ID('FK_ClaimFactFDS_DateKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactFDS] DROP CONSTRAINT [FK_ClaimFactFDS_DateKey]

	END
	
	IF (OBJECT_ID('FK_ClaimFactFDS_DrugKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactFDS] DROP CONSTRAINT [FK_ClaimFactFDS_DrugKey]

	END

	IF (OBJECT_ID('FK_ClaimFactFDS_EventDimFDS', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactFDS] DROP CONSTRAINT [FK_ClaimFactFDS_EventDimFDS]

	END

	IF (OBJECT_ID('FK_ClaimFactFDS_PharmacyKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactFDS] DROP CONSTRAINT [FK_ClaimFactFDS_PharmacyKey]

	END



END



GO
