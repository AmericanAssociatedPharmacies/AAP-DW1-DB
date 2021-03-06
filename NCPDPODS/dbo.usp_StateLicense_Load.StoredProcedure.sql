USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_StateLicense_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_StateLicense_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[StateLicense] AS T
	USING (SELECT [NCPDpProviderID], [LicenseStateCode], [StateLicesnseNumber], [StateLicenseExpirationDate], [DeleteDate]
		   FROM [Staging].[vw_NCPDP_StateLicense]) AS S
				([NCPDPProviderID], [LicenseStateCode], [StateLicesnseNumber], [StateLicenseExpirationDate], [DeleteDate])
		  ON T.[NCPDPProviderID] = S.[NCPDPProviderID]
		  AND T.[LicenseStateCode] = S.[LicenseStateCode]
		  AND T.[StateLicesnseNumber] = S.[StateLicesnseNumber]
WHEN MATCHED THEN

UPDATE SET 
--[NCPDpProviderID] = S.[NCPDpProviderID]
--		 , [LicenseStateCode] = S.[LicenseStateCode]
--		 , [StateLicesnseNumber] = S.[StateLicesnseNumber]
--		 , [StateLicenseExpirationDate] = S.[StateLicenseExpirationDate]
		  [DeleteDate] = S.[DeleteDate]

WHEN NOT MATCHED THEN
		INSERT ([NCPDpProviderID], [LicenseStateCode], [StateLicesnseNumber], [StateLicenseExpirationDate], [DeleteDate])
		VALUES (S.[NCPDpProviderID], S.[LicenseStateCode], S.[StateLicesnseNumber], S.[StateLicenseExpirationDate], S.[DeleteDate]);
END


GO
