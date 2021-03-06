USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_DDI_test]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spQC_DDI_test]
(
@ncpdp varchar(7),
@showall int	--1 show all, 0 except hide=1
)
as
declare @test int
set @test=case when @showall=1 then 2 else 1 end
begin
	select 

d.patid as Patient
,drugname as [Drug 1]
,ddidrugname as [Drug 2]
,rxnbr as [Rx 1]
,CONVERT(VARCHAR(8),[rx date],1) as [RxDate 1]
,[day supply] as [DS 1]
--,cast(rfnbr as varchar(5)) + case when ra is null then '' else '/' + cast(ra as varchar(5)) end as [Rfl 1]
,rfnbr as [Rfl 1]
,ddirxnbr as [Rx 2]
,CONVERT(VARCHAR(8),[ddirxdate],1) as [RxDate 2]
,ddids as [DS 2]
--,cast(ddirfnbr as varchar(5)) + case when ddira is null then '' else '/' + cast(ddira as varchar(5)) end as [Rfl 2]
,ddirfnbr as [Rfl 2]

from [QC_DDI_test] d
where pharmid=@ncpdp and isnull(hide,0)<>@test
order by pharmid,case when [rx date]> ddirxdate then [rx date] else ddirxdate end  desc


end

GO
