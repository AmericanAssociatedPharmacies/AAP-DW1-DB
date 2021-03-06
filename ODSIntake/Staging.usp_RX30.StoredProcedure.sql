USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Staging].[usp_RX30]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_RX30]

AS

SET NOCOUNT ON;

BEGIN


SELECT RowID, FileRowID, PharmID, BINNbr, PCN, GroupNbr, Submitted, RxDate, QtyDispensed, DaySupply, NDCDispensed, FeeSubmitted, CostSubmitted, FeePaid, CostPaid, PlanAmount, CoPayAmount
, UandC, TotalPrice, BS, BR, OI, DAW, DAWDesc, PatientPaid, GrossAmtDue, PlanID, RejCode, MessageResponse, TxResponse, RxNbr, RfNbr, PID_Q, PID, DoctorName, RA, NDCWritten
, OtherAmount, TYPE, Rx30Lic, Compound, NetworkReimbID, PrescriberPhone, RxSource, DRDEA, UnitAWP, FlatTaxPaid, PCTTaxPaid, PCTTaxRate, PCTTaxBasis, IncentiveFeePaid, ProfFeePaid
, PrescriberNPI, RxDiscount, ClaimAuthNumber, FileProcessed, RowCreatedDate
, CONVERT(DATE, CASE	
	WHEN ISDATE(DateSold) = 1 THEN DateSold
	ELSE '19000101'
	END
	) AS DateSold
, RowversionID
FROM [Staging].[Rx30]

END

GO
