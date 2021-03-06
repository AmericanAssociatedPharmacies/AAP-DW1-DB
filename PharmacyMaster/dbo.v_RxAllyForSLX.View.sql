USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_RxAllyForSLX]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_RxAllyForSLX]
AS
select NCPDP,DEA,StartDate  from pm_memberprograms m
left outer join
(
	select *  from pm_pharmacy  where aapquitdate is null
) p
on m.pmid = p.pmid
where programid = 188 and enddate is null 
GO
