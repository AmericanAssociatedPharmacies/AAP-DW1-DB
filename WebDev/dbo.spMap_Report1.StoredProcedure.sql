USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spMap_Report1]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spMap_Report1]
(
@pmid int
)
as
select PMID,Accountname
,CorporateName
,City,State,zip,Phone,email
,AAPStatus
,APIStatus
,case when isMCorNPP=1 then 'Yes' else 'No' end as MCareStatus
,AccountDescription
,AvgWholesaleVolume
,ContactFullName
,MembershipOwner
,TM as Territory
,AAPEffectiveDate
,MCEffectiveDate
from
pharmacymaster..v_test
where pmid=@pmid
GO
