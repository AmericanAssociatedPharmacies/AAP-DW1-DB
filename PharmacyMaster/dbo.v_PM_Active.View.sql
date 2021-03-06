USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_Active]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_PM_Active]
as
select v.*,
case when v.apistatus='ACTIVE' 
	then cast(1 as integer) else cast(0 as integer) end as APIActive,
case when v.aapaccountno is not null and v.aapeffectivedate is not null and v.aapquitdate is null 
	then cast(1 as integer) else cast(0 as integer) end as AAPActive,
case when aapaccountno is null or v.chaincode is null or v.aapquitdate is not null or v.mcquitdate is not null
	then cast(0 as integer) else cast(1 as integer) end as MCActive

from v_PM_AllWithAffiliates v

GO
