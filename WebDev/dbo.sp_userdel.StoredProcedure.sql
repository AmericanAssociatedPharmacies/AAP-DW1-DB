USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_userdel]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_userdel]

	@loginid int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Update userlogin set active=0 WHERE loginid=@loginid
   
END
GO
