USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_pm_pharmacy_plus_pm_deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view
[dbo].[v_pm_pharmacy_plus_pm_deleted]
as

select * from pharmacymaster..pm_pharmacy p
union
select * from pharmacymaster..pm_deleted d
GO
