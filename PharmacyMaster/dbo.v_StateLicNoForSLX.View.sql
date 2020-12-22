USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_StateLicNoForSLX]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[v_StateLicNoForSLX]
AS
SELECT   DEA, apiaccountno,statelicno  from  v_pm_allwithaffiliates
 where  statelicno is not null and statelicno !='' and (DEA is not null or apiaccountno is not null)
 
GO
