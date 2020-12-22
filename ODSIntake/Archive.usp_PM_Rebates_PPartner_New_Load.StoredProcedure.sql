USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Archive].[usp_PM_Rebates_PPartner_New_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Archive].[usp_PM_Rebates_PPartner_New_Load]


AS


SET NOCOUNT ON;

BEGIN

	INSERT INTO [Archive].[PM_Rebates_PPartner_New](Period, PMID, VolumeAmt, RebateAmt, PaymentAmt, Eligible, Affiliate, LastPayment, [Paid To Store], [Paid To Affiliate], RowCreatedDate, RowUpdatedDate, RowversionID)
	SELECT Period, PMID, VolumeAmt, RebateAmt, PaymentAmt, Eligible, Affiliate, LastPayment, [Paid To Store], [Paid To Affiliate], RowCreatedDate, RowUpdatedDate, RowversionID
	FROM [Staging].[PM_Rebates_PPartner_New]


END

GO
