USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_createPPRebatesDetails]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sppm_createPPRebatesDetails]
	
AS
BEGIN

--FIRST STEP - LOAD Temp table with your queries
 -- Drop temp table if it exists
IF EXISTS(SELECT name FROM sys.tables
 WHERE name = 'PM_Rebates_PPDetails')
BEGIN
DROP TABLE PM_Rebates_PPDetails;
END
 
--Now Populate the temp table	


SELECT * INTO PM_Rebates_PPDetails FROM (
--2014-05-30 
SELECT  '2014Q1' AS Period,
StorePaidDt AS [StorePaidDT],
dbo.VendorVolumeRebate.PMID, MIN ( dbo.Partners.VendorName) AS [VendorName], MIN (PPStores.AccountName) AS [AccountName],  MIN(dbo.VendorVolumeRebate.Affiliate) AS [Affiliate], MIN(dbo.VendorVolumeRebate.Eligibility) AS [Eligibility], 
                        SUM(dbo.VendorVolumeRebate.VolumeAmt) AS Volume, SUM(dbo.VendorVolumeRebate.RebateAmt) AS [Rebate Amount], CONVERT(numeric(8, 2),SUM(dbo.VendorVolumeRebate.RebateAmt*0.90)) AS [Rebate Paid],
                        MIN(PPStores.AAPPaymentMode)AS [AAPPaymentMode]
FROM                  dbo.VendorVolumeRebate LEFT OUTER JOIN
                      dbo.PPStores ON dbo.VendorVolumeRebate.PMID = dbo.PPStores.PMID LEFT OUTER JOIN
                      dbo.Partners ON dbo.VendorVolumeRebate.VendorID =  dbo.Partners.VendorID
WHERE (dbo.VendorVolumeRebate.StorePaidDt = '05-30-2014') AND (dbo.VendorVolumeRebate.PMID IS NOT NULL) AND (dbo.VendorVolumeRebate.Eligibility = 1)
GROUP BY dbo.VendorVolumeRebate.PMID,  dbo.Partners.VendorID, dbo.VendorVolumeRebate.StorePaidDT

UNION

--2014-08-29 
SELECT  '2014Q2' AS Period,
StorePaidDt AS [StorePaidDT],
dbo.VendorVolumeRebate.PMID, MIN ( dbo.Partners.VendorName) AS [VendorName], MIN(PPStores.AccountName) AS [AccountName],  MIN(dbo.VendorVolumeRebate.Affiliate) AS [Affiliate], MIN(dbo.VendorVolumeRebate.Eligibility) AS [Eligibility], 
                        SUM(dbo.VendorVolumeRebate.VolumeAmt) AS Volume, SUM(dbo.VendorVolumeRebate.RebateAmt) AS [Rebate Amount],  CONVERT(numeric(8, 2),SUM(dbo.VendorVolumeRebate.RebateAmt*0.90)) AS [Rebate Paid],
                        MIN(PPStores.AAPPaymentMode)AS [AAPPaymentMode]
FROM                  dbo.VendorVolumeRebate LEFT OUTER JOIN
                      dbo.PPStores ON dbo.VendorVolumeRebate.PMID = dbo.PPStores.PMID LEFT OUTER JOIN
                      dbo.Partners ON dbo.VendorVolumeRebate.VendorID =  dbo.Partners.VendorID
WHERE (dbo.VendorVolumeRebate.StorePaidDt = '08-29-2014') AND (dbo.VendorVolumeRebate.PMID IS NOT NULL) AND (dbo.VendorVolumeRebate.Eligibility = 1)
GROUP BY dbo.VendorVolumeRebate.PMID,  dbo.Partners.VendorID, dbo.VendorVolumeRebate.StorePaidDT


UNION

SELECT  '2014Q3' AS Period,
StorePaidDt AS [StorePaidDT],
dbo.VendorVolumeRebate.PMID, MIN ( dbo.Partners.VendorName) AS [VendorName], MIN(PPStores.AccountName) AS [AccountName],  MIN(dbo.VendorVolumeRebate.Affiliate) AS [Affiliate], MIN(dbo.VendorVolumeRebate.Eligibility) AS [Eligibility], 
                        SUM(dbo.VendorVolumeRebate.VolumeAmt) AS Volume, SUM(dbo.VendorVolumeRebate.RebateAmt) AS [Rebate Amount],  CONVERT(numeric(8, 2),SUM(dbo.VendorVolumeRebate.RebateAmt*0.90)) AS [Rebate Paid],
                        MIN(PPStores.AAPPaymentMode)AS [AAPPaymentMode]
FROM                  dbo.VendorVolumeRebate LEFT OUTER JOIN
                      dbo.PPStores ON dbo.VendorVolumeRebate.PMID = dbo.PPStores.PMID LEFT OUTER JOIN
                      dbo.Partners ON dbo.VendorVolumeRebate.VendorID =  dbo.Partners.VendorID
WHERE (dbo.VendorVolumeRebate.StorePaidDt = '12-01-2014') AND (dbo.VendorVolumeRebate.PMID IS NOT NULL) AND (dbo.VendorVolumeRebate.Eligibility = 1)
GROUP BY dbo.VendorVolumeRebate.PMID,  dbo.Partners.VendorID, dbo.VendorVolumeRebate.StorePaidDT


UNION

SELECT  '2014Q4' AS Period,
StorePaidDt AS [StorePaidDT],
dbo.VendorVolumeRebate.PMID, MIN ( dbo.Partners.VendorName) AS [VendorName], MIN(PPStores.AccountName) AS [AccountName],  MIN(dbo.VendorVolumeRebate.Affiliate) AS [Affiliate], MIN(dbo.VendorVolumeRebate.Eligibility) AS [Eligibility], 
                        SUM(dbo.VendorVolumeRebate.VolumeAmt) AS Volume, SUM(dbo.VendorVolumeRebate.RebateAmt) AS [Rebate Amount],  CONVERT(numeric(8, 2),SUM(dbo.VendorVolumeRebate.RebateAmt*0.90)) AS [Rebate Paid],
                        MIN(PPStores.AAPPaymentMode)AS [AAPPaymentMode]
FROM                  dbo.VendorVolumeRebate LEFT OUTER JOIN
                      dbo.PPStores ON dbo.VendorVolumeRebate.PMID = dbo.PPStores.PMID LEFT OUTER JOIN
                      dbo.Partners ON dbo.VendorVolumeRebate.VendorID =  dbo.Partners.VendorID
WHERE (dbo.VendorVolumeRebate.StorePaidDt = '03-02-2015') AND (dbo.VendorVolumeRebate.PMID IS NOT NULL) AND (dbo.VendorVolumeRebate.Eligibility = 1)
GROUP BY dbo.VendorVolumeRebate.PMID,  dbo.Partners.VendorID, dbo.VendorVolumeRebate.StorePaidDT

UNION

SELECT  '2015' AS Period,
StorePaidDt AS [StorePaidDT],
dbo.VendorVolumeRebate.PMID, MIN ( dbo.Partners.VendorName) AS [VendorName], MIN(PPStores.AccountName) AS [AccountName],  MIN(dbo.VendorVolumeRebate.Affiliate) AS [Affiliate], MIN(dbo.VendorVolumeRebate.Eligibility) AS [Eligibility], 
                        SUM(dbo.VendorVolumeRebate.VolumeAmt) AS Volume, SUM(dbo.VendorVolumeRebate.RebateAmt) AS [Rebate Amount],  CONVERT(numeric(8, 2),SUM(dbo.VendorVolumeRebate.RebateAmt*0.90)) AS [Rebate Paid],
                        MIN(PPStores.AAPPaymentMode)AS [AAPPaymentMode]
FROM                  dbo.VendorVolumeRebate LEFT OUTER JOIN
                      dbo.PPStores ON dbo.VendorVolumeRebate.PMID = dbo.PPStores.PMID LEFT OUTER JOIN
                      dbo.Partners ON dbo.VendorVolumeRebate.VendorID =  dbo.Partners.VendorID
WHERE (dbo.VendorVolumeRebate.StorePaidDt = '2016-03-21') AND (dbo.VendorVolumeRebate.PMID IS NOT NULL) AND (dbo.VendorVolumeRebate.Eligibility = 1)
GROUP BY dbo.VendorVolumeRebate.PMID,  dbo.Partners.VendorID, dbo.VendorVolumeRebate.StorePaidDT

UNION
SELECT  '2016' AS Period,
StorePaidDt AS [StorePaidDT],
dbo.VendorVolumeRebate.PMID, MIN ( dbo.Partners.VendorName) AS [VendorName], MIN(PPStores.AccountName) AS [AccountName],  MIN(dbo.VendorVolumeRebate.Affiliate) AS [Affiliate], MIN(dbo.VendorVolumeRebate.Eligibility) AS [Eligibility], 
                        SUM(dbo.VendorVolumeRebate.VolumeAmt) AS Volume, SUM(dbo.VendorVolumeRebate.RebateAmt) AS [Rebate Amount],  CONVERT(numeric(8, 2),SUM(dbo.VendorVolumeRebate.RebateAmt*0.90)) AS [Rebate Paid],
                        MIN(PPStores.AAPPaymentMode)AS [AAPPaymentMode]
FROM                  dbo.VendorVolumeRebate LEFT OUTER JOIN
                      dbo.PPStores ON dbo.VendorVolumeRebate.PMID = dbo.PPStores.PMID LEFT OUTER JOIN
                      dbo.Partners ON dbo.VendorVolumeRebate.VendorID =  dbo.Partners.VendorID
WHERE (dbo.VendorVolumeRebate.StorePaidDt IS NULL) AND (dbo.VendorVolumeRebate.PMID IS NOT NULL) AND (dbo.VendorVolumeRebate.Eligibility = 1)
GROUP BY dbo.VendorVolumeRebate.PMID,  dbo.Partners.VendorID, dbo.VendorVolumeRebate.StorePaidDT
 ) p
ORDER BY Period




SELECT * FROM PM_Rebates_PPDetails ORDER BY Period


END

GO
