USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_passwordupd]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_passwordupd]

	@loginid int,	
	@pwd nvarchar(50),	
	@currentuser nvarchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Update userlogin set 
		password=@pwd,
		updatedon = getdate(),
		updatedby = @currentuser
	WHERE loginid=@loginid 
   
END
GO
