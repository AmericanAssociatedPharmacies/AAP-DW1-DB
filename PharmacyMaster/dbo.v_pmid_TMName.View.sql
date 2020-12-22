USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_pmid_TMName]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_pmid_TMName]
as
select p.pmid, t.firstname + ' ' + t.lastname as TMName
from pm_pharmacy p
left join  pharmacymaster..pm_territory t on p.territory=t.territory
GO
