USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_SelectRecord]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_SelectRecord] 

@FileProcessed VARCHAR(1000)

AS

SET NOCOUNT ON

SELECT [RowID], [FileRowID], [PharmID], [BINNbr], [PCN], [GroupNbr], [Submitted], [RxDate], [QtyDispensed]
	, [DaySupply], [NDCDispensed], [FeeSubmitted], [CostSubmitted], [FeePaid], [CostPaid], [PlanAmount]
	, [CoPayAmount], [UandC], [TotalPrice], [BS], [BR], [OI], [DAW], [DAWDesc], [PatientPaid], [GrossAmtDue]
	, [PlanID], [RejCode], [MessageResponse], [TxResponse], [RxNbr], [RfNbr], [PID_Q], [PID], [DoctorName]
	, [RA], [NDCWritten], [OtherAmount], [TYPE], [Rx30Lic], [Compound], [NetworkReimbID], [PrescriberPhone]
	, [RxSource], [DRDEA], [UnitAWP], [FlatTaxPaid], [PCTTaxPaid], [PCTTaxRate], [PCTTaxBasis], [IncentiveFeePaid]
	, [ProfFeePaid], [PrescriberNPI], [RxDiscount], [ClaimAuthNumber], [RowCreatedDate]
  -- CASE WHEN Fileprocessed like '%2017%' and RowCreatedDate <'2018' 
		--	 THEN Substring(FileProcessed, 1,CHARINDEX('Staging\',FileProcessed)-1) 
		--		  + 'Archive\Rx30AAPClaimsLoad2017'   
		--	      + Substring(FileProcessed,CHARINDEX('2017',FileProcessed)+4,4)
		--		  +'_PostODSIntakeLoad.txt'
		--WHEN FileProcessed like '%[a-z][0-9][0-9][0-9][0-9]17.csv' and RowCreatedDate < '2018' 
		--	 then Substring(FileProcessed, 1,CHARINDEX('Staging\',FileProcessed)-1) 
		--		  + 'Archive\Rx30AAPClaimsLoad2017'
		--		  + Substring(FileProcessed,CHARINDEX('.csv',FileProcessed)-6,4) 
		--		  + '_PostODSIntakeLoad.txt' 
  --      END AS NewFileProcessed
FROM Archive.Rx30Claims
WHERE FileProcessed = @FileProcessed
GO
