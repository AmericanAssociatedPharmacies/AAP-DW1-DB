USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_GlobalReport_CHallv1]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view
[dbo].[v_GlobalReport_CHallv1]
as
--view with all PMIDs, and renamed columns from CH_ALLPVA_SALES_TEST

--union part 1 sales for those in pm
select
p.pmid as p_pmid,
c.pmid,
c.date,
--cast(month(c.date) as varchar(2)) + '/' + cast(year(c.date) as varchar(4)) as [month],
c.CombGENTotalSrc as [Gen Src],
c.CombGENTotal - c.CombGENTotalSrc as [Gen Exc],
c.CombGENTotal as [Gen Total],
c.CombBrands as [CH Brx],
c.CombOTC + CombOther as [CH Oth],
c.CombNetSales as [CH Total]

from pm_pharmacy p left join CH_ALLPVA_SALES c on p.pmid=c.pmid and c.date >= '1/1/2010'

--and (c.CombNetSales <>0)

union 
--union part 2 those in ch_allpva not in pm (temp pmids 4,5,7,8)
select
c.pmid as p_pmid,
c.pmid,
c.date,
--cast(month(c.date) as varchar(2)) + '/' + cast(year(c.date) as varchar(4)) as [month],
c.CombGENTotalSrc as [Gen Src],
c.CombGENTotal - c.CombGENTotalSrc as [Gen Exc],
c.CombGENTotal as [Gen Total],
c.CombBrands as [CH Brx],
c.CombOTC as [CH Oth],
c.CombNetSales as [CH Total]
from CH_ALLPVA_SALES  c left join pm_pharmacy p on c.pmid=p.pmid and c.date >= '1/1/2010'

where p.pmid is null
GO
