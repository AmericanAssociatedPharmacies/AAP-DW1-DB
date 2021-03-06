USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFactAudited_CreateFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_SalesFactAudited_CreateFK]

AS

SET NOCOUNT ON;

BEGIN

	IF (OBJECT_ID('FK_SalesFact_Audited_PharmacyKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_Audited] WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_Audited_PharmacyKey] FOREIGN KEY([PharmacyKey])
		REFERENCES [dbo].[PharmacyDim] ([PharmacyKey])

	END


	IF (OBJECT_ID('FK_SalesFact_Audited_DateKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_Audited] WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_Audited_DateKey] FOREIGN KEY([DateKey])
		REFERENCES [dbo].[DateDim] ([DateKey])

	END



END



GO
