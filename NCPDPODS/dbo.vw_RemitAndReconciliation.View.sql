USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_RemitAndReconciliation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_RemitAndReconciliation]

AS


SELECT RemitKey, RemitAndReconciliationID, RemitAndReconciliationName, RemitAndReconciliationAddress1, RemitAndReconciliationAddress2, RemitAndReconciliationCity
, RemitAndReconciliationStateCode, RemitAndReconciliationZipCode, RemitAndReconciliationPhoneNumber, RemitAndReconciliationExtension, RemitAndReconciliationFAXNumber
, RemitAndReconciliationNPI, RemitAndReconciliationFederalTaxID, RemitAndReconciliationContactName, RemitAndReconciliationContactTitle, RemitAndReconciliationEmailAddress
, CONVERT(DATE, CASE	
				WHEN RemitAndReconciliationDeleteDate = '00000000' THEN '29991231'
				ELSE RIGHT(RemitAndReconciliationDeleteDate, 4) + LEFT(RemitAndReconciliationDeleteDate, 2) +  SUBSTRING(RemitAndReconciliationDeleteDate,3,2)
				END
				) AS RemitAndReconciliationDeleteDate
, RowCreatedDate
FROM [dbo].[RemitAndReconciliation]
GO
