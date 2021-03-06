USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadCHAccounts_SSIS]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadCHAccounts_SSIS] 
	-- Add the parameters for the stored procedure here
	  @returncode int OUTPUT,@error varchar(max) OUTPUT
AS
 

BEGIN
DECLARE @cmd VARCHAR(500);
DECLARE @PkgPath VARCHAR(200);

DECLARE @returnexec int;
DECLARE @ErrorMessage varchar(8000);

SET @ErrorMessage = '';
--Create temp table to hold result
CREATE TABLE #temp (SomeCol VARCHAR(500))


SET @PkgPath = 'c:\SSIS\SSIS_LoadCHAccounts\SSIS_LoadCHAccountInfofromAPI.dtsx';

SET @cmd = 'dtexec /F "' + @PkgPath + '"';
--EXEC @returnexec =   xp_cmdshell @cmd;
--SET @returncode = @returnexec;


-------
INSERT #temp
EXEC @returnexec =    xp_cmdshell @cmd;
SET @returncode = @returnexec;
BEGIN
    SELECT @ErrorMessage = @ErrorMessage + SomeCol   
    FROM #temp
    WHERE SomeCol IS NOT NULL
 
    --Display error message and return code
    --SELECT @ErrorMessage as ErrorMessage  ,@ReturnCode as ReturnCode
	SET @error = @ErrorMessage;
END


END

GO
