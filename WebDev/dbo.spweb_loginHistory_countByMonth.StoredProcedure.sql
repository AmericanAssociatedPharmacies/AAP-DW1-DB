USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_loginHistory_countByMonth]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spweb_loginHistory_countByMonth]
(
@ncpdp_or_api_or_pmid varchar(11)
) as
begin
select year(dt) as yr,month(dt),count(id) as mo 
from login_history h left join userlogin u on h.username=u.login
where h.username=@ncpdp_or_api_or_pmid
or u.defaultpmid = convert(int, @ncpdp_or_api_or_pmid)
group by year(dt),month(dt)
order by year(dt),month(dt)
end
GO
