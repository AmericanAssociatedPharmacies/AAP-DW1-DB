USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PPEligibleAffUpd]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spud_PPEligibleAffUpd] 
(
	@dateloaded smalldatetime --First Day of this Quarter
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  
--Update Query for Affiliates field
update VendorVolumeRebate set VendorVolumeRebate.Affiliate = dbo.fnAffiliateDirectPay(v_PM_AllWithAffiliates.Affiliate,v_PM_AllWithAffiliates.AAPParentNo,v_PM_AllWithAffiliates.UDParentNo) 
FROM VendorVolumeRebate JOIN v_PM_AllWithAffiliates ON VendorVolumeRebate.PMID =  v_PM_AllWithAffiliates.PMID


--Update Eligibility=0 if AAPAccountNo IS NULL
update VendorVolumeRebate set VendorVolumeRebate.Eligibility = 0 
FROM VendorVolumeRebate JOIN v_PM_AllWithAffiliates ON VendorVolumeRebate.PMID =  v_PM_AllWithAffiliates.PMID
WHERE Eligibility=1 AND StorePaiddt IS NULL AND AAPAccountNo IS NULL
	
			
--Update Eligibility=0 if AAPQuitDate Prior to that Quarter
update VendorVolumeRebate set VendorVolumeRebate.Eligibility = 0 
FROM VendorVolumeRebate JOIN v_PM_AllWithAffiliates ON VendorVolumeRebate.PMID =  v_PM_AllWithAffiliates.PMID
WHERE Eligibility=1 AND StorePaiddt IS NULL AND AAPQuitDate < @dateloaded 


END
GO
