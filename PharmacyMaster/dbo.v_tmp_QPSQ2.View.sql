USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_tmp_QPSQ2]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_tmp_QPSQ2]
as
select 
r.PMID, r.AAP#, 
p.AccountDescription,
r.API#, r.Name, r.City, r.St, r.TM, r.Effective, 
p.AAPQuitDate as QuitDate, 
r.APIStatus, r.Chain as [MC Chain], --r.[M.Care], 
r.CHSales_Q2, --r.CHSales_0610, 
r.API_Q2, --r.API_0610
c.Claimcount as [Rx30 Claim Count],
c.TotalPaid as [Rx30 Total Paid],
r.CHSales_Q2 + r.API_Q2 - c.TotalPaid as [Difference]
 from tmp_report_QPSProfile0810 r
left join pm_pharmacy p on r.pmid=p.pmid
left join claims..v_Rx30ClaimsQPS c on r.pmid=c.pmid

GO
