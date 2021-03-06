USE [WebDev]
GO
/****** Object:  View [dbo].[v_web_userdata_test]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[v_web_userdata_test]
AS
SELECT DISTINCT 
                      u.loginid, u.login, u.roleid, u.execpassword,r.rolename, u.defaultpmid, u.nslogin, u.nspwd, u.active, u.perms, p.pmid, p.pmparentid, p.aapaccountno, p.aapstatus, p.apiaccountno, 
                      p.ncpdp, p.dea, p.deaexp, p.npi, p.statelicno, p.statelicexpdate, p.mcquitdate, p.accountname, p.corporatename, p.addr1,p.addr2,p.city, p.state, p.zip, p.phone, p.fax, p.email, p.isAPI, 
                      p.isAAP, p.isMC, p.isTSROnly, p.isElite, p.parent_account, p.TMName, p.GenLiabCarrier, p.GenInsExpDate, p.ProfLiabCarrier, p.ProfLiabInsExpDate, 
                      p.software, p.isClaimData,p.wholesaler,
                      dbo.fnWebUserDescription(p.accountname, isnull(p.city,''), isnull(p.state,''), isnull(p.isElite,0)) AS description,
                      p.CommunicationPreference,p.affiliate,p.affiliate_directpay,p.chaincode
FROM         dbo.userlogin AS u LEFT OUTER JOIN
                      PharmacyMaster.dbo.v_web_pm_userdata AS p ON u.defaultpmid = p.pmid LEFT OUTER JOIN
                      dbo.userrole AS r ON r.roleid = u.roleid
where u.roleid <> 9                      

UNION
SELECT 
                      u.loginid, u.login, u.roleid, u.execpassword,r.rolename, u.defaultpmid, u.nslogin, u.nspwd, u.active, u.perms, p.pmid, p.pmparentid, p.aapaccountno, p.aapstatus, p.apiaccountno, 
                      p.ncpdp, p.dea, p.deaexp, p.npi, p.statelicno, p.statelicexpdate, p.mcquitdate, p.accountname, p.corporatename, p.addr1,p.addr2,p.city, p.state, p.zip, p.phone, p.fax, p.email, p.isAPI, 
                      p.isAAP, p.isMC, p.isTSROnly, p.isElite, p.parent_account, p.TMName, p.GenLiabCarrier, p.GenInsExpDate, p.ProfLiabCarrier, p.ProfLiabInsExpDate, 
                      p.software, p.isClaimData,p.wholesaler,
                      dbo.fnWebUserDescription(p.accountname, isnull(p.city,''), isnull(p.state,''), isnull(p.isElite,0)) AS description,
                      p.CommunicationPreference,p.affiliate,p.affiliate_directpay,p.chaincode
FROM         dbo.userlogin AS u LEFT OUTER JOIN
                      webdev.dbo.userdata_noPMID AS p ON u.login = p.login and u.roleid=9
                      LEFT OUTER JOIN
                      dbo.userrole AS r ON r.roleid = u.roleid
                      
                      
GO
