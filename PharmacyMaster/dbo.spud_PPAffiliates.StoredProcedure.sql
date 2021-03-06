USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PPAffiliates]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JOS/ILA  NARAYANAN
-- Create date: 08/08/2012
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spud_PPAffiliates]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Select  Affiliate, 
SUM(VolumeAmt) as TotalVol,
SUM(RebateAmt) as Totalrebate, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS [PaymentAmt-Fee],
Convert(numeric(8,2),SUM(Case WHEN Eligibility=0 Then 0 ELSE (RebateAmt * .90) END)) AS Payment 
from v_VendorVolumeAff WHERE 
(v_VendorVolumeAff.Affiliate is NOT NULL AND LoadDate is NULL AND FileID is NULL AND FileName is NULL AND PaidDt is NULL) OR 
(v_VendorVolumeAff.Affiliate is NOT NULL AND LoadDate > '03-01-2016')
GROUP BY Affiliate

UNION

Select 'Others ACH' As Affiliate, SUM(TotalVol) as TotalVol,SUM(Totalrebate) as Totalrebate,SUM(PaymentAmt) as PaymentAmt, SUM ([PaymentAmt-Fee]) as [PaymentAmt-Fee], SUM(Payment) as Payment 
FROM (Select 
SUM(VolumeAmt) as TotalVol,
SUM(RebateAmt) as Totalrebate, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS [PaymentAmt-Fee],
Convert(numeric(8,2),SUM(Case WHEN Eligibility=0 Then 0 ELSE (RebateAmt * .90) END)) AS Payment 
from v_VendorVolumeAff 
LEFT JOIN PharmacyMaster..PPStores pm
ON v_VendorVolumeAff.PMID = pm.PMID
WHERE (v_VendorVolumeAff.Affiliate IS NULL AND LoadDate > '03-01-2016') OR 
(v_VendorVolumeAff.Affiliate IS NULL AND LoadDate is NULL AND FileID is NULL AND FileName is NULL AND PaidDt is NULL)
GROUP BY v_VendorVolumeAff.PMID
HAVING SUM(RebateAmt *.9) >= 15 AND MIN(pm.AAPPaymentMode) = 'ACH')v


UNION

Select 'Others CHECK' As Affiliate, SUM(TotalVol) as TotalVol,SUM(Totalrebate) as Totalrebate,SUM(PaymentAmt) as PaymentAmt, SUM ([PaymentAmt-Fee]) as [PaymentAmt-Fee], SUM(Payment) as Payment 
FROM (Select 
SUM(VolumeAmt) as TotalVol,
SUM(RebateAmt) as Totalrebate, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
CONVERT(numeric(8, 2),SUM(RebateAmt * .90) -15) AS [PaymentAmt-Fee],
CASE WHEN MAX(Eligibility) = 0 THEN 0 ELSE CONVERT(numeric(8, 2),SUM(RebateAmt * .90))-15 END AS [Payment]
from v_VendorVolumeAff 
LEFT JOIN PharmacyMaster..PPStores pm
ON v_VendorVolumeAff.PMID = pm.PMID
WHERE (v_VendorVolumeAff.Affiliate IS NULL AND LoadDate > '03-01-2016') OR 
(v_VendorVolumeAff.Affiliate IS NULL AND LoadDate is NULL AND FileID is NULL AND FileName is NULL AND PaidDt is NULL)
GROUP BY v_VendorVolumeAff.PMID
HAVING SUM(RebateAmt *.9) >= 30 AND MIN(pm.AAPPaymentMode) = 'Check'  )v

UNION

Select 'Others ACH Less Than 15' As Affiliate, SUM(TotalVol) as TotalVol,SUM(Totalrebate) as Totalrebate,SUM(PaymentAmt) as PaymentAmt,
SUM([PaymentAmt-Fee]) AS [PaymentAmt-Fee],  cast('0.00' as varchar(256) ) as Payment 
FROM (Select 
SUM(VolumeAmt) as TotalVol,
SUM(RebateAmt) as Totalrebate, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS [PaymentAmt-Fee],
cast('0.00' as varchar(256) ) AS Payment 
from v_VendorVolumeAff 
LEFT JOIN PharmacyMaster..PPStores pm
ON v_VendorVolumeAff.PMID = pm.PMID
WHERE (v_VendorVolumeAff.Affiliate IS NULL AND LoadDate > '03-01-2016') OR 
(v_VendorVolumeAff.Affiliate IS NULL AND LoadDate is NULL AND FileID is NULL AND FileName is NULL AND PaidDt is NULL)
GROUP BY v_VendorVolumeAff.PMID
HAVING SUM(RebateAmt *.9) < 15 AND MIN(pm.AAPPaymentMode) = 'ACH'  ) v


UNION

Select 'Others CHECK Less Than 30' As Affiliate, SUM(TotalVol) as TotalVol,SUM(Totalrebate) as Totalrebate,SUM(PaymentAmt) as PaymentAmt,
SUM([PaymentAmt-Fee]) AS [PaymentAmt-Fee],  cast('0.00' as varchar(256) ) as Payment 
FROM (Select 
SUM(VolumeAmt) as TotalVol,
SUM(RebateAmt) as Totalrebate, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
Convert(numeric(8,2),SUM(RebateAmt) * .90) AS [PaymentAmt-Fee],
cast('0.00' as varchar(256) ) AS Payment 
from v_VendorVolumeAff 
LEFT JOIN PharmacyMaster..PPStores pm
ON v_VendorVolumeAff.PMID = pm.PMID
WHERE (v_VendorVolumeAff.Affiliate IS NULL AND LoadDate > '03-01-2016') OR 
(v_VendorVolumeAff.Affiliate IS NULL AND LoadDate is NULL AND FileID is NULL AND FileName is NULL AND PaidDt is NULL)
GROUP BY v_VendorVolumeAff.PMID
HAVING SUM(RebateAmt *.9) < 30 AND MIN(pm.AAPPaymentMode) = 'Check' ) v

--UNION

--Select 'Others Without Payment Option' As Affiliate, SUM(TotalVol) as TotalVol,SUM(Totalrebate) as Totalrebate,SUM(PaymentAmt) as PaymentAmt,
--SUM([PaymentAmt-Fee]) AS [PaymentAmt-Fee],  SUM(Payment) as Payment 
--FROM(
--SELECT SUM(VolumeAmt) as TotalVol,
--SUM(RebateAmt) as Totalrebate,
--Convert(numeric(8,2),SUM(RebateAmt) * .90) AS PaymentAmt, 
--Convert(numeric(8,2),SUM(RebateAmt) * .90) AS [PaymentAmt-Fee],
--Convert(numeric(8,2),SUM(Case WHEN Eligibility=0 Then 0 ELSE (RebateAmt * .90) END)) AS Payment 
--FROM v_VendorVolumeAff 
--LEFT JOIN PharmacyMaster..PPStores pp
--ON v_VendorVolumeAff.PMID = pp.PMID
--WHERE (v_VendorVolumeAff.Affiliate IS NULL AND LoadDate > '03-01-2016') OR 
--(v_VendorVolumeAff.Affiliate IS NULL AND LoadDate is NULL AND FileID is NULL AND FileName is NULL AND PaidDt is NULL)
--GROUP BY v_VendorVolumeAff.PMID
--HAVING MIN(pp.AAPPaymentMode)is NULL )v


END
GO
