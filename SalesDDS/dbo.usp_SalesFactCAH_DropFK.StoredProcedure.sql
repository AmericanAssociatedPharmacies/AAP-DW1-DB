USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFactCAH_DropFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_SalesFactCAH_DropFK]

AS

SET NOCOUNT ON;

BEGIN


	IF (OBJECT_ID('FK_SalesFact_CAH_DateKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_CAH] DROP CONSTRAINT [FK_SalesFact_CAH_DateKey]

	END

	IF (OBJECT_ID('FK_SalesFact_CAH_DrugKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_CAH] DROP CONSTRAINT [FK_SalesFact_CAH_DrugKey]

	END

	IF (OBJECT_ID('FK_SalesFact_CAH_EventDimCAH', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_CAH] DROP CONSTRAINT [FK_SalesFact_CAH_EventDimCAH]

	END

	IF (OBJECT_ID('FK_SalesFact_CAH_PharmacyKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_CAH] DROP CONSTRAINT [FK_SalesFact_CAH_PharmacyKey]

	END

END


GO
