USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRCare_report_users]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spRCare_report_users]
as
select * from dbo.RxCareSelect
order by date_registered desc
GO
