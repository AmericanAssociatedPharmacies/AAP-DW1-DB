USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_MCActive_withBashasHQonly]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_MCActive_withBashasHQonly]
as
select *
from pharmacymaster..v_pm_allwithaffiliates
 where 
 (
 chaincode is not null
 and mcquitdate is null
 and (aapquitdate is null or isNPP=-1) --include NPPs
 and isnull(aapparentno,0) <> 11377 --exclude Bashas
) or PMID=100364 --include Bashas HQ
GO
