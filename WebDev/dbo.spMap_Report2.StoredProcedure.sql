USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spMap_Report2]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spMap_Report2]
(
@pmid int
)
as
if exists(select 1 from pharmacymaster..v_test where pmid=@pmid)
BEGIN
	select PMID,Accountname
	,CorporateName
	,addr1 + ' ' + addr2 as [Address]
	,City,State,zip,Phone,email
	,AAPStatus
	,APIStatus
	,case when isMCorNPP=1 then 'Yes' else 'No' end as MCareStatus
	,AccountDescription
	,'(omitted here)' as AvgWholesaleVolume
	,ContactFullName
	,MembershipOwner
	,TM as Territory
	,AAPEffectiveDate
	,MCEffectiveDate
	from
	pharmacymaster..v_test
	where pmid=@pmid
END
ELSE
BEGIN
	Select NCPDP,NPI
	,[Pharmacy Name]
	,[Legal Business Name]
	,[mailing street]+','+[mailing city]+','+[mailing state]+' '+[mailing postal code] as Address
	,[TPN Chain Code]
	,[TPN Account Type]
	,[Office Phone]
	,[Email Address]
	,[Authorized Official]
	from pharmacymaster..tmp_tpn_021916
	where convert(int,ncpdp)=@pmid

END
GO
