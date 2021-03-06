USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_Browser_All]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_PM_Browser_All]
AS

SELECT 
p.PMID,PMParentID,AAPAccountNo,AAPEffectiveDate,AAPParentNo,AAPPreviousGroup,AAPQuitDate,AAPStatus,AccountDescription,AccountName,APIAccountNo,
APIMemberNo,APIStatus,AvgWholesaleVolume,
BusinessClass,CAHStatus,m.ChainCode, 
CustPayTermsAPI,
CompetitiveAcct,ComputerSoftware,ContractDate,CorporateName,DateOpened,DBA,
DEA,DEAEXP,Email,EmergencyPhone,FedID,HolidayHours,Hours,IsStartUpStore,m.MCEffectiveDate,m.MCQuitDate,NCPDP,
NPI,NumReactivated,OrigStartDate,OwnerName,Payee_id,QPS,Resigned,Source,
c.StateLicExpDate,c.StateLicNo,c.StateMedicaidNo,c.AlternativeLanguages,c.SpecialtyServices,
c.EmergencyServices,c.Obra90,c.DeliveryService,c.CounselingArea,c.PatientMR,c.DrugInformation,c.FraudFelonyConviction,c.FraudFelonyExplanation,
 c.RxLicenseSuspendedOrRevoked,c.SuspensionRevokationExplanation,c.InvestigatedByMedicareMedicaid,c.UnrestrictedLicense,c.UnrestrictedLicenseExplanation,c.AnsweringServiceOrMachine,
 c.GenLiabCarrier, c.GenLiabPolicyNumber, c.GenLiabilityLimit1, c.GenLiabilityLimit2, c.GenInsExpDate, c.ProfLiabCarrier, c.ProfPolicyNumber, c.ProfLiabInsExpDate,
 c.ProfLiabLimit1, c.ProfLiabLimit2,c.UAICoverage,c.StoreSizeClassification,c.ContinuingEducationRequired,
c.CompliesWithADAAct,c.AverageWaitTime,c.Judgements,c.MedicationErrorsDocumented,c.ErrorCount12Months,c.HasResolutionPolicy,c.doesCompoundPrescriptions,
 c.UnitDosing,c.ProvidesIV,c.ProvidesDME,c.CertifiedDiseaseMgmt,c.GroupPresentations,c.CDMExplanation,
Territory,UDAccountNo,UDNonPharmacy,UDParentNo,UDQuitDate,UDStatus,Website,Wholesaler,WholesalerAccountNo,WhyResigned,
a.Fax as FaxPri,a.Zip as ZipPri,a.Phone as PhonePri ,a.State as StatePri,a.address as Addr1Pri,a.address2 as Addr2Pri,a.City as CityPri,
a.ContactFullName as ContactFullNamePri,a.county as CountyPri,a.AlternatePhone as AlternatePhonePri,
am.Fax as FaxMail,am.Zip as ZipMail,am.Phone as PhoneMail ,am.State as StateMail,am.address as Addr1Mail,am.address2 as Addr2Mail,am.City as CityMail,
am.ContactFullName as ContactFullNameMail,am.county as CountyMail,am.AlternatePhone as AlternatePhoneMail,
af.Fax as FaxFin,af.Zip as ZipFin,af.Phone as PhoneFin ,af.State as StateFin,af.address as Addr1Fin,af.address2 as Addr2Fin,af.City as CityFin,
af.ContactFullName as ContactFullNameFin,af.county as CountyFin,af.AlternatePhone as AlternatePhoneFin,
dbo.PMListGroupNames(p.pmid) as Groups,gx.group_name as Affiliates,dbo.PMProgramNames(p.pmid) as Programs,
ph.PharPrime,ph.PharFullName,ph.PharTitle,ph.PharState,ph.PharLicNo,ph.PharExpDate

from  pm_pharmacy p
left outer join 
(
SELECT group_name,affiliateid,x.pmid from PM_Groups_xref x
 join PM_Groups g on x.group_id = g.group_id where g.affiliateid is not null
) gx
on p.pmid= gx.pmid
left outer join 
(
select pmid,address,address2,ContactFullName,City,State,Zip,Phone,Fax ,County,AlternatePhone from pm_addressmaster where address_type_id = 1
) a
on p.pmid = a.pmid
left outer join 
(
select pmid,address,address2,ContactFullName,City,State,Zip,Phone,Fax ,County,AlternatePhone from pm_addressmaster where address_type_id = 2
) am
on p.pmid = am.pmid
left outer join 
(
select pmid,address,address2,ContactFullName,City,State,Zip,Phone,Fax ,County,AlternatePhone from pm_addressmaster where address_type_id = 3
) af
on p.pmid = af.pmid
left outer join
(
select pmid,ChainCode,MCEffectiveDate,MCQuitDate from PM_ManagedCare
) m
on p.pmid = m.pmid
left outer join
(
select pmid,StateLicExpDate,StateLicNo,StateMedicaidNo,AlternativeLanguages,SpecialtyServices,EmergencyServices,Obra90,DeliveryService,FraudFelonyConviction,FraudFelonyExplanation,
        RxLicenseSuspendedOrRevoked,SuspensionRevokationExplanation,CounselingArea,PatientMR,DrugInformation,InvestigatedByMedicareMedicaid,
        UnrestrictedLicense,UnrestrictedLicenseExplanation,AnsweringServiceOrMachine,GenLiabCarrier,GenLiabPolicyNumber,GenLiabilityLimit1,GenLiabilityLimit2,GenInsExpDate,
        ProfLiabCarrier,ProfPolicyNumber,ProfLiabInsExpDate,ProfLiabLimit1,ProfLiabLimit2,UAICoverage,StoreSizeClassification,ContinuingEducationRequired,
        CompliesWithADAAct,AverageWaitTime,Judgements,MedicationErrorsDocumented,ErrorCount12Months,HasResolutionPolicy,doesCompoundPrescriptions,
         UnitDosing,ProvidesIV,ProvidesDME,CertifiedDiseaseMgmt,GroupPresentations,CDMExplanation
	  from PM_Cred
) c
on p.pmid = c.pmid
left outer join
(

SELECT  pmid,pharPrime,PharFullName,PharTitle,PharState,PharLicNo,PharExpDate FROM ( 
	SELECT * , Rank() OVER (Partition BY pmid order by PharExpDate desc ,id desc) as Rank
	FROM (SELECT     *
				FROM         PM_Pharmacists
				WHERE          pharprime   in(-1,1)  ) sm 
		) tmp where   Rank = 1   
) ph
on ph.pmid = p.pmid
 

--	SELECT 
--PMID,PMParentID,AAPAccountNo,AAPEffectiveDate,AAPParentNo,AAPPreviousGroup,AAPQuitDate,AAPStatus,AccountDescription,AccountName,
--Addr1,Addr2,AllowDupDEA,APIAccountNo,APIMemberNo,APIStatus,AreaCode,AvgWholesaleVolume,BusinessClass,CAHStatus,CardinalDC,ChainCode,
--City,CompetitiveAcct,ComputerSoftware,ContactFirst,ContactFullName,ContactLast,ContractDate,CorporateName,CustPayTermsAPI,DateOpened,DBA,
--DEA,DEAEXP,EffectiveDate,Email,EmergencyPhone,Fax,FaxAreaCode,FedID,HolidayHours,Hours,IsStartUpStore,MCEffectiveDate,MCQuitDate,NCPDP,
--NPI,NumReactivated,OrigStartDate,OwnerName,Payee_id,Phone,PrimaryCAAccountNo,QPS,Rank,Resigned,Source,State,StateLicExpDate,StateLicNo,
--Status,Territory,UDAccountNo,UDNonPharmacy,UDParentNo,UDQuitDate,UDStatus,Website,Wholesaler,WholesalerAccountNo,WhyResigned,Zip
--from PM_Pharmacy
GO
