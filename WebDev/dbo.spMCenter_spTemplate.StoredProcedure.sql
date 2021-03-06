USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spMCenter_spTemplate]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[spMCenter_spTemplate]
(
	@PMID int
)
as
-- Message Center return 'result' field, value 1 to show message else 0
-- this is a sample SP to illustrate. BG 8/2014
-- remember to grant exec on [spMCenter_spTemplate] to webdevuser
BEGIN
declare @cnt int
select @cnt = count(1) from v_web_userdata where pmid=@PMID 
and isAAP=1 and isnull(affiliate,'') not in ('IPA','PIPCO')
select case when @cnt > 0 then 1 else 0 end as result
END
GO
