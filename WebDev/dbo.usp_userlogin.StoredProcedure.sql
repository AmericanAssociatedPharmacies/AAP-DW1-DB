USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_userlogin]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_userlogin]

	@login NVARCHAR(50)
	, @password NVARCHAR(50)

AS


SET NOCOUNT ON;

BEGIN

	SELECT ul.login
	, ul.password
	, ul.nslogin
	, ul.nspwd
	, ur.rolename
	, pm.Email
	, pm.EmergencyPhone
	, pm.OwnerName
	, pm.PMID
	, pm.APIAccountNo
	, pm.AAPAccountNo
	, pm.NCPA
	, pm.DEA
	, pm.NPI
	, pm.AccountName

	FROM [dbo].[userlogin] AS ul
	LEFT OUTER JOIN dbo.userrole AS ur ON ul.roleid = ur.roleid
	LEFT OUTER JOIN PharmacyMaster.dbo.PM_Pharmacy AS pm ON ul.defaultpmid = pm.PMID
	WHERE ul.login = @login
	AND ul.password = @password


END
GO
