USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_loginDescription]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		B.Grant
-- Create date: 3/2012
-- Description:	Return description to website
-- =============================================
CREATE PROCEDURE [dbo].[spweb_loginDescription]
	@loginid int
AS
BEGIN
	SET NOCOUNT ON;
select * from v_web_userdata u
where u.loginid=@loginid
END






GO
