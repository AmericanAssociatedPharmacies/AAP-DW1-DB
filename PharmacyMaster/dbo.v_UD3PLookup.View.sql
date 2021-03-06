USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_UD3PLookup]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_UD3PLookup]
as

select distinct a.CAAccountNo as CHAccountNo,
case when UDAccountNo is not null then UDAccountNo
	else AAPAccountNo
end as StoreAccountNo
 from
PM_CHAccounts a left join PM_Pharmacy p 
	on a.DEA=p.DEA 
	or cast(a.CAAccountNo as varchar(50))=p.WholesalerAccountNo

where (UDAccountNo is not null or AAPAccountNo is not null)
and (AAPQuitDate is null or UDQuitDate is null)

GO
