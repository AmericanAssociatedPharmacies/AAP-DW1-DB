USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PPAffiliates_bak]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JOS/ILA  NARAYANAN
-- Create date: 08/08/2012
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spud_PPAffiliates_bak]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*Select (Case WHEN Affiliate IS NULL Then 'Others' else Affiliate End) As Affiliate, SUM(VolumeAmt) as TotalVol,SUM(RebateAmt) as Totalrebate, Convert(numeric(8,2),
	SUM(RebateAmt) * .90) AS PaymentAmt, Convert(numeric(8,2),SUM(Case WHEN Eligibility=0 Then 0 ELSE RebateAmt * .90 END)) AS Payment from v_VendorVolumeAff
    GROUP BY Affiliate*/

Select  Affiliate, 
SUM(VolumeAmt) as TotalVol,
SUM(RebateAmt) as Totalrebate, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS [PaymentAmt-Fee],
--Convert(numeric(8,2),SUM(Case WHEN Eligibility=0 Then 0 ELSE (RebateAmt * .90) - 15 END)) AS Payment 
CASE WHEN Eligibility = 0 THEN 0 ELSE Convert(numeric(8,2),SUM(RebateAmt) * .90) END AS [Payment]
from v_VendorVolumeAff WHERE Affiliate IS NOT NULL
GROUP BY Affiliate,Eligibility

UNION

Select 'Others' As Affiliate, SUM(TotalVol) as TotalVol,SUM(Totalrebate) as Totalrebate,SUM(PaymentAmt) as PaymentAmt, SUM ([PaymentAmt-Fee]) as [PaymentAmt-Fee], SUM(Payment) as Payment 
FROM (Select 
SUM(VolumeAmt) as TotalVol,
SUM(RebateAmt) as Totalrebate, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) - 15 AS [PaymentAmt-Fee],
--Convert(numeric(8,2),SUM(Case WHEN Eligibility=0 Then 0 ELSE (RebateAmt * .90) - 15 END)) AS Payment  
CASE WHEN Eligibility = 0 THEN 0 ELSE Convert(numeric(8,2),SUM(RebateAmt) * .90) - 15 END AS [Payment]
from v_VendorVolumeAff 
WHERE Affiliate IS NULL 
GROUP BY PMID, Eligibility
HAVING SUM(RebateAmt *.9) >= 15 )v

UNION

Select 'Others Less Than 15' As Affiliate, SUM(TotalVol) as TotalVol,SUM(Totalrebate) as Totalrebate,SUM(PaymentAmt) as PaymentAmt,
cast('0.00' as varchar(256) )AS [PaymentAmt-Fee],  SUM(Payment) as Payment 
FROM (Select 
SUM(VolumeAmt) as TotalVol,
SUM(RebateAmt) as Totalrebate, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
Convert(numeric(8,2),SUM(Case WHEN Eligibility=0 Then 0 ELSE RebateAmt * .90 END)) AS Payment  
from v_VendorVolumeAff WHERE Affiliate IS NULL GROUP BY PMID HAVING SUM(RebateAmt *.9) < 15) v

END
GO
