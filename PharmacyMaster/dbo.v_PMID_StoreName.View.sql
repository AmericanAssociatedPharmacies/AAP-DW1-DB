USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PMID_StoreName]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_PMID_StoreName]
as
select PMID,AccountName,NCPDP from PMStores
GO
