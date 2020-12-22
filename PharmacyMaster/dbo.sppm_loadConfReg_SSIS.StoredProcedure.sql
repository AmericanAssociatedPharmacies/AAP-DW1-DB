USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConfReg_SSIS]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConfReg_SSIS] 
	-- Add the parameters for the stored procedure here
	  @returncode int OUTPUT
AS
 

BEGIN
DECLARE @cmd VARCHAR(500);
DECLARE @PkgPath VARCHAR(200);
DECLARE @returnexec int;


SET @PkgPath = 'c:\SSIS\SSIS_LoadConfReg\\SSIS_LoadConf.dtsx ';

SET @cmd = 'dtexec /F "' + @PkgPath + '"';
 

EXEC @returnexec =    xp_cmdshell @cmd;
SET @returncode = @returnexec;


END

GO
