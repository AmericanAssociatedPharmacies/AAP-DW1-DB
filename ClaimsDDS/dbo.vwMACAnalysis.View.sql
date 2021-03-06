USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwMACAnalysis]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwMACAnalysis]

WITH SCHEMABINDING

AS


SELECT pd.PharmacyKey
, cf.DrugKey
, ed.EventKey
, cf.DateOfServiceKey
, ED.BINNumber
, ED.PrescriptionNumber
, ED.GroupID AS PayerName
, CF.QuantityDispensed
, CONVERT(DATE, ED.DateOfService) AS [RXDateFilled]
, [UsualandCustomaryCharge]
, CF.TotalPrice AS [RX30TotalPrice]
, CONVERT(MONEY, (CF.TotalPrice / CF.QuantityDispensed)) AS [RX30ReimbursedPricePerUnit]
, cf.OtherAmount AS [TotalPharmacyPaid]
, dd.NDC
, dd.DrugName
, dd.Form AS DrugForm
, dd.PackageSize
, pd.PMID
--, dd.CSP
, dd.Description AS ProductionDescription
FROM [dbo].[ClaimFactRX30] AS CF
INNER JOIN [dbo].[EventDimRX30] AS ED ON CF.EventKey = ED.EventKey
INNER JOIN [dbo].[PharmacyDim] AS pd ON pd.PharmacyKey = cf.PharmacyKey
INNER JOIN dbo.DrugDim AS dd ON cf.DrugKey = dd.DrugKey
WHERE cf.TotalPrice > 0
AND CF.QuantityDispensed >= 1
AND dd.DrugType LIKE '%GENERIC%'
AND dd.IsOTC = 0
AND pd.PMID > 0
AND pd.APIStatusName = 'Active'
AND pd.AAPQuitDate IS NULL				
AND pd.AAPNumber IS NOT NULL




GO
