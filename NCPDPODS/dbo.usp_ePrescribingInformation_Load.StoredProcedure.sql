USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ePrescribingInformation_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_ePrescribingInformation_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[ePrescribingInformation] AS T
	USING (SELECT [NCPDPProviderID], [ePrescribingNetworkIdentifier], [ePrescribingServiceLevelCodes], [EffectiveFromDate], [EffectiveThroughDate]
		   FROM [Staging].[vw_NCPDP_ePrescribingInformation]) AS S
		  ([NCPDPProviderID], [ePrescribingNetworkIdentifier], [ePrescribingServiceLevelCodes], [EffectiveFromDate], [EffectiveThroughDate])
		  ON T.NCPDPProviderID = S.NCPDPProviderID

WHEN MATCHED THEN

UPDATE SET [ePrescribingNetworkIdentifier] = S.[ePrescribingNetworkIdentifier]
		 , [ePrescribingServiceLevelCodes] = S.[ePrescribingServiceLevelCodes]
		 , [EffectiveFromDate] = S.[EffectiveFromDate]
		 , [EffectiveThroughDate] = S.[EffectiveThroughDate]
	

WHEN NOT MATCHED THEN
		INSERT ([NCPDPProviderID], [ePrescribingNetworkIdentifier], [ePrescribingServiceLevelCodes], [EffectiveFromDate], [EffectiveThroughDate])
		VALUES (S.[NCPDPProviderID], S.[ePrescribingNetworkIdentifier], S.[ePrescribingServiceLevelCodes], S.[EffectiveFromDate], S.[EffectiveThroughDate]);
END
GO
