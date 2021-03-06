USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spCM_GetUserInfo]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 4/18/2014
-- Description:	Get the distribution get for communication master
-- =============================================
CREATE PROCEDURE [dbo].[spCM_GetUserInfo] 
(
	@UserId NVARCHAR(150)
)
	 AS 
BEGIN 
	SELECT TOP 1 loginid as id, [login] as userid, perms as [role], '' as msg, [login] as SessionID 
		,[password],firstname,lastname,email,roleid,defaultpmid,active 
	FROM Webdev.dbo.userlogin 
	WHERE [login] = @UserId
END

/*

EXEC [dbo].[spCM_GetUserInfo] '0100622'

SELECT * FROM Webdev.dbo.userlogin where login like 'it%'


SELECT [USER_ID]
      ,[USERNAME]
      ,[PASSWORD]
      ,[PERMS]
      ,[OPT_IN]
      ,[OPT_IN2]
      ,[MANAGED_CARE]
  FROM [WebDev].[dbo].[Auth_User]

SELECT [id]
      ,[Login]
      ,[functionid]
  FROM [WebDev].[dbo].[AdminFunctionUsers]



*/
GO
