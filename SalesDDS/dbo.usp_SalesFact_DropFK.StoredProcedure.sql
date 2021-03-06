USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_DropFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_SalesFact_DropFK]


AS


SET NOCOUNT ON;

BEGIN

	ALTER TABLE [dbo].[SalesFact] DROP CONSTRAINT [FK_SalesFact_APIEventKey];

	ALTER TABLE [dbo].[SalesFact] DROP CONSTRAINT [FK_SalesFact_CAHEventKey];

	ALTER TABLE [dbo].[SalesFact] DROP CONSTRAINT [FK_SalesFact_DateKey];

	ALTER TABLE [dbo].[SalesFact] DROP CONSTRAINT [FK_SalesFact_DrugKey];

	ALTER TABLE [dbo].[SalesFact] DROP CONSTRAINT [FK_SalesFact_PharmacyKey];

END

GO
