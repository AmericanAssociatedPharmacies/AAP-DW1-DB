USE [CAHODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_NDC_Load]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CAH_NDC_Load]
AS

SET NOCOUNT ON;

BEGIN

BEGIN TRAN


	--Truncate Archive table
	TRUNCATE TABLE Archive.CAH_NDC;
	
	--Switch data in and out to load new data
	ALTER TABLE dbo.CAH_NDC
	SWITCH TO Archive.CAH_NDC;

	ALTER TABLE Staging.CAH_NDC
	SWITCH TO dbo.CAH_NDC;

COMMIT TRAN

END

GO
