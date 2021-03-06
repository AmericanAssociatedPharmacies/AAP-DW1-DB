USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spPDS_binsearchByBin]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spPDS_binsearchByBin]
(
@bin varchar(255)
)
as
begin

declare @buf varchar(255)
set @buf = 'select distinct * from openquery(uniteddb,''select '
+ 'CONTRACT_ID,PLAN_NAME,PCN,GROUP_NUM as GROUP_,SERVICE_AREA'
+ ' from united.plan_contract '
-- + ' where effective_dt is not null and cancel_dt is null '
+ 'where active<>0 '
-- + ' and ansi_bin=''''' + @bin + ''''''')'
+ ' and ansi_bin like ''''%' + @bin + '%'''''')'
+ ' order by PLAN_NAME,CONTRACT_ID'
exec(@buf)
end
GO
