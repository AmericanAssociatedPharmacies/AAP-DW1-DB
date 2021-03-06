USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_webLoginHistory]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_webLoginHistory]
as
begin
select yr,mo,count(distinct defaultpmid) as distinct_pharmacies,
count(defaultpmid) as logins from
(
select 
year(dt) as yr, month(dt) as mo, defaultpmid from login_history h left join userlogin l on h.username=l.login
where defaultpmid is not null
) dt
group by yr,mo
order by yr,mo
end

GO
