USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadCHPHAAPfile]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadCHPHAAPfile] 
	-- Add the parameters for the stored procedure here
	@filename varchar(1000),
    @monthYear datetime 
AS
DECLARE @SQL varchar(2000)
IF NOT EXISTS(SELECT  filename FROM CHPH_AAP_loadlog WHERE filename = @filename)

BEGIN
	--SET NOCOUNT ON;
	set @SQL = "bulk insert v_load_chph_aap from '" + @filename;
	set @SQL = @SQL + "' with (fieldterminator=';', firstrow=2, "
	set @SQL = @SQL + "errorfile='" + @filename + ".err')"
	exec(@SQL)

	set @SQL = "insert into CHPH_AAP_loadlog (filename,date_loaded) values('" + @filename + "',getdate())"
	exec(@SQL)

END

GO
