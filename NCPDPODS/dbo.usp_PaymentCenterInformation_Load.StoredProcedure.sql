USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_PaymentCenterInformation_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_PaymentCenterInformation_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[PaymentCenterInformation] AS T
	USING (SELECT [PaymentCenterID], [PaymentCenterName], [PaymentCenterAddress1], [PaymentCenterAddress2], [PaymentCenterCity], [PaymentCenterStateCode], [PaymentCenterZipCode], [PaymentCenterPhoneNumber]
	, [PaymentCenterExtension], [PaymentCenterFaxNumber], [PaymentCenterNPI], [PaymentCenterFedralTaxID], [PaymentCenterContactName], [PaymentCenterContactTitle], [PaymentCenterEmailAddress], [DeleteDate]
		   FROM [Staging].[vw_NCPDP_PaymentCenterInformation]) AS S
				([PaymentCenterID], [PaymentCenterName], [PaymentCenterAddress1], [PaymentCenterAddress2], [PaymentCenterCity], [PaymentCenterStateCode], [PaymentCenterZipCode], [PaymentCenterPhoneNumber]
				, [PaymentCenterExtension], [PaymentCenterFaxNumber], [PaymentCenterNPI], [PaymentCenterFedralTaxID], [PaymentCenterContactName], [PaymentCenterContactTitle], [PaymentCenterEmailAddress]
				, [DeleteDate])
		  ON T.[PaymentCenterID] = S.[PaymentCenterID]

WHEN MATCHED THEN

UPDATE SET [PaymentCenterName] = S.[PaymentCenterName]
		 , [PaymentCenterAddress1] = S.[PaymentCenterAddress1]
		 , [PaymentCenterAddress2] = S.[PaymentCenterAddress2]
		 , [PaymentCenterCity] = S.[PaymentCenterCity]
		 , [PaymentCenterStateCode] = S.[PaymentCenterStateCode]
		 , [PaymentCenterZipCode] = S.[PaymentCenterZipCode]
		 , [PaymentCenterPhoneNumber] = S.[PaymentCenterPhoneNumber]
		 , [PaymentCenterExtension] = S.[PaymentCenterExtension]
		 , [PaymentCenterFaxNumber] = S.[PaymentCenterFaxNumber]
		 , [PaymentCenterNPI] = S.[PaymentCenterNPI]
		 , [PaymentCenterFedralTaxID] = S.[PaymentCenterFedralTaxID]
		 , [PaymentCenterContactName] = S.[PaymentCenterContactName]
		 , [PaymentCenterContactTitle] = S.[PaymentCenterContactTitle]
		 , [PaymentCenterEmailAddress] = S.[PaymentCenterEmailAddress]
		 , [DeleteDate] = S.[DeleteDate] 
	
		 

WHEN NOT MATCHED THEN
		INSERT ([PaymentCenterID], [PaymentCenterName], [PaymentCenterAddress1], [PaymentCenterAddress2], [PaymentCenterCity], [PaymentCenterStateCode], [PaymentCenterZipCode], [PaymentCenterPhoneNumber]
				, [PaymentCenterExtension], [PaymentCenterFaxNumber], [PaymentCenterNPI], [PaymentCenterFedralTaxID], [PaymentCenterContactName], [PaymentCenterContactTitle], [PaymentCenterEmailAddress]
				, [DeleteDate])
		VALUES (S.[PaymentCenterID], S.[PaymentCenterName], S.[PaymentCenterAddress1], S.[PaymentCenterAddress2], S.[PaymentCenterCity], S.[PaymentCenterStateCode], S.[PaymentCenterZipCode], S.[PaymentCenterPhoneNumber]
				, S.[PaymentCenterExtension], S.[PaymentCenterFaxNumber], S.[PaymentCenterNPI], S.[PaymentCenterFedralTaxID], S.[PaymentCenterContactName], S.[PaymentCenterContactTitle], S.[PaymentCenterEmailAddress]
				, S.[DeleteDate]);
END


GO
