USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactFDS_CreateFK]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_ClaimFactFDS_CreateFK]

AS

SET NOCOUNT ON;

BEGIN

	IF (OBJECT_ID('FK_ClaimFactFDS_DateKey', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactFDS]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactFDS_DateKey] FOREIGN KEY([DateOfServiceKey])
		REFERENCES [dbo].[DateDim] ([DateKey])

	END
	
	IF (OBJECT_ID('FK_ClaimFactFDS_DrugKey', 'F') IS NULL)
	BEGIN

	ALTER TABLE [dbo].[ClaimFactFDS]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactFDS_DrugKey] FOREIGN KEY([DrugKey])
	REFERENCES [dbo].[DrugDim] ([DrugKey])

	END

	IF (OBJECT_ID('FK_ClaimFactFDS_EventDimFDS', 'F') IS NULL)
	BEGIN

		ALTER TABLE [dbo].[ClaimFactFDS]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactFDS_EventDimFDS] FOREIGN KEY([EventKey])
		REFERENCES [dbo].[EventDimFDS] ([EventKey])

	END

	IF (OBJECT_ID('FK_ClaimFactFDS_PharmacyKey', 'F') IS NULL)
	BEGIN

		
		ALTER TABLE [dbo].[ClaimFactFDS]  WITH NOCHECK ADD  CONSTRAINT [FK_ClaimFactFDS_PharmacyKey] FOREIGN KEY([PharmacyKey])
		REFERENCES [dbo].[PharmacyDim] ([PharmacyKey])

	END

END



GO
