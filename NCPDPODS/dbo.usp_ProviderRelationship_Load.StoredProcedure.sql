USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ProviderRelationship_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_ProviderRelationship_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[ProviderRelationship] AS T
	USING (SELECT [NCPDPProviderID], [RelationshipID], [PaymentCenterID], [RemitandReconciliationID], [ProviderType], [IsPrimary], [EffectiveFromDate], [EffectiveThroughDate]
		   FROM [Staging].[vw_NCPDP_ProviderRelationship]) AS S
				([NCPDPProviderID], [RelationshipID], [PaymentCenterID], [RemitandReconciliationID], [ProviderType], [IsPrimary], [EffectiveFromDate], [EffectiveThroughDate])
		  ON T.[NCPDPProviderID] = S.[NCPDPProviderID]
		  AND T.[RelationshipID] = S.[RelationshipID]
		  AND T.[PaymentCenterID] = S.[PaymentCenterID]
		  AND T.[RemitandReconciliationID] = S.[RemitandReconciliationID]
		  AND T.[ProviderType] = S.[ProviderType]
		  

WHEN MATCHED THEN

UPDATE SET
-- [NCPDPProviderID] = S.[NCPDPProviderID]
--		 , [RelationshipID] = S.[RelationshipID]
--		 , [PaymentCenterID] = S.[PaymentCenterID]
--		 , [RemitandReconciliationID] = S.[RemitandReconciliationID]
		 -- [ProviderType] = S.[ProviderType]
		 [IsPrimary] = S.[IsPrimary]
		 , [EffectiveFromDate] = S.[EffectiveFromDate]
		 , [EffectiveThroughDate] = S.[EffectiveThroughDate]

WHEN NOT MATCHED THEN
		INSERT ([NCPDPProviderID], [RelationshipID], [PaymentCenterID], [RemitandReconciliationID], [ProviderType], [IsPrimary], [EffectiveFromDate], [EffectiveThroughDate])
		VALUES (S.[NCPDPProviderID], S.[RelationshipID], S.[PaymentCenterID], S.[RemitandReconciliationID], S.[ProviderType], S.[IsPrimary], S.[EffectiveFromDate], S.[EffectiveThroughDate]);
END


GO
