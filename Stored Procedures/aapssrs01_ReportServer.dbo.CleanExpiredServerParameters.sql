USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CleanExpiredServerParameters] Script Date: 12/21/2020 8:32:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CleanExpiredServerParameters]
@ParametersCleaned INT OUTPUT
AS
  DECLARE @now as DATETIME
  SET @now = GETDATE()

DELETE FROM [dbo].[ServerParametersInstance]
WHERE ServerParametersID IN
(  SELECT TOP 20 ServerParametersID FROM [dbo].[ServerParametersInstance]
  WHERE Expiration < @now
)

SET @ParametersCleaned = @@ROWCOUNT
