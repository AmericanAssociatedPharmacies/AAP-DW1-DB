USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_NCPDPFact_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_NCPDPFact_Load]

AS

SET NOCOUNT ON;

	
BEGIN
BEGIN TRY

	INSERT INTO [dbo].[NCPDPFact] ([ProviderInformationKey], [ePrescribingInformationKey], [StateLicenseKey], [MedicaidKey], [TaxonomyKey], [ChangeofOwnershipKey], [ServicesOfferedKey], [FraudKey]
								 , [ProviderRelationshipKey], [RemitAndReconciliationKey], [RelationshipDemographicKey], [PaymentCenterKey], [ParentOrganizationKey])
	SELECT PRI.[ProviderInformationKey], E.[ePrescribingInformationKey], SL.[StateLicenseKey], M.[MedicaidKey], T.[TaxonomyKey], C.[ChangeofOwnershipKey], SO.[ServicesOfferedKey], F.[FraudKey]
		 , PR.[ProviderRelationshipKey], RR.[RemitAndReconciliationKey], RD.[RelationshipDemographicKey], PC.[PaymentCenterKey], PO.[ParentOrganizationKey]
	FROM [dbo].[ProviderInformation] AS PRI 
	INNER JOIN [dbo].[ePrescribingInformation] AS E ON PRI.NCPDPProviderID = E.NCPDPProviderID 
	INNER JOIN [dbo].[StateLicense] AS SL ON E.NCPDPProviderID = SL.NCPDPProviderID
	INNER JOIN [dbo].[MedicaidInformation] AS M ON SL.NCPDPProviderID = M.NCPDPProviderID
	INNER JOIN [dbo].[Taxonomy] AS T ON M.NCPDPProviderID = T.NCPDPProviderID
	INNER JOIN [dbo].[ChangeofOwnershipInformation] AS C ON T.NCPDPProviderID = C.NCPDPProviderID
	INNER JOIN [dbo].[ServicesOffered] AS SO ON C.NCPDPProviderID = SO.NCPDPProviderID
	INNER JOIN [dbo].[FraudWasteandAbuseTrainingAttestation] AS F ON SO.NCPDPProviderID = F.NCPDPProviderID
	INNER JOIN [dbo].[ProviderRelationship] AS PR ON SO.NCPDPProviderID = PR.NCPDPProviderID
	INNER JOIN [dbo].[RelationshipDemographicInformation] AS RD ON  PR.RelationshipID = RD.RelationshipID
	INNER JOIN [dbo].[ParentOrganization] AS PO ON RD.ParentOrganizationID = PO.ParentOrganizationID
	INNER JOIN [dbo].[PaymentCenterInformation] AS PC ON PR.PaymentCenterID = PC.PaymentCenterID
	INNER JOIN [dbo].[RemitAndReconciliation] AS RR ON PR.RemitandReconciliationID = RR.RemitAndReconciliationID
	WHERE NOT EXISTS(SELECT 1
					 FROM [dbo].[NCPDPFact] AS N
					 WHERE N.ProviderInformationKey = PRI.[ProviderInformationKey]
					   AND N.ePrescribingInformationKey = E.[ePrescribingInformationKey]
					   AND N.StateLicenseKey = SL.[StateLicenseKey]
					   AND N.MedicaidKey = M.[MedicaidKey]
					   AND N.TaxonomyKey = T.[TaxonomyKey]
					   AND N.ChangeofOwnershipKey = C.[ChangeofOwnershipKey]
					   AND N.ServicesOfferedKey = SO.[ServicesOfferedKey]
					   AND N.FraudKey = F.[FraudKey]
					   AND N.ProviderRelationshipKey = PR.[ProviderRelationshipKey]
					   AND N.RemitAndReconciliationKey = RR.[RemitAndReconciliationKey]
					   AND N.RelationshipDemographicKey = RD.[RelationshipDemographicKey]
					   AND N.PaymentCenterKey = PC.[PaymentCenterKey]
					   AND N.ParentOrganizationKey = PO.[ParentOrganizationKey]
					 )

END TRY
BEGIN CATCH

	ROLLBACK TRAN

	DECLARE @ErrorMessage NVARCHAR(4000)
        , @ErrorNumber INT
        , @ErrorSeverity INT
        , @ErrorState INT
        , @ErrorLine INT
        , @ErrorProcedure NVARCHAR(200)

		SELECT 
        @ErrorNumber = ERROR_NUMBER()
        , @ErrorSeverity = ERROR_SEVERITY()
        , @ErrorState = ERROR_STATE()
        , @ErrorLine = ERROR_LINE()
        , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-')
		, @ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (@ErrorMessage 
        , @ErrorSeverity, 1               
        , @ErrorNumber    -- parameter: original error number.
        , @ErrorSeverity  -- parameter: original error severity.
        , @ErrorState     -- parameter: original error state.
        , @ErrorProcedure -- parameter: original error procedure name.
        , @ErrorLine       -- parameter: original error line number.
        );

END CATCH

END

GO
