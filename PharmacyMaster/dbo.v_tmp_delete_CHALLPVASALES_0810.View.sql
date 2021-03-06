USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_tmp_delete_CHALLPVASALES_0810]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_tmp_delete_CHALLPVASALES_0810]
as

SELECT     Date, c.PMID, CHAccountNo, DCNum, DCCity, AccountName, Address, City, State, ZIP, APIAccountNo, AAPAccountNo, UDAccountNo, DEA, 
                      APICOGAppliedSales, APINetSales, APIGENRx, APIGENTotalSrc, APIGENTotalP2P3, APIGENTotal, APIBrand, APIOTC, APIOther, APIGBRPerc, 
                      AAPCOGAppliedSales, AAPNetSales, AAPBrand, AAPGENTotal, AAPGENTotalSrc, AAPGENExcl, AAPOTC, AAPOther, 
isnull(c.UDNetSales,0) + isnull(t.UDNetSales,0) AS [UDNetSales],
isnull(c.UDBrand,0) + isnull(t.UDBrand,0) AS UDBrand,
isnull(c.UDGENTotalSrc,0) + isnull(t.UDGeneric,0) AS UDGENTotalSrc,
isnull(c.UDGENTotal,0) + isnull(t.UDGeneric,0) AS UDGENTotal,
isnull(c.UDOTC,0) + isnull(t.UDOTC,0) AS UDOTC,
 c.UDOther, c.UDAdminOnly, CombNetSales, CombBrands, CombOTC, CombGENTotal, CombGENTotalSrc, 
                      CombOther, CombAdminOnly
FROM         dbo.CH_ALLPVA_SALES c
left join 					purchases..tmp_delete_CHPH_0810 t on c.pmid=t.pmid and c.date='8/1/2010'
where c.date='8/1/2010'


union


SELECT '8/1/2010' as  Date, 
t.PMID, '' as CHAccountNo, '' as DCNum, '' as DCCity, '' as AccountName, '' as Address, '' as City, '' as State, '' as ZIP, 
'' as APIAccountNo, '' as AAPAccountNo, '' as UDAccountNo, '' as DEA, 

                      0.0 as APICOGAppliedSales, 0.0 as APINetSales, 0.0 as APIGENRx, 0.0 as APIGENTotalSrc, 0.0 as APIGENTotalP2P3, 
0.0 as APIGENTotal, 0.0 as APIBrand, 0.0 as APIOTC, 0.0 as APIOther, 0.0 as APIGBRPerc, 
                      0.0 as AAPCOGAppliedSales, 0.0 as AAPNetSales, 0.0 as AAPBrand, 0.0 as AAPGENTotal, 0.0 as AAPGENTotalSrc, 0.0 as AAPGENExcl, 
0.0 as AAPOTC, 0.0 as AAPOther, t.UDNetSales, t.UDBrand, 
                      t.UDGeneric as UDGENTotalSrc, t.UDGeneric as UDGENTotal, t.UDOTC, t.UDOther, t.UDAdminOnly, 
t.UDNetSales as CombNetSales, t.UDBrand as CombBrands, t.UDOTC as CombOTC, t.UDGeneric as CombGENTotal, t.UDGeneric as CombGENTotalSrc, 
                      0.0 as CombOther, 0.0 as CombAdminOnly
from purchases..tmp_delete_CHPH_0810 t 
left join dbo.CH_ALLPVA_SALES c on t.pmid = c.pmid and c.date='8/1/2010'
where c.pmid is null --and c.date='8/1/2010'

GO
