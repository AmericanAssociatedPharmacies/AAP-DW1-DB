USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_RemitAndReconciliation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vw_NCPDP_RemitAndReconciliation]

AS


SELECT NULLIF(SUBSTRING(C1,1,6), '') AS RemitANdReconciliationID 
, NULLIF(SUBSTRING(C1,7,35), '') AS RemitAndReconciliationName  
, NULLIF(SUBSTRING(C1,42,55), '') AS RemitAndReconciliationAddress1  
, NULLIF(SUBSTRING(C1,97,55), '') AS RemitAndReconciliationAddress2
, NULLIF(SUBSTRING(C1,152,30), '') AS RemitAndReconciliationCity
, NULLIF(SUBSTRING(C1,182,2), '') AS RemitAndReconciliationStateCode
, NULLIF(SUBSTRING(C1,184,9), '') AS RemitAndReconciliationZipCode
, NULLIF(SUBSTRING(C1,193,10), '') AS RemitAndReconciliationPhoneNumber
, NULLIF(SUBSTRING(C1,203,5), '') AS RemitAndReconciliationExtension
, NULLIF(SUBSTRING(C1,208,10), '') AS RemitAndReconciliationFAXNumber
, NULLIF(SUBSTRING(C1,218,10), '') AS RemitAndReconciliationNPI
, NULLIF(SUBSTRING(C1,228,15), '') AS RemitAndReconciliationFederalTaxID 
, NULLIF(SUBSTRING(C1,243,30), '') AS RemitAndReconciliationContactName
, NULLIF(SUBSTRING(C1,273,30), '') AS RemitAndReconciliationContactTitle
, NULLIF(SUBSTRING(C1,303,50), '') AS RemitAndReconciliationEmailAddress
, NULLIF(SUBSTRING(C1,353,8), '') AS RemitAndReconciliationDeleteDate
FROM(SELECT MIN(RowID) AS MinRowID
	, MAX(RowID) AS MaxRowID
	FROM ODSIntake.[Staging].[NCPDP_RemitAndReconciliation]
	) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_RemitAndReconciliation] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID
GO
