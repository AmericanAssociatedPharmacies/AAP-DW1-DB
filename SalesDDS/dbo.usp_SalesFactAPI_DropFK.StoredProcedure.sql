USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFactAPI_DropFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_SalesFactAPI_DropFK]

AS

SET NOCOUNT ON;

BEGIN


	IF (OBJECT_ID('FK_SalesFact_API_DateKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_DateKey]

	END

	IF (OBJECT_ID('FK_SalesFact_API_DrugKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_DrugKey]

	END

	IF (OBJECT_ID('FK_SalesFact_API_PharmacyKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_PharmacyKey]

	END

	IF (OBJECT_ID('FK_SalesFact_API_EventDimAPI', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_EventDimAPI]

	END

END

GO
