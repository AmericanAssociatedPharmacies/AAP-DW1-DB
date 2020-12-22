USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spMCenter_Chaincode426]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spMCenter_Chaincode426]
(
	@PMID int
)
as
declare @cnt int
select @cnt = count(1) from v_web_userdata where chaincode=426 
and isMC=1 and mcquitdate is null and pmid=@PMID 
select case when @cnt > 0 then 1 else 0 end as result
GO
