USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactRX30_CreateFK]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ClaimFactRX30_CreateFK]

AS

SET NOCOUNT ON;

BEGIN

	IF (OBJECT_ID('FK_ClaimFactRX30_DateKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactRX30_DateKey] FOREIGN KEY([DateOfServiceKey])
		REFERENCES [dbo].[DateDim] ([DateKey])

	END
	
	IF (OBJECT_ID('FK_ClaimFactRX30_DrugKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactRX30_DrugKey] FOREIGN KEY([DrugKey])
		REFERENCES [dbo].[DrugDim] ([DrugKey])

	END

	IF (OBJECT_ID('FK_ClaimFactRX30_EventDimRX30', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactRX30_EventDimRX30] FOREIGN KEY([EventKey])
		REFERENCES [dbo].[EventDimRX30] ([EventKey])

	END

	IF (OBJECT_ID('FK_ClaimFactRX30_PharmacyKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactRX30]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactRX30_PharmacyKey] FOREIGN KEY([PharmacyKey])
		REFERENCES [dbo].[PharmacyDim] ([PharmacyKey])

	END

END


GO
