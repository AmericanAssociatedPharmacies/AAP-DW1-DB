USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PPAffiliateStore]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spud_PPAffiliateStore]
(
	@affiliate nvarchar(200)
)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- V2: Replaced v_VendorVolumeEligibility with v_VendorVolumeEligiblePaytoAddr

	if @affiliate = 'Others'

	BEGIN

	   SELECT Max(PayTo) as PayTo, MIN(NCPDP) as NCPDP,MIN(PMID) AS PMID, (Case WHEN MIN(Affiliate) IS NULL Then 'Others' else MIN(Affiliate) End) As Affiliate, 
		MIN(AccountName) AS AccountName, MIN(Addr1) + ' ' + RTRIM(MIN(Addr2)) AS Address, RTRIM(MIN(City)) + ', ' + MIN(State) + ', ' + MIN(Zip) AS CityState , MIN(AAPQuitDate) as AAPQuitDate
		FROM v_VendorVolumeEligiblePaytoAddr WHERE (Eligibility = 1)  AND Affiliate IS NULL AND PMID IS NOT NULL GROUP BY PMID HAVING SUM(RebateAmt *.9) >= 15 
		ORDER BY MIN(NCPDP)

	END

	if @affiliate = 'Others Less Than 15'

	BEGIN

	   SELECT Max(PayTo) as PayTo, MIN(NCPDP) as NCPDP,MIN(PMID) AS PMID, (Case WHEN MIN(Affiliate) IS NULL Then 'Others' else MIN(Affiliate) End) As Affiliate, 
		MIN(AccountName) AS AccountName, MIN(Addr1) + ' ' + RTRIM(MIN(Addr2)) AS Address, RTRIM(MIN(City)) + ', ' + MIN(State) + ', ' + MIN(Zip) AS CityState , MIN(AAPQuitDate) as AAPQuitDate
		FROM v_VendorVolumeEligiblePaytoAddr WHERE (Eligibility = 1)  AND Affiliate IS NULL AND PMID IS NOT NULL GROUP BY PMID HAVING SUM(RebateAmt *.9) < 15 
		ORDER BY MIN(NCPDP)

	END

	if @affiliate <> 'Others' AND @affiliate <> 'Others Less Than 15'

	BEGIN

	   SELECT Max(PayTo) as PayTo, MIN(NCPDP) as NCPDP,MIN(PMID) AS PMID, (Case WHEN MIN(Affiliate) IS NULL Then 'Others' else MIN(Affiliate) End) As Affiliate, 
		MIN(AccountName) AS AccountName, MIN(Addr1) + ' ' + RTRIM(MIN(Addr2)) AS Address, RTRIM(MIN(City)) + ', ' + MIN(State) + ', ' + MIN(Zip) AS CityState , MIN(AAPQuitDate) as AAPQuitDate
		FROM v_VendorVolumeEligiblePaytoAddr WHERE (Eligibility = 1)  AND Affiliate=@affiliate AND PMID IS NOT NULL  GROUP BY PMID --HAVING SUM(RebateAmt) > 5 
		ORDER BY MIN(NCPDP)
	END


	

END
GO
