USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_GlobalReport_CHall_saved092210]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_GlobalReport_CHall_saved092210]
as
--temporarily modified 9/22/10 to include CHPH_UD Aug sales
SELECT     p.PMID AS p_pmid, c.PMID, c.Date, 
			isnull(t.UDGeneric,0) as test1,
		isnull(c.CombGENTotalSrc,0) + isnull(t.UDGeneric,0) AS [Gen Src], 
c.CombGENTotal - c.CombGENTotalSrc AS [Gen Exc], --ok to exclude ud as all ud gen = src
                      isnull(c.CombGENTotal,0) + isnull(t.UDGeneric,0) AS [Gen Total], 
					  isnull(c.CombBrands,0) + isnull(t.UDBrand,0) AS [CH Brx], 
					  ISNULL(c.CombOTC, 0) + ISNULL(c.CombOther, 0) + isnull(t.UDOTC,0) AS [CH Oth], 
                      c.CombAdminOnly AS [UD Adm], 
					  c.CombNetSales  + isnull(t.UDNetSales,0) AS [CH Total]
FROM         dbo.PM_Pharmacy AS p 
					left outer join
					purchases..tmp_delete_CHPH_0810 t on p.pmid=t.pmid
					LEFT OUTER JOIN
                      dbo.CH_ALLPVA_SALES AS c ON p.PMID = c.PMID AND c.Date >= '1/1/2010'
UNION
SELECT     c.PMID AS p_pmid, c.PMID, c.Date, 
0.0 as test1,
c.CombGENTotalSrc AS [Gen Src], c.CombGENTotal - c.CombGENTotalSrc AS [Gen Exc], 
                      c.CombGENTotal AS [Gen Total], c.CombBrands AS [CH Brx], ISNULL(c.CombOTC, 0) + ISNULL(c.CombOther, 0) AS [CH Oth], 
                      c.CombAdminOnly AS [UD Adm], c.CombNetSales AS [CH Total]
FROM         dbo.CH_ALLPVA_SALES AS c LEFT OUTER JOIN
                      dbo.PM_Pharmacy AS p ON c.PMID = p.PMID AND c.Date >= '1/1/2010'
WHERE     (p.PMID IS NULL)
GO
