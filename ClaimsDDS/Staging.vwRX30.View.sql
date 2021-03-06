USE [ClaimsDDS]
GO
/****** Object:  View [Staging].[vwRX30]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [Staging].[vwRX30]

AS

SELECT CAST(CONVERT(varchar(20),RxDate,112) as INT) AS DateKey
, CONVERT(VARCHAR(25),  CASE 
						WHEN PharmID NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(PharmID))
						END
		 ) AS ServiceProviderID
, CONVERT(VARCHAR(25),  CASE 
						WHEN BINNbr NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(BINNbr))
						END
		 ) AS BINNumber
, CONVERT(VARCHAR(25),  CASE 
						WHEN PCN NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(PCN))
						END
		 ) AS ProcessorControlNumber
, CONVERT(VARCHAR(25),  CASE 
						WHEN GroupNbr NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(GroupNbr))
						END
		 ) AS GroupID
, CONVERT(DATE, CASE	
	WHEN ISDATE(Submitted) = 1 THEN Submitted
	ELSE '19000101'
	END
	) AS ClaimSubmittedDate
, CONVERT(DATE, CASE	
				WHEN ISDATE(RxDate) = 1 THEN RxDate
				ELSE '19000101'
				END 
				) AS DateOfService
, CASE 
	WHEN ISNUMERIC(QtyDispensed) = 1
	THEN CONVERT(DECIMAL(15,3), QtyDispensed)
	ELSE NULL	
	END AS QuantityDispensed
, CASE 
	WHEN ISNUMERIC(DaySupply) = 1
	THEN CONVERT(INT, DaySupply)
	ELSE NULL	
	END AS DaysSupply
, CONVERT(VARCHAR(25),  CASE 
						WHEN NDCDispensed NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(NDCDispensed))
						END
		 ) AS NDC
, CONVERT(VARCHAR(25),  CASE 
						WHEN BS NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(BS))
						END
		 ) AS [BasisOfSubmission]
, CONVERT(MONEY,  CASE 
						WHEN FeeSubmitted NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(FeeSubmitted))
						END
		 ) AS DispensingFeeSubmitted
, CONVERT(MONEY,  CASE 
						WHEN CostSubmitted NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(CostSubmitted))
						END
		 ) AS IngredientCostSubmitted 
, CONVERT(MONEY,  CASE 
						WHEN FeePaid NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(FeePaid))
						END
		 ) AS DispensingFeePaid
, CONVERT(MONEY,  CASE 
						WHEN CostPaid NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(CostPaid))
						END
		 ) AS IngredientCostPaid
, CONVERT(MONEY,  CASE 
						WHEN PlanAmount NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(PlanAmount))
						END
		 ) AS TotalAmountPaid
, CONVERT(MONEY,  CASE 
						WHEN CoPayAmount NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(CoPayAmount))
						END
		 ) AS AmountOfCopay
, CONVERT(MONEY,  CASE 
						WHEN  UandC NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM( UandC))
						END
		 ) AS UsualandCustomaryCharge
, CONVERT(MONEY, TotalPrice) AS TotalPrice
, CONVERT(VARCHAR(25),  CASE 
						WHEN BR NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(BR))
						END
		 ) AS BasisofReimbursementDetermination
, CONVERT(VARCHAR(25),  CASE 
						WHEN OI NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(OI))
						END
		 ) AS OtherCoverageCode
, CONVERT(VARCHAR(25),  CASE 
						WHEN DAW NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(DAW))
						END
		 ) AS DAW
, CONVERT(VARCHAR(25),  CASE 
						WHEN DAWDesc NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(DAWDesc))
						END
		 ) AS DAWDescription
, CONVERT(MONEY, PatientPaid) AS PatientPayAmount
, CONVERT(MONEY, GrossAmtDue) AS GrossAmountDue
, CONVERT(VARCHAR(25),  CASE 
						WHEN PlanID NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(PlanID))
						END
		 ) AS PlanID
, CONVERT(VARCHAR(25),  CASE 
						WHEN RejCode NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(RejCode))
						END
		 ) AS RejectCode
, CONVERT(VARCHAR(8000),  CASE 
						WHEN MessageResponse NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(MessageResponse))
						END
		 ) AS MessageResponse
, CONVERT(VARCHAR(25),  CASE 
						WHEN TxResponse NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(TxResponse))
						END
		 ) AS TransactionResponseStatus
, CONVERT(VARCHAR(25),  CASE 
						WHEN RxNbr NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(RxNbr))
						END
		 ) AS PrescriptionNumber
, CONVERT(INT,  CASE 
						WHEN  RfNbr NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM( RfNbr))
						END
		 ) AS RefillNumberCode
, CONVERT(INT,  CASE 
						WHEN PID_Q NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(PID_Q))
						END
		 ) AS ProviderIDQualifier
, CONVERT(VARCHAR(25),  CASE 
						WHEN PID NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(PID))
						END
		 ) AS ProviderID
, CONVERT(VARCHAR(500),  CASE 
						WHEN DoctorName NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(DoctorName))
						END
		 ) AS DoctorName
, CONVERT(INT,  CASE 
						WHEN RA NOT LIKE '%[0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(RA))
						END
		 ) AS NumberofRefillsAuthorized
, CONVERT(VARCHAR(25),  CASE 
						WHEN NDCWritten NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(NDCWritten))
						END
		 ) AS NDCWritten
, CONVERT(MONEY, OtherAmount) AS OtherAmount
, CONVERT(VARCHAR(25),  CASE 
						WHEN TYPE NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(TYPE))
						END
		 ) AS PayerType
, CONVERT(VARCHAR(25),  CASE 
						WHEN Rx30Lic NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(Rx30Lic))
						END
		 ) AS PharmacySystemLicenseNumber
, CONVERT(INT,  CASE 
						WHEN Compound NOT LIKE '%[Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(Compound))
						END
		 ) AS CompoundCode
, CONVERT(VARCHAR(25),  CASE 
						WHEN NetworkReimbID NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(NetworkReimbID))
						END
		 ) AS NetworkReimbursementID
, CONVERT(VARCHAR(25), LTRIM(RTRIM(PrescriberPhone))) AS PrescriberPhoneNumber
, CONVERT(VARCHAR(25),  CASE 
						WHEN RxSource NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(RxSource))
						END
		 ) AS PrescriptionOriginCode
, CONVERT(VARCHAR(25),  CASE 
						WHEN DRDEA NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(DRDEA))
						END
		 ) AS PhysicianDEA
, CONVERT(MONEY, UnitAWP) AS UnitAWP
, CONVERT(MONEY, FlatTaxPaid) AS FlatSalesTaxAmountPaid
, CONVERT(MONEY, PCTTaxPaid) AS PercentageSalesTaxAmountPaid
, CONVERT(MONEY, PCTTaxRate) AS PercentageSalesTaxRate
, CONVERT(MONEY, PCTTaxBasis) AS PercentageSalesTaxBasisPaid
, CONVERT(MONEY, IncentiveFeePaid) AS IncentiveAmountPaid
, CONVERT(MONEY, ProfFeePaid) AS ProfessionalFeePaid
, CONVERT(VARCHAR(25),  CASE 
						WHEN PrescriberNPI NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(PrescriberNPI))
						END
		 ) AS PrescriberNPI
, CONVERT(MONEY, RxDiscount) AS RXDiscount
, CONVERT(VARCHAR(25),  CASE 
						WHEN ClaimAuthNumber NOT LIKE '%[a-zA-Z0-9]%' 
						THEN NULL	
						ELSE LTRIM(RTRIM(ClaimAuthNumber))
						END
		 ) AS AuthorizationNumber
, FileProcessed
, CONVERT(DATE, CASE	
	WHEN ISDATE(DateSold) = 1 THEN DateSold
	ELSE '19000101'
	END
	) AS DateSold
, RowversionID
, CONVERT(INT, CASE	
				WHEN ISDATE(RxDate) = 1 THEN CONVERT(INT, CONVERT(VARCHAR(20), DATEADD(DAY, 1, CONVERT(datetime, convert(varchar(10), RxDate))),112))
				ELSE 19000101
				END 
				) AS EndDateKey
FROM ODSIntake.[Staging].[Rx30]


GO
