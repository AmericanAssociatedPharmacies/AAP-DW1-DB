USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_ImportLoginsNSTest]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JOSHILA NARAYANAN
-- Create date: 05/09/2012
-- Description:	Imports Logins from Netstore Users File
-- =============================================
CREATE PROCEDURE [dbo].[sp_ImportLoginsNSTest]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Remove spaces
	UPDATE    NetstoreUsers
	SET              APIAccountNo = RTRIM(APIAccountNo)

	UPDATE    NetstoreUsers
	SET              Password = RTRIM(Password)


	--Match with UD NCPDP Populate NSlogin for clickthrough
	UPDATE    userlogintest
	SET              nslogin = v_netstorelogin.APIAccountNo, nspwd = v_netstorelogin.password, defaultpmid = v_netstorelogin.PMID
	FROM         userlogintest INNER JOIN
						  v_netstorelogin ON userlogintest.login = v_netstorelogin.NCPDP


	--Populate ALL API Active Logins
	INSERT INTO userlogintest
						  (login, password, nslogin, nspwd, defaultpmid, source)
	SELECT     APIAccountNo, Password, APIAccountNo AS Expr1, Password AS Expr2, PMID, 2 AS Expr3
	FROM         v_netstoreAll


	--API Sales role Update

	UPDATE userlogintest set roleid=1 WHERE source=2 and isnumeric(login)=0 

	--ADD API Disabled Account with Inactive status

	INSERT INTO userlogintest
						  (login, password, nslogin, nspwd, defaultpmid, source,Active)
	SELECT     APIAccountNo, Password, APIAccountNo AS Expr1, Password AS Expr2, PMID, 2 AS Expr3,'False'
	FROM         v_netstoreDisabled


	
	
END
GO
