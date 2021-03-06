USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFactCAH_CreateFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_SalesFactCAH_CreateFK]

AS

SET NOCOUNT ON;

BEGIN


	IF (OBJECT_ID('FK_SalesFact_CAH_EventDimCAH', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[SalesFact_CAH]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_CAH_EventDimCAH] FOREIGN KEY([CAHEventKey],CAHEventDateKey)
		REFERENCES [dbo].[EventDimCAH] ([EventKey],DateKey);

	END
		
	IF (OBJECT_ID('FK_SalesFact_CAH_PharmacyKey', 'F') IS NULL)
	BEGIN
	
		ALTER TABLE [dbo].[SalesFact_CAH]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_CAH_PharmacyKey] FOREIGN KEY([PharmacyKey])
		REFERENCES [dbo].[PharmacyDim] ([PharmacyKey]);

	END

	
	IF (OBJECT_ID('FK_SalesFact_CAH_DrugKey', 'F') IS NULL)
	BEGIN
		
		ALTER TABLE [dbo].[SalesFact_CAH]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_CAH_DrugKey] FOREIGN KEY([DrugKey])
		REFERENCES [dbo].[DrugDim] ([DrugKey]);

	END

	IF (OBJECT_ID('FK_SalesFact_CAH_DateKey', 'F') IS NULL)
	BEGIN
	
		ALTER TABLE [dbo].[SalesFact_CAH]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_CAH_DateKey] FOREIGN KEY([DateKey])
		REFERENCES [dbo].[DateDim] ([DateKey]);

	END


END


GO
