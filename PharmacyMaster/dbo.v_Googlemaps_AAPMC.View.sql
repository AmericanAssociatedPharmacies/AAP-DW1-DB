USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_Googlemaps_AAPMC]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view
[dbo].[v_Googlemaps_AAPMC]
as
/* updated 2/2016 for GLocator2016, using v3 of google maps api and markerclusterer.js BG

*/
select 
g.latitude as lat
, g.longitude as lng
, p.accountname as name
, g.gaddress as address
, g.pmid as ids
,case when mc.chaincode is not null and mc.mcquitdate is null then 'MC' else 'AAP' end as type
,[state]
from pm_geocode g left join v_test p --state not in pm_pharmacy
on g.pmid=p.pmid
--left join pm_addressmaster a on g.pmid=a.pmid and a.Address_Type_Id=1 
left join pm_managedcare mc on g.pmid=mc.pmid and mc.mcquitdate is null
where p.aapaccountno is not null and p.aapquitdate is null
and latitude is not null and latitude<>0.0


GO
