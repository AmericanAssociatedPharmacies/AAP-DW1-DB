USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_web_pm_userdata_chaincodeRequired]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view
[dbo].[v_web_pm_userdata_chaincodeRequired]
as
-- DEPRECATED AND CAN BE DELETED BG 1/13
select 
p.pmid, pmparentid,aapaccountno,aapstatus,apiaccountno,ncpdp,dea,npi,statelicno,
accountname,corporatename,city,state,zip,
case when APIStatus = 'ACTIVE' then 1 else 0 end as isAPI,
case when AAPaccountno is not null and AAPquitdate is null then 1 else 0 end as isAAP,
case when
	(ChainCode IS NOT NULL) AND (MCQuitDate IS NULL) AND (AAPAccountNo IS NOT NULL OR
     AAPAccountNo <> '') OR
    (ChainCode IS NOT NULL) AND (MCQuitDate IS NULL) AND (AAPAccountNo IS NULL) AND (IsNPP = - 1)
	then 1 else 0 end as isMC,
case when
(mp.ProgramID = 184)	AND (mp.EndDate IS NULL) 
						AND (p.AAPAccountNo IS NOT NULL) 
						AND (p.AAPQuitDate IS NULL)
	then 1 else 0 end as isElite,
case when p.aapparentno is null or p.aapparentno = p.aapaccountno then ''
	else (select top 1 accountname from pm_pharmacy where pm_pharmacy.aapaccountno = p.aapparentno) end as parent_account,
t.firstname + ' ' + t.lastname as TMName
from v_pm_allwithaffiliates_noClaims p 
left join pharmacymaster.dbo.PM_MemberPrograms mp ON mp.PMID = p.PMID and mp.programid=184
left join  pharmacymaster..pm_territory t on t.territory=p.territory

GO
