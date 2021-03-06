USE [Medispan]
GO
/****** Object:  View [dbo].[vwDrugDim]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO














CREATE VIEW [dbo].[vwDrugDim]

AS

SELECT LTRIM(RTRIM(REPLACE(REPLACE(dm.NDC, ' ', ''), '  ',''))) AS NDC
, dm.GPI
, dm.GPPC
, dm.DrugName
, dm.[GPIDesc] AS Description
, dm.MFG AS Manufacturer
, dm.DrugType
, dm.Unit AS UnitofMeasure
, dm.Form
, dm.PS AS PackageSize
, CASE 
	WHEN dm.RxOTC = 'RX' THEN 1
	ELSE 0
	END AS IsRX
, CASE 
	WHEN dm.RxOTC = 'OTC' THEN 1
	ELSE 0
	END AS IsOTC
, dm.Strength
, dm.Strength_Unit_Measure AS StrengthUnitMeasure
, dm.DEA AS ControlledDrugClass
, dm.WACPkg AS WACPackagePrice
, CONVERT(MONEY, CONVERT(DECIMAL(10,2), dm.WAC)) AS WACPerDose
, dm.AWPPkg AS AWPPackagePrice
, dm.AWP AS AWPPerDose 
, CASE 
	WHEN dm.Unit_Dose_Unit_of_Use_Package = 'U' THEN 1
	ELSE 0
	END AS IsUnitDose
, dm.DrugType AS DrugTypeLongDescription
, dm.DrugTypeShort AS DrugTypeShortDescription
, CASE
	WHEN dm.RxOTC <> 'OTC' AND dm.DrugTypeShort LIKE '%GEN%' THEN 1
	ELSE 0
	END AS IsGenericNonOTC
, CASE
	WHEN dm.RxOTC <> 'OTC' AND dm.DrugType LIKE '%BRAND%' THEN 1
	ELSE 0
	END AS IsBrandNonOTC
, MSC AS MultiSourceCode
, CASE
	WHEN MSC = 'M' THEN 'Multi-Source brand name drug with no generics available'
	WHEN MSC = 'N' THEN 'Single-Source brand name drug with no generics available'
	WHEN MSC = 'O' THEN 'Original brand name drug with generics available'
	WHEN MSC = 'Y' THEN 'GenericDrug'
	ELSE NULL
	END AS MultiSourceCodeDescription
, CASE 
	WHEN MSC = 'M' THEN 1
	ELSE 0
	END AS IsMultiSourceBrandNoGenerics
, CASE 
	WHEN MSC = 'N' THEN 1
	ELSE 0
	END AS IsSingleSourceBrandNoGenerics
, CASE 
	WHEN MSC = 'O' THEN 1
	ELSE 0
	END AS IsOriginalBrandWithGenerics
, CASE 
	WHEN MSC = 'Y' THEN 1
	ELSE 0
	END AS IsGeneric
, BNC AS BrandNameCode
, CASE            
    WHEN BNC =  'T' THEN 'Trademarked Name'
    WHEN BNC = 'B' THEN 'Branded Generic Name'
    WHEN BNC = 'G' THEN 'Generic Name' 
    END BrandNameCodeDescription
, [PackageQuantity]
FROM [dbo].[DrugMaster] AS dm

--SELECT dm.NDC
--, dm.GPI
--, dm.GPPC
--, dm.DrugName
--, dm.[GPIDesc] AS Description
--, dm.MFG AS Manufacturer
--, dm.DrugType
--, dm.Unit AS UnitofMeasure
--, dm.Form
--, dm.PS AS PackageSize
--, CASE 
--	WHEN dm.RxOTC = 'RX' THEN 1
--	ELSE 0
--	END AS IsRX
--, CASE 
--	WHEN dm.RxOTC = 'OTC' THEN 1
--	ELSE 0
--	END AS IsOTC
--, dm.Strength
--, dm.Strength_Unit_Measure AS StrengthUnitMeasure
--, dm.DEA AS ControlledDrugClass
--, dm.WACPkg AS WACPackagePrice
--, CONVERT(MONEY, CONVERT(DECIMAL(10,2), dm.WAC)) AS WACPerDose
--, dm.AWPPkg AS AWPPackagePrice
--, dm.AWP AS AWPPerDose 
--, CASE 
--	WHEN dm.Unit_Dose_Unit_of_Use_Package = 'U' THEN 1
--	ELSE 0
--	END AS IsUnitDose
--, dm.DrugType AS DrugTypeLongDescription
--, dm.DrugTypeShort AS DrugTypeShortDescription
--, CASE
--	WHEN dm.RxOTC <> 'OTC' AND dm.DrugTypeShort LIKE '%GEN%' THEN 1
--	ELSE 0
--	END AS IsGenericNonOTC
--, CASE
--	WHEN dm.RxOTC <> 'OTC' AND dm.DrugType LIKE '%BRAND%' THEN 1
--	ELSE 0
--	END AS IsBrandNonOTC
--, MSC AS MultiSourceCode
--, CASE 
--	WHEN MSC = 'M' THEN 1
--	ELSE 0
--	END AS IsMultiSourceBrandNoGenerics
--, CASE 
--	WHEN MSC = 'N' THEN 1
--	ELSE 0
--	END AS IsSingleSourceBrandNoGenerics
--, CASE 
--	WHEN MSC = 'O' THEN 1
--	ELSE 0
--	END AS IsOriginalBrandWithGenerics
--, CASE 
--	WHEN MSC = 'Y' THEN 1
--	ELSE 0
--	END AS IsGeneric
--FROM [dbo].[DrugMaster] AS dm















GO
