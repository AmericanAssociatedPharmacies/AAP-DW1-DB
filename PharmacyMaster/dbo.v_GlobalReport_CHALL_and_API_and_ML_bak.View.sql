USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_GlobalReport_CHALL_and_API_and_ML_bak]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[v_GlobalReport_CHALL_and_API_and_ML_bak]
as
select
ca.p_pmid as pmid,
ca.[date],
cast(month(ca.date) as varchar(2)) + '/' + cast(year(ca.date) as varchar(4)) as [month],
[Gen Src],[Gen Exc],[Gen Total],[CH BRx] as [CH Br],[CH Oth],[CH Total],
[API_BR],[API_GEN],[API_OTC],[API_Total],
ml.volume as [ML_Total]

from v_GlobalReport_CHALL_and_API ca

left join v_MLAdminVolume2010 ml on ca.p_pmid=ml.pmid and ca.date=ml.date
--where ml.pmid is not null

union

select

ml.pmid as pmid,
ml.date,
cast(month(ml.date) as varchar(2)) + '/' + cast(year(ml.date) as varchar(4)) as [month],
[Gen Src],[Gen Exc],[Gen Total],[CH BRx] as [CH Br],[CH Oth],[CH Total],
[API_BR],[API_GEN],[API_OTC],[API_Total],
ml.volume as [ML_Total]

from
v_MLAdminVolume2010 ml
left join
v_GlobalReport_CHALL_and_API ca on ml.pmid=ca.p_pmid and ml.date=ca.date
where ca.p_pmid is null
GO
