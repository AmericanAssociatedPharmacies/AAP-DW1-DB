USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_findMembers2]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spweb_findMembers2]
	(
		@search varchar(255),
		@ActiveOrAll varchar(10)
	)
	AS
		select --top 200
		pmid, ncpdp, aapaccountno, apiaccountno, accountname,city,state,
		AAPStatus,APIStatus,
		case when isManagedCare<>0 then 'Y' else 'N' end as ManagedCare
			from pharmacymaster..v_pm_allwithaffiliates v 
			where 
				(
				convert(varchar(6),v.pmid)=@search
				or v.aapaccountno=@search
				or v.apiaccountno=@search
				or v.ncpdp=@search
				or v.accountname like '%' + @search + '%'
				or v.corporatename like '%' + @search + '%'
				or v.city like @search + '%'
				or v.zip = @search
				or v.zip like @search + '-%'
				or v.affiliate like @search + '%'
				)
			and (@ActiveOrAll = 'all' 
				or
				aapstatus='active' or apistatus='active' or apistatus='suspended' or isManagedCare<>0
				)
		order by accountname,city,state
GO
