USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_loginServices]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc
[dbo].[spweb_loginServices]
(
	@PMID int
)
as
select * from
v_web_pm_services
where PMID=@PMID
GO
