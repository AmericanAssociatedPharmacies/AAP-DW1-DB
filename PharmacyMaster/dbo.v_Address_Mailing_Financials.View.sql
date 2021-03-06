USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_Address_Mailing_Financials]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Address_Mailing_Financials]
AS

	SELECT * FROM ( 
	SELECT * , Rank() OVER (Partition BY pmid order by address_type_id desc) as Rank
	FROM (SELECT     *
				FROM         PharmacyMaster.dbo.PM_AddressMaster
				WHERE       address_type_id in (1,2,3)     ) pm 
		) tmp where   Rank = 1  
GO
