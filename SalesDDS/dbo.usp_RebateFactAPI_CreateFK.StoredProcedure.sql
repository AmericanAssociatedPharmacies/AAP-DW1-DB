USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_RebateFactAPI_CreateFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_RebateFactAPI_CreateFK]

AS

SET NOCOUNT ON;

BEGIN

	IF (OBJECT_ID('FK_RebateFact_API_PharmacyKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[RebateFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_RebateFact_API_PharmacyKey] FOREIGN KEY([PharmacyKey])
		REFERENCES [dbo].[PharmacyDim] ([PharmacyKey])

	END

	IF (OBJECT_ID('FK_RebateFact_API_DrugKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE  [dbo].[RebateFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_RebateFact_API_DrugKey] FOREIGN KEY([DrugKey])
		REFERENCES [dbo].[DrugDim] ([DrugKey])

	END

	IF (OBJECT_ID('FK_RebateFact_API_DateKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE  [dbo].[RebateFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_RebateFact_API_DateKey] FOREIGN KEY([DateKey])
		REFERENCES [dbo].[DateDim] ([DateKey])

	END

	IF (OBJECT_ID('FK_RebateFact_API_EventDimAPI', 'F') IS NULL)
	BEGIN

		ALTER TABLE  [dbo].[RebateFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_RebateFact_API_EventDimAPI] FOREIGN KEY([APIEventKey],DateKey)
		REFERENCES [dbo].[EventDimAPI] ([EventKey],DateKey)

	END

END


GO
