USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_web_pm_weblogins]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_web_pm_weblogins]
as
select 
u.login,u.password,u.perms,u.nslogin as netstore_login,nspwd as netstore_password,
active,case when u.source=1 then 'UD' else 'API' end as source,
r.rolename,p.accountname,p.city,p.state,p.ncpdp,p.apiaccountno,p.aapaccountno 
from webdev..userlogin u left join webdev..userrole r on u.roleid=r.roleid
left join v_pm_allwithaffiliates p on u.defaultpmid=p.pmid

GO
