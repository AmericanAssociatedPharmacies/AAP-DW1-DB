USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_ErrorSFTP_Insert]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_ErrorSFTP_Insert]

	@p1 VARCHAR(8000)


AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO dbo.ErrorSFTP(C1)
	VALUES(@p1)

END
GO
