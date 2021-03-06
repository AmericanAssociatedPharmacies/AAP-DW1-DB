USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PPStoreVendor]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spud_PPStoreVendor] 
(
	@pmid int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT MIN(ReportVendorName) AS VendorName, SUM(VolumeAmt) AS Volume, SUM(RebateAmt) * .90 AS Rebate, Convert(numeric(8,2),SUM(RebateAmt) * .10) AS RetainedAmt 
	FROM v_VendorVolumeEligibility WHERE  PMID = @pmid AND  (Eligibility = 1) AND (StorePaiddt IS NULL)GROUP BY PMID, VendorID
END
GO
