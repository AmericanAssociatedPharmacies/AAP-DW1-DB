USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_findLogin]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spweb_findLogin]
	@search varchar(255)
AS
	--search multiple fields, return matching login information, exclude admin logins. BGrant 6/12
	--left join from v_web_userdata limits to entries in pharmacymaster 

	select --u.loginid, 
		case when u.defaultpmid is null then 
			case when u.login=u.nslogin then 'Error: API account# is not in Pharmacy Master'
				else 'Error: this login is not in Pharmacy Master' end
			else 
				case when u.active <> 1 then 'Error: login is not active' 
				else 'OK' end
			end as 'status',
		u.login, u.password, u.execpassword, 
		v.accountname,v.city,v.state,
		r.rolename,u.defaultpmid,
		u.nslogin,u.nspwd, 
		u.active, v.isMC
		--u.source,
		--v.isAPI,v.isAAP,v.isMC,v.isElite,
		 --,v.ncpdp,v.apiaccountno,v.aapaccountno,v.pmid as viewpmid,
		--v.parent_account
		from v_web_userdata v left join userlogin u on v.loginid=u.loginid
		left join userrole r on r.roleid=u.roleid
		where (r.rolename is null or r.rolename not like '%admin%') and
		(u.login like '%' + @search + '%'
			or convert(varchar(8),v.PMID) = @search
			or v.aapaccountno=@search
			or v.apiaccountno=@search
			or v.ncpdp=@search
			or convert(varchar(8),u.defaultpmid)=@search
			or v.accountname like '%' + @search + '%')


GO
