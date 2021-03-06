USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_ActivePMIDforNCPDP]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ActivePMIDforNCPDP]
AS
SELECT Rank() OVER (Partition BY NCPDP order by aapeffectivedate desc, aapquitdate asc, aapaccountno desc) as Rank,
     NCPDP, pmid,AAPQuitDate,MCQuitDate,MCEffectiveDate
     FROM v_PM_Allwithaffiliates where NCPDP is not null
GO
