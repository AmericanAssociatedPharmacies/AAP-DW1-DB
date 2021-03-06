USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemitAndReconciliation_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_RemitAndReconciliation_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[RemitAndReconciliation] AS T
	USING (SELECT [RemitAndReconciliationID], [RemitAndReconciliationName], [RemitAndReconciliationAddress1], [RemitAndReconciliationAddress2], [RemitAndReconciliationCity], [RemitAndReconciliationStateCode]
	, [RemitAndReconciliationZipCode], [RemitAndReconciliationPhoneNumber], [RemitAndReconciliationExtension], [RemitAndReconciliationFAXNumber], [RemitAndReconciliationNPI], [RemitAndReconciliationFederalTaxID]
	, [RemitAndReconciliationContactName], [RemitAndReconciliationContactTitle], [RemitAndReconciliationEmailAddress], [RemitAndReconciliationDeleteDate]
		   FROM [Staging].[vw_NCPDP_RemitAndReconciliation]) AS S
				([RemitAndReconciliationID], [RemitAndReconciliationName], [RemitAndReconciliationAddress1], [RemitAndReconciliationAddress2], [RemitAndReconciliationCity]
				, [RemitAndReconciliationStateCode], [RemitAndReconciliationZipCode], [RemitAndReconciliationPhoneNumber], [RemitAndReconciliationExtension], [RemitAndReconciliationFAXNumber]
				, [RemitAndReconciliationNPI], [RemitAndReconciliationFederalTaxID], [RemitAndReconciliationContactName], [RemitAndReconciliationContactTitle], [RemitAndReconciliationEmailAddress]
				, [RemitAndReconciliationDeleteDate])
		  ON T.[RemitAndReconciliationID] = S.[RemitAndReconciliationID]

WHEN MATCHED THEN

UPDATE SET [RemitAndReconciliationName] = S.[RemitAndReconciliationName]
		 , [RemitAndReconciliationAddress1] = S.[RemitAndReconciliationAddress1]
		 , [RemitAndReconciliationAddress2] = S.[RemitAndReconciliationAddress2]
		 , [RemitAndReconciliationCity] = S.[RemitAndReconciliationCity]
		 , [RemitAndReconciliationStateCode] = S.[RemitAndReconciliationStateCode]
		 , [RemitAndReconciliationZipCode] = S.[RemitAndReconciliationZipCode]
		 , [RemitAndReconciliationPhoneNumber] = S.[RemitAndReconciliationPhoneNumber]
		 , [RemitAndReconciliationExtension] = S.[RemitAndReconciliationExtension]
		 , [RemitAndReconciliationFAXNumber] = S.[RemitAndReconciliationFAXNumber]
		 , [RemitAndReconciliationNPI] = S.[RemitAndReconciliationNPI]
		 , [RemitAndReconciliationFederalTaxID] = S.[RemitAndReconciliationFederalTaxID]
		 , [RemitAndReconciliationContactName] = S.[RemitAndReconciliationContactName]
		 , [RemitAndReconciliationContactTitle] = S.[RemitAndReconciliationContactTitle]
		 , [RemitAndReconciliationEmailAddress] = S.[RemitAndReconciliationEmailAddress]
		 , [RemitAndReconciliationDeleteDate] = S.[RemitAndReconciliationDeleteDate]

WHEN NOT MATCHED THEN
		INSERT ([RemitAndReconciliationID], [RemitAndReconciliationName], [RemitAndReconciliationAddress1], [RemitAndReconciliationAddress2], [RemitAndReconciliationCity], [RemitAndReconciliationStateCode]
			  , [RemitAndReconciliationZipCode], [RemitAndReconciliationPhoneNumber], [RemitAndReconciliationExtension], [RemitAndReconciliationFAXNumber], [RemitAndReconciliationNPI]
			  , [RemitAndReconciliationFederalTaxID], [RemitAndReconciliationContactName], [RemitAndReconciliationContactTitle], [RemitAndReconciliationEmailAddress], [RemitAndReconciliationDeleteDate])
		VALUES (S.[RemitAndReconciliationID], S.[RemitAndReconciliationName], S.[RemitAndReconciliationAddress1], S.[RemitAndReconciliationAddress2], S.[RemitAndReconciliationCity], S.[RemitAndReconciliationStateCode]
			  , S.[RemitAndReconciliationZipCode], S.[RemitAndReconciliationPhoneNumber], S.[RemitAndReconciliationExtension], S.[RemitAndReconciliationFAXNumber], S.[RemitAndReconciliationNPI]
			  , S.[RemitAndReconciliationFederalTaxID], S.[RemitAndReconciliationContactName], S.[RemitAndReconciliationContactTitle], S.[RemitAndReconciliationEmailAddress], S.[RemitAndReconciliationDeleteDate]);
END


GO
