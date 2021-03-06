USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadCH_APIAAP_SSIS]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Audited File from Betty for AAP and API PVA's
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadCH_APIAAP_SSIS] 
     @returncode int OUTPUT
	-- Add the parameters for the stored procedure here
 
AS
 

BEGIN
DECLARE @cmd VARCHAR(500);
DECLARE @PkgPath VARCHAR(200);
DECLARE @Val VARCHAR(10);
DECLARE @returnexec int;

SET @PkgPath = 'c:\SSIS\SSIS_LoadCH_APIPVA\SSIS_LOADCH_APIPVA.dtsx ';

SET @cmd = 'dtexec /F "' + @PkgPath + '"';
EXEC @returnexec =     xp_cmdshell @cmd;
SET @returncode = @returnexec;


END

GO
