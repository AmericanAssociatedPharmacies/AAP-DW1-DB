USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_ImportQA]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ImportQA]

AS
BEGIN
	declare @numbers1 nvarchar(100)
	declare @numbers2 nvarchar(100)
	declare @numbers3 nvarchar(100)
	Declare @Command nvarchar(200)

	Select @numbers1 = count(*) from userlogin

	Select @numbers2 =  count(*) from userloginbak

	Select @numbers3 = count(*) from v_netstoreCheck

	set @Command = 'Select ' + @numbers1 + 'as userlogin,' + @numbers2 + ' as userloginbak,' + @numbers3 + ' as NetstoreMissing'
	--QA Email
	EXEC msdb.dbo.sp_send_dbmail 
    @recipients='christopher.mckinnie@rxaap.com;leeann.carrell@rxaap.com', 
    @body='Website Login Import has been succesfully completed!',  
    @subject ='Website Login Import', 
    @profile_name = 'db1 email', 
    @query = @Command,  
    @attach_query_result_as_file = 1, 
    @query_attachment_filename ='LoginStats.xls',
    @query_result_width = 1000,
    @query_result_header = 1,
	@query_result_separator = '	',
	@query_result_no_padding = 1

	
END
GO
