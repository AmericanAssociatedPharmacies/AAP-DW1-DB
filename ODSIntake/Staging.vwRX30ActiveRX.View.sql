USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwRX30ActiveRX]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [Staging].[vwRX30ActiveRX]

AS

SELECT dt.RowID
, dt.FileRowID
, dt.PharmID
, dt.BINNbr
, dt.PCN
, dt.GroupNbr
, dt.Submitted
, dt.RxDate
, dt.QtyDispensed
, dt.DaySupply
, dt.NDCDispensed
, dt.FeeSubmitted
, dt.CostSubmitted
, dt.FeePaid
, dt.CostPaid
, dt.PlanAmount
, dt.CoPayAmount
, dt.UandC
, dt.TotalPrice
, dt.BS
, dt.BR
, dt.OI
, dt.DAW
, dt.DAWDesc
, dt.PatientPaid
, dt.GrossAmtDue
, dt.PlanID
, dt.RejCode
, dt.MessageResponse
, dt.TxResponse
, dt.RxNbr
, dt.RfNbr
, dt.PIDQ
, dt.PID
, dt.DoctorName
, dt.RA
, dt.NDCWritten
, dt.OtherAmount
, dt.TYPE
, dt.Rx30Lic
, dt.Compound
, dt.NetworkReimbID
, dt.PrescriberPhone
, dt.RxSource
, dt.DRDEA
, dt.UnitAWP
, dt.FlatTaxPaid
, dt.PCTTaxPaid
, dt.PCTTaxRate
, dt.PCTTaxBasis
, dt.IncentiveFeePaid
, dt.ProfFeePaid
, dt.PrescriberNPI
, dt.RxDiscount
, dt.ClaimAuthNumber
, dt.DateSold
, dt.FileProcessed
, dt.RowCreatedDate
FROM(SELECT ROW_NUMBER() OVER(PARTITION BY PharmID, BINNbr, PCN, GroupNbr, Submitted
								, RxDate, QtyDispensed, DaySupply, NDCDispensed, FeeSubmitted, CostSubmitted
								, FeePaid, CostPaid, PlanAmount, CoPayAmount, UandC, TotalPrice, BS, BR, OI
								, DAW, DAWDesc, PatientPaid, GrossAmtDue, PlanID, RejCode, MessageResponse
								, TxResponse, RxNbr, RfNbr, PID_Q, PID, DoctorName, RA, NDCWritten, OtherAmount
								, [TYPE], Rx30Lic, Compound, NetworkReimbID, PrescriberPhone, RxSource, DRDEA, UnitAWP
								, FlatTaxPaid, PCTTaxPaid, PCTTaxRate, PCTTaxBasis, IncentiveFeePaid, ProfFeePaid
								, PrescriberNPI, RxDiscount, ClaimAuthNumber, DateSold ORDER BY (SELECT NULL)
	) AS RN
	, RowID, FileRowID, ISNULL(n1.NCPDP, n2.NPI) AS PharmID, BINNbr, PCN, GroupNbr, Submitted
	, RxDate, QtyDispensed, DaySupply, NDCDispensed, FeeSubmitted, CostSubmitted
	, FeePaid, CostPaid, PlanAmount, CoPayAmount, UandC, TotalPrice, BS, BR, OI
	, DAW, DAWDesc, PatientPaid, GrossAmtDue, PlanID, RejCode, MessageResponse
	, TxResponse, RxNbr, RfNbr, PID_Q AS PIDQ, PID, DoctorName, RA, NDCWritten, OtherAmount
	, [TYPE], Rx30Lic, Compound, NetworkReimbID, PrescriberPhone, RxSource, DRDEA, UnitAWP
	, FlatTaxPaid, PCTTaxPaid
	, PCTTaxRate, PCTTaxBasis, IncentiveFeePaid, ProfFeePaid, PrescriberNPI, RxDiscount
	, ClaimAuthNumber, CONVERT(DATE, DateSold) AS DateSold
	, FileProcessed, RowCreatedDate
	FROM [Staging].[Rx30Claims] AS A
	LEFT OUTER JOIN(SELECT DISTINCT NCPDP 
						FROM PharmacyMaster.dbo.PM_Pharmacy
					   WHERE AAPQuitDate IS NULL
					   AND AAPAccountNo IS NOT NULL
					   AND NCPDP IS NOT NULL
 
					UNION ALL
 
				    SELECT NCPDP
				    FROM PharmacyMaster.dbo.PM_Pharmacy
				   WHERE APIStatus = 'Active'
				   AND NCPDP IS NOT NULL
				) AS n1 ON A.PharmID = n1.NCPDP
	LEFT OUTER JOIN(SELECT DISTINCT NPI
				    FROM PharmacyMaster.dbo.PM_Pharmacy
				   WHERE AAPQuitDate IS NULL
				   AND AAPAccountNo IS NOT NULL
				   AND NPI IS NOT NULL
 
					UNION ALL
 
				     SELECT NPI
					FROM PharmacyMaster.dbo.PM_Pharmacy
					WHERE APIStatus = 'Active'
					AND NPI IS NOT NULL
				) AS n2 ON A.PharmID = n2.NPI
	WHERE (n1.NCPDP IS NOT NULL
			OR
			n2.NPI IS NOT NULL
			)
	) AS dt
WHERE dt.RN = 1


--Older version. Newer version eliminates any dups since RX30 could send either NCPDP or NPI.
--SELECT dt.RowID
--, dt.FileRowID
--, dt.PharmID
--, dt.BINNbr
--, dt.PCN
--, dt.GroupNbr
--, dt.Submitted
--, dt.RxDate
--, dt.QtyDispensed
--, dt.DaySupply
--, dt.NDCDispensed
--, dt.FeeSubmitted
--, dt.CostSubmitted
--, dt.FeePaid
--, dt.CostPaid
--, dt.PlanAmount
--, dt.CoPayAmount
--, dt.UandC
--, dt.TotalPrice
--, dt.BS
--, dt.BR
--, dt.OI
--, dt.DAW
--, dt.DAWDesc
--, dt.PatientPaid
--, dt.GrossAmtDue
--, dt.PlanID
--, dt.RejCode
--, dt.MessageResponse
--, dt.TxResponse
--, dt.RxNbr
--, dt.RfNbr
--, dt.PIDQ
--, dt.PID
--, dt.DoctorName
--, dt.RA
--, dt.NDCWritten
--, dt.OtherAmount
--, dt.TYPE
--, dt.Rx30Lic
--, dt.Compound
--, dt.NetworkReimbID
--, dt.PrescriberPhone
--, dt.RxSource
--, dt.DRDEA
--, dt.UnitAWP
--, dt.FlatTaxPaid
--, dt.PCTTaxPaid
--, dt.PCTTaxRate
--, dt.PCTTaxBasis
--, dt.IncentiveFeePaid
--, dt.ProfFeePaid
--, dt.PrescriberNPI
--, dt.RxDiscount
--, dt.ClaimAuthNumber
--, dt.DateSold
--, dt.FileProcessed
--, dt.RowCreatedDate
--FROM(SELECT ROW_NUMBER() OVER(PARTITION BY PharmID, BINNbr, PCN, GroupNbr, Submitted
--								, RxDate, QtyDispensed, DaySupply, NDCDispensed, FeeSubmitted, CostSubmitted
--								, FeePaid, CostPaid, PlanAmount, CoPayAmount, UandC, TotalPrice, BS, BR, OI
--								, DAW, DAWDesc, PatientPaid, GrossAmtDue, PlanID, RejCode, MessageResponse
--								, TxResponse, RxNbr, RfNbr, PID_Q, PID, DoctorName, RA, NDCWritten, OtherAmount
--								, [TYPE], Rx30Lic, Compound, NetworkReimbID, PrescriberPhone, RxSource, DRDEA, UnitAWP
--								, FlatTaxPaid, PCTTaxPaid, PCTTaxRate, PCTTaxBasis, IncentiveFeePaid, ProfFeePaid
--								, PrescriberNPI, RxDiscount, ClaimAuthNumber, DateSold ORDER BY (SELECT NULL)
--	) AS RN
--	, RowID, FileRowID, PharmID, BINNbr, PCN, GroupNbr, Submitted
--	, RxDate, QtyDispensed, DaySupply, NDCDispensed, FeeSubmitted, CostSubmitted
--	, FeePaid, CostPaid, PlanAmount, CoPayAmount, UandC, TotalPrice, BS, BR, OI
--	, DAW, DAWDesc, PatientPaid, GrossAmtDue, PlanID, RejCode, MessageResponse
--	, TxResponse, RxNbr, RfNbr, PID_Q AS PIDQ, PID, DoctorName, RA, NDCWritten, OtherAmount
--	, [TYPE], Rx30Lic, Compound, NetworkReimbID, PrescriberPhone, RxSource, DRDEA, UnitAWP
--	, FlatTaxPaid, PCTTaxPaid
--	, PCTTaxRate, PCTTaxBasis, IncentiveFeePaid, ProfFeePaid, PrescriberNPI, RxDiscount
--	, ClaimAuthNumber, CONVERT(DATE, DateSold) AS DateSold
--	, FileProcessed, RowCreatedDate
--	FROM [Staging].[Rx30Claims] AS A
--	WHERE EXISTS(SELECT 1
--					FROM [dbo].[vwActivePharmacies] AS B
--					WHERE A.PharmID = B.ServiceProviderID
--					)
--	) AS dt
--WHERE dt.RN = 1





GO
