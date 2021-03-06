USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_CH_ALLPVA_SALES_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_CH_ALLPVA_SALES_Load]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @Date Date
	SET @Date = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) -1, 0)
	--print @date

	MERGE [PharmacyMaster].[dbo].[CH_ALLPVA_SALES] AS T
	USING [PharmacyMaster].[Staging].[CH_ALLPVA_SALES] AS S
		   ON T.PMID = S.PMID 
		   AND T.Date = S.Date
		   AND T.Date >= @Date

WHEN MATCHED THEN

	UPDATE SET T.[CHAccountNo] = S.[CHAccountNo], 
			   T.[DCNum] = S.[DCNum], 
			   T.[DCCity] = S.[DCCity], 
			   T.[AccountName] = S.[AccountName], 
			   T.[Address] = S.[Address], 
			   T.[City] = S.[City], 
			   T.[State] = S.[State], 
			   T.[ZIP] = S.[ZIP], 
			   T.[APIAccountNo] = S.[APIAccountNo], 
			   T.[AAPAccountNo] = S.[AAPAccountNo], 
			   T.[UDAccountNo] = S.[UDAccountNo], 
			   T.[DEA] = S.[DEA], 
			   T.[APICOGAppliedSales] = S.[APICOGAppliedSales], 
			   T.[APINetSales] = S.[APINetSales], 
			   T.[APIGENRx] = S.[APIGENRx], 
			   T.[APIGENTotalSrc] = S.[APIGENTotalP2P3], 
			   T.[APIGENTotal] = S.[APIGENTotal], 
			   T.[APIBrand] = S.[APIBrand], 
			   T.[APIOTC] = S.[APIOTC], 
			   T.[APIOther] = S.[APIOther], 
			   T.[APIGBRPerc] = S.[APIGBRPerc], 
			   T.[AAPCOGAppliedSales] = S.[AAPCOGAppliedSales], 
			   T.[AAPNetSales] = S.[AAPNetSales], 
			   T.[AAPBrand] = S.[AAPBrand], 
			   T.[AAPGENTotal] = S.[AAPGENTotal], 
			   T.[AAPGENTotalSrc] = S.[AAPGENTotalSrc], 
			   T.[AAPGENExcl] = S.[AAPGENExcl], 
			   T.[AAPOTC] = S.[AAPOTC], 
			   T.[AAPOther] = S.[AAPOther], 
			   T.[UDNetSales] = S.[UDNetSales], 
			   T.[UDBrand] = S.[UDBrand], 
			   T.[UDGENTotalSrc] = S.[UDGENTotalSrc], 
			   T.[UDGENTotal] = S.[UDGENTotal], 
			   T.[UDOTC] = S.[UDOTC], 
			   T.[UDOther] = S.[UDOther], 
			   T.[UDAdminOnly] = S.[UDAdminOnly], 
			   T.[CombNetSales] = S.[CombNetSales],
			   T.[CombBrands] = S.[CombBrands], 
			   T.[CombOTC] = S.[CombOTC], 
			   T.[CombGENTotal] = S.[CombGENTotal], 
			   T.[CombGENTotalSrc] = S.[CombGENTotalSrc], 
			   T.[CombOther] = S.[CombOther], 
			   T.[CombAdminOnly] = S.[CombAdminOnly], 
			   T.[AAPTotalRX] = S.[AAPTotalRX], 
			   T.[AAPExcludedFromTotalRX] = S.[AAPExcludedFromTotalRX], 
			   T.[AAPNonRXOTCandHH] = S.[AAPNonRXOTCandHH], 
			   T.[AAPSourceCompliance] = S.[AAPSourceCompliance], 
			   T.[COGEligibleSales] = S.[COGEligibleSales], 
			   T.[NonContractGenericSales] = S.[NonContractGenericSales], 
			   T.[NetSourceGenerics] = S.[NetSourceGenerics]

WHEN NOT MATCHED THEN
	INSERT VALUES (S.[Date], S.[PMID], S.[CHAccountNo], S.[DCNum], S.[DCCity], S.[AccountName], S.[Address], S.[City], S.[State], S.[ZIP], S.[APIAccountNo], S.[AAPAccountNo], S.[UDAccountNo], S.[DEA], 
				   S.[APICOGAppliedSales], S.[APINetSales], S.[APIGENRx], S.[APIGENTotalSrc], S.[APIGENTotalP2P3], S.[APIGENTotal], S.[APIBrand], S.[APIOTC], S.[APIOther], S.[APIGBRPerc], S.[AAPCOGAppliedSales], 
				   S.[AAPNetSales], S.[AAPBrand], S.[AAPGENTotal], S.[AAPGENTotalSrc], S.[AAPGENExcl], S.[AAPOTC], S.[AAPOther], S.[UDNetSales], S.[UDBrand], S.[UDGENTotalSrc], S.[UDGENTotal], S.[UDOTC], S.[UDOther], 
				   S.[UDAdminOnly], S.[CombNetSales], S.[CombBrands], S.[CombOTC], S.[CombGENTotal], S.[CombGENTotalSrc], S.[CombOther], S.[CombAdminOnly], S.[AAPTotalRX], S.[AAPExcludedFromTotalRX], S.[AAPNonRXOTCandHH], 
				   S.[AAPSourceCompliance], S.[COGEligibleSales], S.[NonContractGenericSales], S.[NetSourceGenerics]);

END 
GO
