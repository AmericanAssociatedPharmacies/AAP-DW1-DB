USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFactAudited_DropFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_SalesFactAudited_DropFK]

AS

SET NOCOUNT ON;

BEGIN


	IF (OBJECT_ID('FK_SalesFact_Audited_DateKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_Audited] DROP CONSTRAINT [FK_SalesFact_Audited_DateKey]

	END

	IF (OBJECT_ID('FK_SalesFact_Audited_PharmacyKey', 'F') IS NOT NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_Audited] DROP CONSTRAINT [FK_SalesFact_Audited_PharmacyKey]

	END


END



GO
