USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_loginValidateActive_deprecated]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		B.Grant
-- Create date: 3/2012; added -3 return if not active 5/2014
-- Description:	test website login. formerly logintest
-- return loginid if user,pwd match and login is active; -1 if user only matches; -2 if neither; -3 if not active
-- =============================================

CREATE PROCEDURE [dbo].[spweb_loginValidateActive_deprecated]
	@user varchar(50),
	@password varchar(50),
	@log int
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @retval int
	DECLARE @active int	
	DECLARE @test1 int
	DECLARE @test2 int
--test user and password
select top 1 @test1 = loginid,@active=active from userlogin 
	where (login=@user)
	and (password=@password)

if @test1 is not null
	begin
	set @retval = case when @active=1 then @test1 else -3 end
	end
else
	begin
		--test if user ok (password isn't)
		select top 1 @test2 = loginid from userlogin 
			where (login=@user)
			and active=1
		set @retval = case when @test2 is null then -2 else -1 end
	end			


SELECT @retval as retval
if @log=1
	begin
		if @retval>0
			begin
				insert into login_history (dt,username,password,login_type) 
					values(getdate(),@user,@password,'login')
			end
		else
			begin
				insert into login_history (dt,username,password,login_type) 
					values(getdate(),@user,@password,'failed')
			end
	end
RETURN @retval
END

GO
