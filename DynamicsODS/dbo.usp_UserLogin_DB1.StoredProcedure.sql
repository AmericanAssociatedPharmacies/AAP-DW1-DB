USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_UserLogin_DB1]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UserLogin_DB1]

AS

SET NOCOUNT ON;

BEGIN

	SELECT pmid
	, CONVERT(NVARCHAR(50), [websitelogin]) AS websitelogin
	, CONVERT(NVARCHAR(50), [websitepassword]) AS websitepassword
	FROM [dbo].[vw_CRM_AccountEntity_User] (READPAST)
	WHERE PMID IS NOT NULL
	AND LEN(PMID) = 6

END
GO
