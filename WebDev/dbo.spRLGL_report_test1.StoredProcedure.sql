USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRLGL_report_test1]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRLGL_report_test1]
as

select dt2.*,p.ncpdp as pmncpdp,p.accountname,p.city,p.state,p.aapstatus
from
(
select ncpdp,rundate,count(distinct test) as query_count
from
(
select convert(varchar(8),convert(datetime,left(rundate,len(rundate)-9)),1) as rundate
,ncpdp,rxnum+rxdate as test
from tmp_rlgl_071114
where demo is null
) dt
group by rundate,ncpdp
having count(distinct test) > 10
) dt2
left join pharmacymaster..v_test p on dt2.ncpdp=p.ncpdp
where aapstatus='ACTIVE'
order by ncpdp,rundate
GO
