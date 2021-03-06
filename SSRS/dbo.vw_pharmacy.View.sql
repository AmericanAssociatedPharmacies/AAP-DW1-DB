USE [SSRS]
GO
/****** Object:  View [dbo].[vw_pharmacy]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_pharmacy]
AS
     SELECT a.PMID
          , a.APIAccountNo
          , a.AAPAccountNo
          , a.NCPDP
          , a.AccountName
     FROM PharmacyMaster.dbo.PM_Pharmacy AS a;
GO
