USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_lastlogin]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spweb_lastlogin]
(
@username varchar(50)
)
as
begin
declare @lasthistory datetime
declare @lastdate datetime
select @lasthistory = dt FROM (SELECT row_number() OVER (ORDER BY dt desc) r, dt FROM login_history where username=@username) q
WHERE r = 2 
select @lastdate = case 
	when @lasthistory is null then dateadd(week,-2,getdate())
	else case 
		when datediff(day,@lasthistory,getdate()) < 2 then dateadd(week,-2,getdate())
		else @lasthistory end
	end
select str(datepart(year,@lastdate),4,0) as y,
	replace(str(datepart(month,@lastdate),2,0),' ','0') as m,
	replace(str(datepart(day,@lastdate),2,0),' ','0') as d
end
--[spweb_lastlogin] '5639060'
--select top 10 * from login_history
GO
