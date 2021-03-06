USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_RebateFactAPI_DropFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_RebateFactAPI_DropFK]

AS

SET NOCOUNT ON;

BEGIN


	IF (OBJECT_ID('FK_RebateFact_API_DateKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[RebateFact_API] DROP CONSTRAINT [FK_RebateFact_API_DateKey]

	END

	IF (OBJECT_ID('FK_RebateFact_API_DrugKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[RebateFact_API] DROP CONSTRAINT [FK_RebateFact_API_DrugKey]

	END

	IF (OBJECT_ID('FK_RebateFact_API_PharmacyKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[RebateFact_API] DROP CONSTRAINT [FK_RebateFact_API_PharmacyKey]

	END

	IF (OBJECT_ID('FK_RebateFact_API_EventDimAPI', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[RebateFact_API] DROP CONSTRAINT [FK_RebateFact_API_EventDimAPI]

	END

END


GO
