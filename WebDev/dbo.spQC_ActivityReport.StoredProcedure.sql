USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_ActivityReport]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spQC_ActivityReport]
as
begin
	select tabname
	,count(tabname) as views_all
	,count(distinct pmid) as pharmacies_all
	,(select count(tabname) from webdev..Log_QC t2 where userrole is null and date_accessed > '1/1/2015' and t2.tabname=t1.tabname) as views_2015
	,(select count(distinct pmid) from webdev..Log_QC t2 where userrole is null and date_accessed > '1/1/2015' and t2.tabname=t1.tabname) as pharmacies_2015
	,max(date_accessed) as last_login
	from webdev..Log_QC t1

	where userrole is null
	group by tabname
	order by tabname
end
GO
