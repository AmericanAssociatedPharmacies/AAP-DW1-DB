USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangeofOwnershipInformation_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ChangeofOwnershipInformation_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[ChangeofOwnershipInformation] AS T
	USING (SELECT [NCPDPProviderID], [OldNCPDPProviderID], [OldStoreCloseDate], [ChangeofOwnershipEffectiveDate]
		   FROM [Staging].[vw_NCPDP_ChangeofOwnershipInformation]) AS S
		  ([NCPDPProviderID], [OldNCPDPProviderID], [OldStoreCloseDate], [ChangeofOwnershipEffectiveDate])
		  ON T.NCPDPProviderID = S.NCPDPProviderID

WHEN MATCHED THEN

UPDATE SET [OldNCPDPProviderID] = S.[OldNCPDPProviderID]
		 , [OldStoreCloseDate] = S.[OldStoreCloseDate]
		 , [ChangeofOwnershipEffectiveDate] = S.[ChangeofOwnershipEffectiveDate]
	

WHEN NOT MATCHED THEN
		INSERT ([NCPDPProviderID], [OldNCPDPProviderID], [OldStoreCloseDate], [ChangeofOwnershipEffectiveDate])
		VALUES (S.[NCPDPProviderID], S.[OldNCPDPProviderID], S.[OldStoreCloseDate], S.[ChangeofOwnershipEffectiveDate]);
END
GO
