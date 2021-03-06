USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_tmp_pipco]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_tmp_pipco]
as

select 'PIPCO' as aff, p.pmid, a.accountid,a.AAPID,a.PreviousAcctNo as udid   
from pharmacy1 p left join aap.dbo.AAPAccount a on p.aapaccountno=a.aapid 
left join aap.dbo.AAPAccountAffiliateGroup g on a.accountid = g.accountid where (g.affiliategroupid=7
and a.quitdate is null) or a.accountid in (1635,1636,1637)   
union all
select '' as aff, p.pmid,a.accountid,a.AAPID,a.PreviousAcctNo as udid 
from pharmacy1 p left join aap.dbo.AAPAccount a on p.aapaccountno=a.aapid 
left join aap.dbo.AAPAccountAffiliateGroup g on a.accountid = g.accountid where (g.affiliategroupid is null or g.affiliategroupid<>7)
and a.quitdate is null and a.accountid not in (1635,1636,1637)   

GO
