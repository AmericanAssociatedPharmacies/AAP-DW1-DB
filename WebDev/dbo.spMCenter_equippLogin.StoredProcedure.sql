USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spMCenter_equippLogin]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spMCenter_equippLogin]
(
	@PMID int
)
as
declare @cnt int
declare @dt datetime
set @dt = '4/15/2014'
select @cnt = count(1) from Equipp_Logins where PMID=@PMID and convert(datetime,DistributionDate) <= @dt
select case when @cnt > 0 then 1 else 0 end as result
GO
