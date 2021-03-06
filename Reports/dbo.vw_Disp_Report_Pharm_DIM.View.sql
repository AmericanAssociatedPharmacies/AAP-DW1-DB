USE [Reports]
GO
/****** Object:  View [dbo].[vw_Disp_Report_Pharm_DIM]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Disp_Report_Pharm_DIM]
AS
     SELECT DISTINCT
            t1.PMID
          , t1.APIAccountNo
          , t1.AccountName
          , t1.APIStatus
          , t1.AAPStatus
          , t1.Territory
     FROM PharmacyMaster.dbo.PM_Pharmacy AS t1
          JOIN Rx30.dbo.EventDim AS t2 ON t2.ServiceProviderID = t1.NCPDP;
GO
