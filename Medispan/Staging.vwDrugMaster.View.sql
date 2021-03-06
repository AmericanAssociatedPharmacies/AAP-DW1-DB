USE [Medispan]
GO
/****** Object:  View [Staging].[vwDrugMaster]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [Staging].[vwDrugMaster]

AS


SELECT CONVERT(VARCHAR(11), LTRIM(RTRIM(A.NDC_UPC_HRI))) AS NDC
, CONVERT(VARCHAR(11), LTRIM(RTRIM(
					   CASE
						 WHEN A.ID_Number_Format_Code = 1 THEN STUFF(A.NDC_UPC_HRI, 1, 1, '')
						 WHEN A.ID_Number_Format_Code = 2 THEN STUFF(A.NDC_UPC_HRI, 6, 1, '')
						 WHEN A.ID_Number_Format_Code = 3 THEN STUFF(A.NDC_UPC_HRI, 10, 1, '')
						 WHEN A.ID_Number_Format_Code = 4 THEN STUFF(A.NDC_UPC_HRI, 1, 1, '')
						 WHEN A.ID_Number_Format_Code = 5 THEN STUFF(A.NDC_UPC_HRI, 6, 1, '')
						 WHEN A.ID_Number_Format_Code = 6 THEN (A.NDC_UPC_HRI)
					   END 
					   )))AS NDC_10 --Per Grant request //servicedesk.rxaap.com/app/itdesk/WorkOrder.do?woMode=viewWO&woID=96326000000654047
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.ID_Number_Format_Code))) AS IDCode --Per Grant request //servicedesk.rxaap.com/app/itdesk/WorkOrder.do?woMode=viewWO&woID=96326000000654047
, CONVERT(VARCHAR(14), LTRIM(RTRIM(B.Generic_Product_Identifier))) AS GPI
, CONVERT(VARCHAR(25), LTRIM(RTRIM(c.Drug_Name))) AS DrugName
, CONVERT(VARCHAR(30), LTRIM(RTRIM(D.Manufacturers_Labeler_Name))) AS MFG
, CONVERT(VARCHAR(50), LTRIM(RTRIM(dbo.f_MediDrugtypefull(A.Multi_Source_Code, C.Brand_Name_Code)))) AS DrugType
, CONVERT(VARCHAR(3), LTRIM(RTRIM(dbo.f_MediDrugtype(A.Multi_Source_Code, C.Brand_Name_Code)))) AS DrugTypeShort
, CONVERT(VARCHAR(2), LTRIM(RTRIM(B.Package_Size_Unit_of_Measure))) AS Unit
, CONVERT(VARCHAR(4), LTRIM(RTRIM(C.Dosage_Form))) AS Form
, CONVERT(DECIMAL(10,3), B.Package_Size * 1.000) AS PS
, CONVERT(VARCHAR(10), LTRIM(RTRIM(H.PackageDescription))) AS PD
, CONVERT(VARCHAR(3), LTRIM(RTRIM(CASE 
       WHEN A.RX_OTC_Indicator_Code IN('O', 'P') THEN 'OTC'
       WHEN A.RX_OTC_Indicator_Code IN('R', 'S') THEN 'Rx'
       END))) AS RxOTC
, CONVERT(VARCHAR(1), LTRIM(RTRIM(CASE 
       WHEN A.Repackage_Code NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE A.Repackage_Code
       END
	   ))) AS Repack
, CONVERT(VARCHAR(60), LTRIM(RTRIM(E.TC_GPI_Name))) AS GPIDesc
, CONVERT(VARCHAR(25), LTRIM(RTRIM(
			CASE
			WHEN C.Strength NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
			ELSE C.Strength
			END)))AS Strength
, CONVERT(VARCHAR(15), c.Strength_Unit_of_Measure) AS Strength_Unit_of_Measure -- Erroring out as of 11/03/2017
, NULL AS OBSDTEC -- Obsolete per email from Tristan on 10/17/2017
, CASE 
       WHEN A.DEA_Class_Code NOT LIKE '%[a-zA-Z0-9]%' THEN '0'
       ELSE LTRIM(RTRIM(A.DEA_Class_Code ))
       END AS DEA
, CONVERT(DECIMAL(18,5), F.Package_Price * 1.00) AS WACPkg
, CONVERT(DECIMAL(18,5), F.Unit_Price * 1.00000) AS WAC
, CONVERT(SMALLDATETIME, CONVERT(VARCHAR, F.Effective_Date, 110), 110) AS WACEffDate
, CONVERT(NUMERIC(10,2), G.Package_Price) AS AWPPkg
, CONVERT(NUMERIC(13,5), G.Unit_Price) AS AWP
, CONVERT(SMALLDATETIME, CONVERT(VARCHAR, G.Effective_Date, 110), 110) AS BBDC
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Multi_Source_Code))) AS MSC
, CONVERT(VARCHAR(1), LTRIM(RTRIM(C.Brand_Name_Code))) AS BNC
, CONVERT(NUMERIC(37,0), B.Package_Quantity) AS CSP
, CONVERT(VARCHAR(1), LTRIM(RTRIM(CASE 
							WHEN A.DESI_Code NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE A.DESI_Code
							END)	)
		 ) AS DESI
, CONVERT(VARCHAR(5), LTRIM(RTRIM(CASE
								   WHEN DEA_Class_Code = '1' THEN 'C-I'
								   WHEN DEA_Class_Code = '2' THEN 'C-II'
								   WHEN DEA_Class_Code = '3' THEN 'C-III'
								   WHEN DEA_Class_Code = '4' THEN 'C-IV'
								   WHEN DEA_Class_Code = '5' THEN 'C-V'
								   ELSE 'N\A'
								   END)
								)
	   ) AS DEA_Class_Code
, CONVERT(VARCHAR(2), LTRIM(RTRIM(C.Route_of_Administration))) AS RouteAdmin
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.RX_OTC_Indicator_Code)))  AS RX_OTC_Indicator_Code
, CONVERT(VARCHAR(1), LTRIM(RTRIM(CASE
       WHEN B.Unit_DoseUnit_of_Use_Package NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE B.Unit_DoseUnit_of_Use_Package
       END))) AS Unit_DoseUnit_of_Use_Package
, NULL AS AHFSCC_Therapeutic_Class_Code -- Could not find in any object
, b.Generic_Product_Packaging_Code AS GPPC
, CONVERT(NUMERIC(37,0),b.Package_Quantity) AS PackageQuantity
FROM [Medispan_Staging].dbo.MF2NDC_H AS A
LEFT OUTER JOIN [Medispan_Staging].dbo.MF2GPPC_J AS B ON A.Generic_Product_Packaging_Code = B.Generic_Product_Packaging_Code
LEFT OUTER JOIN [Medispan_Staging].dbo.MF2NAME_F AS C ON C.Drug_Descriptor_Identifier = A.Drug_Descriptor_Identifier
LEFT OUTER JOIN [Medispan_Staging].dbo.MF2LAB_I AS D ON A.Medi_Span_Labeler_Identifier = D.Medi_Span_Labeler_Identifier
LEFT OUTER JOIN [Medispan_Staging].dbo.MF2TCGPI_G AS E ON B.Generic_Product_Identifier = E.TC_GPI_Key
LEFT OUTER JOIN [Medispan_Staging].dbo.MF2PRC_M AS F ON F.NDC_UPC_HRI = A.NDC_UPC_HRI AND F.Price_Code = 'W' -- WAC
LEFT OUTER JOIN [Medispan_Staging].dbo.MF2PRC_M AS G ON G.NDC_UPC_HRI = A.NDC_UPC_HRI AND G.Price_Code = 'A' -- AWP
LEFT OUTER JOIN DrugMaster.dbo.PackageDescription AS H ON B.Package_Description_Code = H.PackageCode





GO
