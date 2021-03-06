USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_GlobalReport_volume]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_GlobalReport_volume]
as
--combine CH,API,ML,Anda –revised 7/20

select
ca.pmid,
ca.[date],
cast(month(ca.date) as varchar(2)) + '/' + cast(year(ca.date) as varchar(4)) as [month],
[Gen Src],[Gen Exc],[Gen Total],[CH Br] as [CH Br],[CH Oth],[UD Adm],[CH Total],
[API_BR],[API_GEN],[API_OTC],[API_Total],
ca.[ML_Total],
anda.volume as [Anda_Total],
isnull([CH total],0) + isnull([API_Total],0) + isnull(ca.[ML_Total],0) + isnull(anda.[volume],0) as [All_Total]

from v_GlobalReport_CHALL_and_API_and_ML ca
left join v_AndaVolume2010 anda on ca.pmid=anda.pmid and ca.date=anda.date

--where (isnull([CH total],0) + isnull([API_Total],0) + isnull(ca.[ML_Total],0) + isnull(anda.[volume],0)) <> 0
--order by p_pmid,[month]

union all -- fixes sum 'bug' 07/20/10 13:56:44

select anda.pmid,
anda.[date],
cast(month(ca.date) as varchar(2)) + '/' + cast(year(ca.date) as varchar(4)) as [month],
[Gen Src],[Gen Exc],[Gen Total],[CH Br] as [CH Br],[CH Oth],[UD Adm],[CH Total],
[API_BR],[API_GEN],[API_OTC],[API_Total],
ca.[ML_Total],
anda.volume as [Anda_Total],
isnull([CH total],0) + isnull([API_Total],0) + isnull(ca.[ML_Total],0) + isnull(anda.[volume],0) as [All_Total]

from v_AndaVolume2010 anda
left join v_GlobalReport_CHALL_and_API_and_ML ca
	on anda.pmid=ca.pmid and anda.date=ca.date
	where ca.pmid is null
GO
