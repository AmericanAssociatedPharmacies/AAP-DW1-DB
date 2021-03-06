USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_AAPPVA_ActiveYTD]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_AAPPVA_ActiveYTD]
as
select dt.PMID, p.AAPAccountNo, p.APIAccountNo,p.DEA
from
(
select distinct PMID
from
CH_ALLPVA_SALES c
where date >= '1/1/2010' --and date <= '6/1/2010'
and AAPNetSales <> 0
and PMID >= 100000
) dt
left join pm_pharmacy p on dt.pmid=p.pmid
GO
