USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [Staging].[usp_PM_Rebates_PPartner_New_Load]    Script Date: 12/22/2020 7:35:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_PM_Rebates_PPartner_New_Load]


AS


SET NOCOUNT ON;

BEGIN

	INSERT INTO [Staging].[PM_Rebates_PPartner_New](Period, PMID, VolumeAmt, RebateAmt, PaymentAmt, Eligible, Affiliate, LastPayment, [Paid To Store], [Paid To Affiliate], RowCreatedDate, RowUpdatedDate, RowversionID)
	SELECT Period, PMID, VolumeAmt, RebateAmt, PaymentAmt, Eligible, Affiliate, LastPayment, [Paid To Store], [Paid To Affiliate], RowCreatedDate, RowUpdatedDate, RowversionID
	FROM ODSIntake.[Staging].[PM_Rebates_PPartner_New]


END

GO
