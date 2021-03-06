USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwCAHAccountETL]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vwCAHAccountETL]

AS

	SELECT PMID 
	, Status 
	, DEA# 
	, CustomerName 
	, AKA 
	, APIacct 
	, AAPNumber 
	, AAPParent# 
	, MCAonFile 
	, BsClass 
	, AAPAffiliate 
	, CAMasterNumber 
	, CAHMultiStoreCode 
	, CardinalDivision# 
	, CardinalDC 
	, PrimaryCAAcct# 
	, [2ndCardinalcust] 
	, [3rdCardinalcust] 
	, POSAcct 
	, [Scan-TossAcct] 
	, CSOSAcct 
	, AAPContractDate 
	, TerminationDate 
	, MultipleStore 
	, MultipleStoreCode 
	, GroupCode 
	, CurrentEstMoSales 
	, CurrentGrpTotal 
	, EstVolumeatLoad 
	, LastReviewDate 
	, CurrentAPICOG 
	, CurrentCACOG 
	, Clawbackbps 
	, Deliverybps 
	, PaymentTermsdescription 
	, PaymentTermsCode 
	, CAHtermsCodeDesc 
	, PendingChanges 
	, ChangePending 
	, NotesCOGDifferences 
	, Notes 
	, AAPRep 
	, ExcpttoMatrix 
	, ExcptCode 
	, OptionalPayTerms 
	, NotesonTerms 
	, ContractedDSO 
	, SublogicChange 
	, HighVolumeRebate 
	, EstAnnualVoloncomnown 
	, MatrixName 
	, AvgMoGenCompliance 
	, MCRMoVolumeforCOG 
	, MCRMonth 
	, MCRPercentage 
	, DateRcvdNewMC 
	, EffectiveDateNewAgmt 
	, NewAgmtType 
	, MCAMQP 
	, [MCAMGC%] 
	, MCCOG 
	, MCTerms 
	FROM [Staging].[CAHAccounts]

GO
