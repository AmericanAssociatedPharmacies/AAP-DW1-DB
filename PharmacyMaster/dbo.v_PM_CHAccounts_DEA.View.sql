USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_CHAccounts_DEA]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_PM_CHAccounts_DEA]
AS

	SELECT  distinct chaccountnoprimary as caaccountno,dea from   PM_CHAccounts_ADJ where chaccountnoprimary is not null
		GROUP by chaccountnoprimary,dea 
GO
