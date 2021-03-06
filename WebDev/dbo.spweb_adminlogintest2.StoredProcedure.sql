USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_adminlogintest2]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		B.Grant
-- Create date: 5/2012
-- Description:	admin website login with search terms 
-- return loginid if a match found; else -1
-- =============================================
CREATE PROCEDURE [dbo].[spweb_adminlogintest2]
	@info varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	declare @test1 varchar(50)
	declare @retval int
	
	select top 1 @test1 = loginid from v_web_userdata 
		where (login=@info and roleid not in (4,7))
			or aapaccountno=@info
			or apiaccountno=@info
			or ncpdp=@info
			or convert(varchar(8),defaultpmid) = @info
			order by defaultpmid desc

	select @retval = case when @test1 is null then -1 else @test1 end  
	select @retval as retval
	RETURN @retval

END
--grant exec on [spweb_adminlogintest2] to webdevuser

GO
