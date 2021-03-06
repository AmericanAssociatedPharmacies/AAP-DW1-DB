USE [Analysis]
GO
/****** Object:  View [dbo].[vw_AVGSalesReport]    Script Date: 12/22/2020 6:06:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_AVGSalesReport]

AS

SELECT distinct p.PMID, TerritoryName, PharmacyName, AAPNumber, AAPParent,
                GroupNo, City, State, AAPEffectiveDate, AAPQuitDate, TotalBRx,TotalGRx ,OtherRx
                ,NonRx,Excluded,AVGTotal,T.APIBrand,APIGen,T.APIOTC
FROM TestSalesAvg T
LEFT JOIN [RxMaster].dbo.PharmacyDim P
		on T.PMID = P.PMID
LEFT JOIN [PharmacyMaster].dbo.All_Volume_New V 
		on P.PMID = V.PMID



GO
