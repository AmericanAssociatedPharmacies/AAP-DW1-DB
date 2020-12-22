USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_loginDescription_test]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spweb_loginDescription_test]
	@loginid int,
	@username varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
select top 1 
* from v_web_userdata_test u
where u.loginid=@loginid
or u.login=@username
END
GO
