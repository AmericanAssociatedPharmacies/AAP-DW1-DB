USE [Medispan]
GO
/****** Object:  View [dbo].[v_DrugMaster2]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_DrugMaster2]
AS
-- added TC_GPI = left(GPI,10) and TC_GPI_Name 4/15 bg, using highest Record_Type_Code values 1,2,3,4
SELECT DISTINCT
			dbo.M25_A.NDC_UPC_HRI AS NDC, dbo.M25_G.Generic_Product_Identifier AS GPI, dbo.M25_J.Product_Description_Abbreviat AS DrugName, 
                      dbo.M25_J.Manufacturers_Labeler_Name AS MFG, dbo.f_MediDrugtypefull(dbo.M25_A.Multi_Source_Code, dbo.M25_A.Brand_Name_Code) AS DrugType, 
                      dbo.f_MediDrugtype(dbo.M25_A.Multi_Source_Code, dbo.M25_A.Brand_Name_Code) AS DrugTypeShort, dbo.M25_L.Package_Size_Unit_of_Measure AS Unit, 
                      dbo.M25_L.Dosage_Form AS Form, dbo.M25_L.Package_Size AS PS, dbo.M25_L.Package_Description AS PD, 
                      CASE RX_OTC_Indicator_Code WHEN 'R' THEN 'Rx' WHEN 'S' THEN 'Rx' WHEN 'O' THEN 'OTC' WHEN 'P' THEN 'OTC' END AS RxOTC, 
                      dbo.M25_L.Repackage_Code AS Repack, dbo.M25_G.GPI_Generic_Name AS GPIDesc, dbo.M25_M.Strength, dbo.M25_M.Strength_Unit_Measure, 
                      dbo.M25_M.Inactive_Date AS OBSDTEC, 
                      CASE DEA_Class_Code WHEN 'C-I' THEN 1 WHEN 'C-II' THEN 2 WHEN 'C-III' THEN 3 WHEN 'C-IV' THEN 4 WHEN 'C-V' THEN 5 ELSE 0 END AS DEA, 
                      dbo.v_LastWAC.WACPkg, dbo.v_LastWAC.WAC, dbo.v_LastWAC.WACEffDate, dbo.v_LastAWP.AWPPkg, dbo.v_LastAWP.AWP, dbo.v_LastAWP.AWPEffDate AS BBDC, 
                      dbo.M25_A.Multi_Source_Code AS MSC, dbo.M25_A.Brand_Name_Code AS BNC, dbo.M25_L.Package_Quantity AS CSP, dbo.M25_L.DESI_Code AS DESI, 
                      dbo.M25_A.DEA_Class_Code, dbo.M25_A.Route_of_Administration AS RouteAdmin, dbo.M25_A.RX_OTC_Indicator_Code, 
                      dbo.M25_A.Unit_Dose_Unit_of_Use_Package, dbo.M25_A.AHFSCC_Therapeutic_Class_Code
                      ,TCRF.Therapeutic_Classification_Co as TC_GPI
                      ,TCRF.TC_GPI_Name
                      --,TCRF.Record_Type_Code as TC_Code
FROM         dbo.M25_A LEFT OUTER JOIN
                      dbo.M25_J ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_J.NDC_UPC_HRI LEFT OUTER JOIN
                      dbo.v_LastAWP ON dbo.M25_A.NDC_UPC_HRI = dbo.v_LastAWP.NDC LEFT OUTER JOIN
                      dbo.v_LastWAC ON dbo.M25_A.NDC_UPC_HRI = dbo.v_LastWAC.NDC LEFT OUTER JOIN
                      dbo.M25_M ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_M.NDC_UPC_HRI LEFT OUTER JOIN
                      dbo.M25_L ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_L.NDC_UPC_HRI LEFT OUTER JOIN
                      dbo.M25_G ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_G.NDC_UPC_HRI
                      LEFT  JOIN 
                      (select *
						,row_number() over(partition by Therapeutic_Classification_co order by Record_Type_Code desc) as CodeRank
						from dbo.M25TCRF_5) TCRF
						on TCRF.Therapeutic_Classification_Co = left(dbo.M25_G.Generic_Product_Identifier,10) 
						and TCRF.CodeRank = 1

GO
