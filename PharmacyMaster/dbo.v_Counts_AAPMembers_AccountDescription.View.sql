USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_Counts_AAPMembers_AccountDescription]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_Counts_AAPMembers_AccountDescription]
as
select accountdescription, count(accountdescription) as number from pm_pharmacy
where aapaccountno is not null and aapquitdate is null
group by accountdescription
having count(accountdescription) >0
--order by accountdescription
GO
