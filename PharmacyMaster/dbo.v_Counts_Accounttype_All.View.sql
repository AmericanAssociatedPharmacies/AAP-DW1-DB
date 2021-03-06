USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_Counts_Accounttype_All]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view
[dbo].[v_Counts_Accounttype_All]
as
--B.Grant 6/10
select type, count(type) as number
from
(
select g.pmid as ids, 
g.latitude as lat, g.longitude as lng,
g.gaddress as address, dt1.[type]
from 
(
select p.pmid,
case when p.aapaccountno is not null and p.aapquitdate is null then
	case when mc.chaincode is not null and mc.mcquitdate is null then 'MC-AAP' else 'AAP' end
else
	case when udaccountno is not null and udquitdate is null and aapquitdate is null then 		
		case when mc.chaincode is not null and mc.mcquitdate is null then 'MC-UD' else 'UD' end
		when (udaccountno is null or udquitdate is not null or aapquitdate is not null) and apiaccountno is not null then 'API-'+isnull(apistatus,'')
		else 'NON'
	end
end as [type]
from v_PM_AllWithAffiliates_Filtered p	--removes closed status API and old UD
left join pm_managedcare mc on p.pmid=mc.pmid
--where dea is not null
) dt1
left join PM_GEOCODE g on g.pmid=dt1.pmid
--where [type] <> 'NON'
) dt2
group by type
GO
