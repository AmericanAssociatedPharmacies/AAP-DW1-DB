USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_Address_Mailing_ListGen_DupEmail_TEST]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Address_Mailing_ListGen_DupEmail_TEST]
AS


SELECT m.PMID,p.Source,mc.MCEffectiveDate,p.AAPEffectiveDate,p.AccountName,m.address as Addr1,m.address2 as Addr2,m.City,m.State,m.Zip,p.ownername as ContactFullName,
           p.Territory,m1.Phone, m1.Fax,p.Email,p.Status,p.BusinessClass,
           p.AAPAccountNo,p.AAPParentNo,p.APIAccountNo,p.UDAccountNo,p.UDParentNo,mc.ChainCode,
           g.GroupID  ,p.aapstatus,p.udstatus,p.apistatus,g.group_name,mc.MCQuitDate,p.aapquitdate,p.dea,p.ncpdp,p.npi,cr.statelicno,p.computersoftware,
			p.isNpp,p.GroupNo,p.accountdescription,cr.StateMedicaidNo,cr.StateLicExpDate,p.DEAExp,p.FedID 

           from v_Address_Mailing m
	join 
	(
		SELECT Source,AAPEffectiveDate,accountname,pmid,AAPAccountNo,AAPParentNo,APIAccountNo,UDAccountNo,UDParentNo,dea,Territory,Email,Status,BusinessClass,
               aapstatus,udstatus,apistatus,udnonpharmacy,aapquitdate,ncpdp,npi,ownername,computersoftware ,isNpp,GroupNo,accountdescription,DEAExp,FedID  from 
               REPORTS..tmp_PM_DupEmail
	)p
	on  m.pmid = p.pmid
    join 
   (
		select pmid,GroupID,group_name from v_PM_AllWithGroups
    ) g 
      on m.pmid = g.pmid

   join 
   (
		select pmid,phone,fax from pm_addressmaster where address_type_id = 1
    ) m1
      on m.pmid = m1.pmid
    left outer join 
   (
		select * from PM_ManagedCare
    ) mc

   on m.pmid = mc.pmid
    left outer join 
   (
		select * from PM_Cred
    ) cr

   on m.pmid = cr.pmid
   
	where (  businessclass != 'SDFT'   or businessclass is null) 
					 and ( Territory != 'XX' or Territory is null) 
					 and ((apiaccountNo !=  '_CREATIVE' and apiaccountNo != 'SECRETARY' and apiaccountNo != '00APSLLC' ) or apiaccountNo is null) 
					and (udnonpharmacy != 'C' or udnonpharmacy is null)

GO
