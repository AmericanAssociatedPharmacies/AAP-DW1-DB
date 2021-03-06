USE [ClaimsDDS]
GO
/****** Object:  View [Archive].[vwFDS]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE VIEW [Archive].[vwFDS]

AS

SELECT s.RN
, s.RowID
, s.DateKey
, ISNULL(ISNULL(ISNULL(lj.PharmacyKey, lj1.PharmacyKey), lj2.PharmacyKey), 0) AS PharmacyKey
, s.ClaimStatusCode
, s.ClaimStatusCodeDescription
, s.ServiceProviderIDQualifier
, s.ServiceProviderIDQualifierDescription
, s.ServiceProviderID
, s.TransactionDate
, s.PrescriptionNumber
, s.RefillNumber
, s.FillDate
, s.DispensedProductQualifier
, s.DispensedProductQualifierDescription
, s.DispensedProductID
, s.PayerSequence
, s.PayerSequenceDescription
, s.BIN
, s.PCN
, s.GroupNumber
, s.InsurerCode
, s.InsurerName
, s.PlanCode
, s.PlanName
, s.PrescriberQualifier
, s.PrescriberQualifierDescription
, s.PrescriberSubmittedID
, s.PrescriberLastName
, s.PrescriberFirstName
, s.PrescriberStreetAddress
, s.PrescriberCity
, s.PrescriberStateCode
, s.PrescriberZipCode
, s.PrescriberPhoneNumber
, s.OrigininallyPrescribedProduct
, s.PrescribedRefills
, s.RXExpirationDate
, s.DAW
, f.Description AS DAWDescription
, s.DateWritten
, s.OriginCode
, s.OriginCodeDescription
, s.CompoundCode
, s.CompoundCodeDescripiton
, s.TotalQuantity
, s.ContractCost
, s.AWP
, s.UandC
, s.CopayAmountSubmitted
, s.IngredientCostSubmitted
, s.DispensingFeeSubmitted
, s.IncentiveFeeSubmitted
, s.SalesTaxSubmitted
, s.CopayAmountPaid
, s.IngredientCostPaid
, s.DispensingFeePaid
, s.SalesTaxPaid
, s.IncentiveFeePaid
, s.ClaimAmountPaid
, s.BasisCostCode
, CONVERT(VARCHAR(255), b.Description) AS BasisCostCodeDescription
, s.QuantityDispensed
, s.DaysSupply
, s.PharmacistInitials
, s.RejectMessageCount
, s.RejectMessages
, s.AuthNumber
, s.BasisOfReimbursementDetermination
, CONVERT(VARCHAR(255), br.Description) AS BasisOfReimbursementDeterminationDescription
, s.PlaceOfService
, CONVERT(VARCHAR(255), ps.Description) AS PlaceOfServiceDescription
, s.ProviderIDQualifier
, s.ProviderIDQualifierDescription
, s.ProviderID
, s.AdjustedContractCost
, s.Is340BClaim
, s.PrescriptionStatus
, s.PrescriptionStatusDescription
, s.ProductSource
, s.FileProcessed
, s.RowversionID
, s.PMID
FROM(SELECT ROW_NUMBER() OVER(PARTITION BY s.RowID ORDER BY(SELECT NULL)) AS RN
	, s.RowID 
	, CAST(CONVERT(varchar(20),CONVERT(DATETIME, s.FillDate),112) as INT) AS DateKey
	--, ISNULL(ISNULL(lj.PharmacyKey, lj1.PharmacyKey), lj2.PharmacyKey) AS PharmacyKey
	, CONVERT(VARCHAR(1), s.ClaimStatusCode) AS ClaimStatusCode
	, CONVERT(VARCHAR(255), CASE      
									  WHEN ClaimStatusCode = 'V' THEN 'REVERSAL'
									  WHEN ClaimStatusCode = 'C' THEN 'CASH'
									  WHEN ClaimStatusCode = 'P' THEN 'PAID'
									  WHEN ClaimStatusCode = 'R' THEN 'REJECTED'
									  ELSE NULL
									  END
						 ) AS ClaimStatusCodeDescription
	, CONVERT(VARCHAR(2), ServiceProviderIDQualifier) AS ServiceProviderIDQualifier
	, CASE
		   WHEN ServiceProviderIDQualifier = '01' THEN 'NPI'
		   WHEN ServiceProviderIDQualifier = '07' THEN 'NCPDP'
		   END AS ServiceProviderIDQualifierDescription
	, CONVERT(VARCHAR(100), [ServiceProviderID]) AS ServiceProviderID
	, CONVERT(DATETIME, CONVERT(DATETIME2, TRansactionDate)) AS TransactionDate
	, CONVERT(VARCHAR(100), [RXNumber]) AS [PrescriptionNumber]
	, CONVERT(INT, [RefillNumber]) AS [RefillNumber]
	, CONVERT(DATE, [FillDate]) AS FillDate
	, CONVERT(VARCHAR(25), [DispensedProductQualifier]) AS DispensedProductQualifier
	, CONVERT(VARCHAR(100), CASE 
											 WHEN DispensedProductQualifier = '0' THEN 'Compound ID'
											 WHEN DispensedProductQualifier = '3' THEN 'NDC'
											 WHEN DispensedProductQualifier = '36' THEN 'Representative NDC'
											 ELSE NULL
											 END
						 ) AS DispensedProductQualifierDescription
	, CONVERT(VARCHAR(100), DispensedProductID) AS DispensedProductID
	, CONVERT(CHAR(1), s.PayerSequence) AS PayerSequence
	, CASE 
		   WHEN PayerSequence = '1' THEN 'PRIMARY'
		   WHEN PayerSequence = '2' THEN 'Secondary'
		   WHEN PayerSequence = '3' THEN 'Teritiary'
		   ELSE NULL
		   END AS [PayerSequenceDescription] 
	, CONVERT(VARCHAR(100), CASE      
							WHEN BIN NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE BIN
							END
				  ) AS BIN
	, CONVERT(VARCHAR(100), CASE
							WHEN PCN NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PCN
							END) AS PCN
	, CONVERT(VARCHAR(100), CASE
							WHEN GroupNumber NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE GroupNumber
							END
				  ) AS GroupNumber
	, CONVERT(VARCHAR(100), CASE      
							WHEN InsurerCode NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE InsurerCode
							END
				  ) AS InsurerCode
	, CONVERT(VARCHAR(255), CASE      
							WHEN InsurerName NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE InsurerName
							END
				  ) AS InsurerName
	, CONVERT(VARCHAR(100), CASE      
							WHEN PlanCode NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PlanCode
							END
				  ) AS PlanCode
	, CONVERT(VARCHAR(255), CASE      
							WHEN PlanName NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PlanName
							END
				  ) AS PlanName
	, CONVERT(VARCHAR(25), CASE 
							WHEN PrescriberQualifier NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PrescriberQualifier
							END) AS PrescriberQualifier
	, CONVERT(VARCHAR(255), NULL) AS PrescriberQualifierDescription 
	, CONVERT(VARCHAR(25), CASE 
							WHEN PrescriberSubmittedID NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PrescriberSubmittedID
							END) AS PrescriberSubmittedID
	, CONVERT(VARCHAR(255), CASE      
							WHEN PrescriberLastName NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PrescriberLastName
							END) AS PrescriberLastName
	, CONVERT(VARCHAR(255), CASE      
							WHEN PrescriberFirstName NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PrescriberFirstName
							END) AS PrescriberFirstName
	, CONVERT(VARCHAR(500), CASE      
							WHEN s.PrescriberStreetAddress NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE s.PrescriberStreetAddress
							END) AS PrescriberStreetAddress
	, CONVERT(VARCHAR(255), CASE      
							WHEN PrescriberCity NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PrescriberCity
							END) AS PrescriberCity
	, CONVERT(VARCHAR(25), CASE      
							WHEN s.PrescriberStateCode NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE s.PrescriberStateCode
							END) AS PrescriberStateCode
	, CONVERT(VARCHAR(25), CASE 
							WHEN PrescriberZipCode NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE PrescriberZipCode
							END) AS PrescriberZipCode
	, CONVERT(VARCHAR(25), CASE 
							WHEN PrescriberPhoneNumber NOT LIKE '%[0-9]%' THEN NULL
							WHEN  DATALENGTH(PrescriberPhoneNumber) < 10 THEN NULL
							ELSE PrescriberPhoneNumber
							END) AS PrescriberPhoneNumber
	, CONVERT(VARCHAR(25), CASE 
							WHEN [OriginallyPrescribedProduct] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE [OriginallyPrescribedProduct]
							END) AS OrigininallyPrescribedProduct
	, CONVERT(INT, CASE  
					WHEN PrescribedRefills NOT LIKE '%[0-9]%' THEN NULL
					ELSE PrescribedRefills
					END) AS PrescribedRefills
	, CONVERT(DATE, RXExpirationDate) AS RXExpirationDate
	, CONVERT(VARCHAR(23), CASE 
							WHEN DAW NOT LIKE '%[0-9]%' THEN 0
							ELSE DAW
							END) AS DAW
	--, f.Description AS DAWDescription
	, CONVERT(DATE, s.DateWritten) AS DateWritten
	, CONVERT(VARCHAR(2), CASE 
							WHEN s.OriginCode NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE s.OriginCode
							END) AS OriginCode
	, CONVERT(VARCHAR(100), CASE
							WHEN s.OriginCode = '0' THEN 'Not Known'
							WHEN s.OriginCode = '1' THEN 'Written'
							WHEN s.OriginCode = '2' THEN 'Telephone'
							WHEN s.OriginCode = '3' THEN 'Electronic'
							WHEN s.OriginCode = '4' THEN 'Fax'
							WHEN s.OriginCode = '5' THEN 'Pharmacy'
							ELSE NULL
							END) AS OriginCodeDescription
	, CONVERT(VARCHAR(2), s.CompoundCode) AS CompoundCode
	, CONVERT(VARCHAR(100), CASE
							WHEN s.CompoundCode = '0' THEN 'Not Specified'
							WHEN s.CompoundCode = '1' THEN 'Not a Compound'
							WHEN s.CompoundCode = '2' THEN 'Compound'
							END) AS CompoundCodeDescripiton
	, CONVERT(DECIMAL(15,3), NULLIF(s.TotalQuantity, '')) AS TotalQuantity
	, CONVERT(MONEY, s.ContractCost) AS ContractCost
	, CONVERT(MONEY, s.[AverageWholeSalePrice]) AS AWP
	, CONVERT(MONEY, s.UsualAndCustomary) AS UandC
	, CONVERT(MONEY, s.[CopayAmountSubmitted]) AS CopayAmountSubmitted
	, CONVERT(MONEY, s.[IngredientCostSubmitted]) AS IngredientCostSubmitted
	, CONVERT(MONEY, s.[DispensingFeeSubmitted]) AS DispensingFeeSubmitted
	, CONVERT(MONEY, s.[IncentiveFeeSubmitted]) AS IncentiveFeeSubmitted
	, CONVERT(MONEY, s.[SalesTaxSubmitted]) AS SalesTaxSubmitted
	, CONVERT(MONEY, s.[CopayAmountPaid]) AS CopayAmountPaid
	, CONVERT(MONEY, s.[IngredientCostPaid]) AS IngredientCostPaid
	, CONVERT(MONEY, s.[DispensingFeePaid]) AS DispensingFeePaid 
	, CONVERT(MONEY, s.[SalesTaxPaid]) AS SalesTaxPaid 
	, CONVERT(MONEY, s.[IncentiveFeePaid]) AS IncentiveFeePaid 
	, CONVERT(MONEY, s.[ClaimAmountPaid]) AS ClaimAmountPaid 
	, CONVERT(VARCHAR(5), CASE
							WHEN s.[BasisOfCostCode] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE s.[BasisOfCostCode]
							END) AS BasisCostCode
	--, CONVERT(VARCHAR(255), b.Description) AS BasisCostCodeDescription
	, CONVERT(DECIMAL(10,3), s.QuantityDispensed) AS QuantityDispensed 
	, CONVERT(INT, s.DaysSupply) AS DaysSupply
	, CONVERT(VARCHAR(25), CASE
							WHEN s.[PharmacistInitials] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE s.PharmacistInitials
							END) AS PharmacistInitials
	, CONVERT(INT, s.RejectMessageCount) AS RejectMessageCount
	, CONVERT(VARCHAR(1000), CASE
							WHEN s.[RejectMessages] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE s.RejectMessages
							 END) AS RejectMessages
	, CONVERT(VARCHAR(100), CASE
							WHEN s.[AuthorizationNumber] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE s.[AuthorizationNumber]
							 END) AS AuthNumber
	, CONVERT(VARCHAR(10), CASE
							WHEN s.[BasisOfReimbursementDetermination] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE s.BasisOfReimbursementDetermination
							 END) AS BasisOfReimbursementDetermination
	--, CONVERT(VARCHAR(255), br.Description) AS BasisOfReimbursementDeterminationDescription
	, CONVERT(VARCHAR(10), CASE
							WHEN s.PlaceOfService NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE s.PlaceOfService
							 END) AS PlaceOfService
	--, CONVERT(VARCHAR(255), ps.Description) AS PlaceOfServiceDescription
	, CONVERT(VARCHAR(10), CASE
							WHEN s.ProviderIDQualifier NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE s.ProviderIDQualifier
							 END) AS ProviderIDQualifier
	, CONVERT(VARCHAR(255), CASE
							WHEN s.ProviderIDQualifier = '01' THEN 'DEA'
							WHEN s.ProviderIDQualifier = '02' THEN 'State License'
							WHEN s.ProviderIDQualifier = '03' THEN 'SSN'
							WHEN s.ProviderIDQualifier = '04' THEN 'Name'
							WHEN s.ProviderIDQualifier = '05' THEN 'NPI'
							WHEN s.ProviderIDQualifier = '06' THEN 'HIN'
							WHEN s.ProviderIDQualifier = '07' THEN 'State Issued'
							WHEN s.ProviderIDQualifier = '99' THEN 'Other'
							ELSE NULL
							END
							) AS ProviderIDQualifierDescription
	, CONVERT(VARCHAR(100), CASE
							WHEN s.ProviderID NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE s.ProviderID
							 END) AS ProviderID
	, CONVERT(MONEY, s.AdjustedContractCost) AS AdjustedContractCost
	, CONVERT(BIT, CASE	
						WHEN s.[P340BCode] = '0' THEN 0
						WHEN s.[P340BCode] = '1' THEN 1
						WHEN s.[P340BCode] = 'False' THEN 0
						WHEN s.[P340BCode] = 'true' THEN 1
						ELSE NULL
						END) AS Is340BClaim
	, CONVERT(VARCHAR(10), CASE
							WHEN s.PrescriptionStatus NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE s.PrescriptionStatus
							 END) AS PrescriptionStatus
	, CONVERT(VARCHAR(255), CASE
							WHEN s.PrescriptionStatus = 'A' THEN 'Active'
							WHEN s.PrescriptionStatus = 'C' THEN 'Cancelled'
							WHEN s.PrescriptionStatus = 'O' THEN 'On Hold'
							WHEN s.PrescriptionStatus = 'P' THEN 'Profile'
							WHEN s.PrescriptionStatus = 'S' THEN 'Suspended'
							WHEN s.PrescriptionStatus = 'T' THEN 'Transferred'
							WHEN s.PrescriptionStatus = 'V' THEN 'Void'
							WHEN s.PrescriptionStatus = 'X' THEN 'Expired'
							ELSE NULL
							END
							) AS PrescriptionStatusDescription
	, CONVERT(VARCHAR(10), CASE
							WHEN s.ProductSource NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE s.ProductSource
							 END) AS ProductSource
	, s.FileSource AS FileProcessed
	, CONVERT(VARBINARY(8), s.RowversionID) AS RowversionID
	, CONVERT(INT, s.PMID) AS PMID
	, s.BasisOfCostCode
	FROM [Archive].[FDS] AS s
	) AS s
LEFT OUTER JOIN dbo.FDS_DAWDescription AS f ON s.DAW = f.Code
LEFT OUTER JOIN dbo.FDS_BasisCostCodeDescription AS b ON b.Code = s.BasisOfCostCode
LEFT OUTER JOIN dbo.FDS_BasisOfReimbursementDetermination AS br ON br.Code = s.BasisOfReimbursementDetermination
LEFT OUTER JOIN dbo.FDS_PlaceOfService AS ps ON s.PlaceOfService = ps.Code
LEFT OUTER JOIN(SELECT DISTINCT PharmacyKey, PMID, StartDateKey, EndDateKey
				FROM RXMaster.dbo.PharmacyDim
				WHERE PMID IS NOT NULL
				)  AS lj ON s.PMID = lj.PMID
							AND lj.EndDateKey >= cast(CONVERT(varchar(20),CONVERT(DATETIME, s.FillDate),112) as INT)
							AND lj.StartDateKey <= cast(CONVERT(varchar(20),CONVERT(DATETIME, s.FillDate),112) as INT)
							
LEFT OUTER JOIN(SELECT DISTINCT PharmacyKey, NPI, StartDateKey, EndDateKey
				FROM RXMaster.dbo.PharmacyDim
				WHERE NPI IS NOT NULL
					) AS lj1 ON s.ServiceProviderID = lj1.NPI
							AND lj1.EndDateKey >= cast(CONVERT(varchar(20),CONVERT(DATETIME, s.FillDate),112) as INT)
							AND lj1.StartDateKey <= cast(CONVERT(varchar(20),CONVERT(DATETIME, s.FillDate),112) as INT)
							
LEFT OUTER JOIN(SELECT DISTINCT PharmacyKey, NCPDP, StartDateKey, EndDateKey
				FROM RXMaster.dbo.PharmacyDim
				WHERE NCPDP IS NOT NULL
					) AS lj2 ON s.ServiceProviderID = lj2.NCPDP
							AND lj2.StartDateKey <= cast(CONVERT(varchar(20),CONVERT(DATETIME, s.FillDate),112) as INT)
							AND lj2.EndDateKey >= cast(CONVERT(varchar(20),CONVERT(DATETIME, s.FillDate),112) as INT)
WHERE  NOT EXISTS(SELECT 1
					FROM dbo.EventDimFDS AS f
					WHERE s.RowversionID = f.RowversionID
						)
--AND (lj.PharmacyKey IS NOT NULL
--		OR lj1.PharmacyKey IS NOT NULL
--		OR lj2.PharmacyKey IS NOT NULL
--		)
		









GO
