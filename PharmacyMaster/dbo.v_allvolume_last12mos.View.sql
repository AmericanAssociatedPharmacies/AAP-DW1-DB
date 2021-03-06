USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_allvolume_last12mos]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_allvolume_last12mos]
as
select PMID,
sum(WHAPITotal+CombNetSales+MLTotal) as volume_last12mos,
(select max([date]) from all_volume) as date_through
from all_volume
where [date] > dateadd(year,-1,(select max([date]) from all_volume)) --e.g. 4/1/12,4/1/13
and [date] <= (select max([date]) from all_volume)
group by pmid
--order by pmid
GO
