USE [MedispanImages]
GO
/****** Object:  View [dbo].[vw_medispan_erpapi_old]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  *****
and MFG like 'CERN%'
order by m.NDC*/
CREATE VIEW [dbo].[vw_medispan_erpapi_old]
AS
SELECT DISTINCT 
                         m.NDC, m.NDC_10, f.Formatted_ID_Number AS ndc_upc_hri_formatted, m.GPI, m.DrugName AS drug_name, m.GPIDesc AS description, m.MFG AS manufacturer, m.DrugType AS drug_type, m.Form, 
                         m.PD AS packaging_description, CAST(m.PackageQuantity AS VARCHAR(10)) + ' X ' + CAST(CAST(m.PS AS float) AS VARCHAR(10)) + ' ' + LOWER(m.Unit) AS qty, m.RxOTC AS rx_or_otc, m.AWP, 
                         m.RouteAdmin AS route_of_administration, { fn CONCAT(m.Strength, m.Strength_Unit_Measure) } AS strength, m.Strength_Unit_Measure AS unit_of_measure, m.Unit, m.DEA AS dea_schedule, f.TEE_Code AS ab_code, 
                         i.Image_Filename, o.DrugName AS brand_name, a.TC_GPI_Name AS drug_class, b.TC_GPI_Name AS drug_subclass
FROM            Medispan.dbo.DrugMaster AS m LEFT OUTER JOIN
                         Medispan.dbo.M25_A AS f ON m.NDC = f.NDC_UPC_HRI LEFT OUTER JOIN
                         dbo.vw_image_by_ndc AS i ON m.NDC = i.NDC LEFT OUTER JOIN
                         Medispan.dbo.DrugMaster AS o ON m.GPI = o.GPI AND o.MSC = 'o' LEFT OUTER JOIN
                         Medispan.dbo.M25TCRF_5 AS a ON LEFT(m.GPI, 4) = LEFT(a.Therapeutic_Classification_Co, 4) AND a.Record_Type_Code = 2 LEFT OUTER JOIN
                         Medispan.dbo.M25TCRF_5 AS b ON LEFT(m.GPI, 6) = LEFT(b.Therapeutic_Classification_Co, 6) AND b.Record_Type_Code = 3

GO
