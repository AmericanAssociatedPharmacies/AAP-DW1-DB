USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_PMServicesSurveyImportFix]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sppm_PMServicesSurveyImportFix]
as

 
UPDATE import_pm_servicessurvey set DiabetesEducatorCertified = 0 where DiabetesEducatorCertified is null
UPDATE import_pm_servicessurvey set DiabetesEducatorNonCertified = 0 where DiabetesEducatorNonCertified is null
UPDATE import_pm_servicessurvey set HypertensionTesting = 0 where HypertensionTesting is null
UPDATE import_pm_servicessurvey set AsthmaServices = 0 where AsthmaServices is null
UPDATE import_pm_servicessurvey set CholesterolServices = 0 where CholesterolServices is null
UPDATE import_pm_servicessurvey set CompoundingLevel1thru3 = 0 where CompoundingLevel1thru3 is null
UPDATE import_pm_servicessurvey set CompoundingLevel4Sterile = 0 where CompoundingLevel4Sterile is null
UPDATE import_pm_servicessurvey set DMELight = 0 where DMELight is null
UPDATE import_pm_servicessurvey set DMEHeavy = 0 where DMEHeavy is null
UPDATE import_pm_servicessurvey set DMEAccreditedPharmacy = 0 where DMEAccreditedPharmacy is null
UPDATE import_pm_servicessurvey set Contracted340BSelfAdministered = 0 where Contracted340BSelfAdministered is null
UPDATE import_pm_servicessurvey set Contracted340BThirdPartyAdministered = 0 where Contracted340BThirdPartyAdministered is null
UPDATE import_pm_servicessurvey set ImmunizationsFLUVaccines = 0 where ImmunizationsFLUVaccines is null
UPDATE import_pm_servicessurvey set ImmunizationsTravelVaccines = 0 where ImmunizationsTravelVaccines is null
UPDATE import_pm_servicessurvey set NutritionServices = 0 where NutritionServices is null
UPDATE import_pm_servicessurvey set OtherRetirementCommunities = 0 where OtherRetirementCommunities is null
UPDATE import_pm_servicessurvey set OtherAssistedLivingFacilities = 0 where OtherAssistedLivingFacilities is null
UPDATE import_pm_servicessurvey set OtherHospiceCenters = 0 where OtherHospiceCenters is null
UPDATE import_pm_servicessurvey set OtherSkilledNursingFacilities = 0 where OtherSkilledNursingFacilities is null
UPDATE import_pm_servicessurvey set DeliveryServicesNoCharge = 0 where DeliveryServicesNoCharge is null
UPDATE import_pm_servicessurvey set DeliveryServicesChargeFee = 0 where DeliveryServicesChargeFee is null

update import_pm_servicessurvey set ncpdp = replace(ncpdp,'-','') where ncpdp like '%-%'
update import_pm_servicessurvey set ncpdp = replace(ncpdp,' ','') 

--Bad NCPDP
update import_pm_servicessurvey set ncpdp = '3844126' where ncpdp ='38441216'
 
update import_pm_servicessurvey set ncpdp = '5701784' where ncpdp ='570784'

update import_pm_servicessurvey set ncpdp = replicate('0', 7-len(ncpdp)) + ncpdp where len(ncpdp) < 7
 

--UPDATE PMIDs
 
		UPDATE  ip  set 
			ip.PMID = p.pmid  
	   FROM import_pm_servicessurvey   ip 
		inner join 
			( select pmid,ncpdp from pm_pharmacy ) p
	    on p.ncpdp =  ip.ncpdp  where ip.pmid is  null

-- Need special insert for PMID 104148 for this one
UPDATE import_pm_servicessurvey set PMID = 104147 where ncpdp = '3408437and3421788'

--Update where they used the NPI instead of the NCPDP
		UPDATE  ip  set 
			ip.PMID = p.pmid  
	   FROM import_pm_servicessurvey   ip 
		inner join 
			( select pmid,npi from pm_pharmacy ) p
	    on p.npi = ip.ncpdp   where len(ncpdp) > 7  and ncpdp not like '%and%' and ip.pmid is  null


-- Now do the insert 

 INSERT into pm_servicessurvey
 SELECT PMID,DiabetesEducatorCertified,DiabetesEducatorNonCertified,HypertensionTesting,AsthmaServices,CholesterolServices,CompoundingLevel1thru3,
CompoundingLevel4Sterile,DMELight,DMEHeavy,DMEAccreditedPharmacy,Contracted340BSelfAdministered,Contracted340BThirdPartyAdministered,
Contracted340BExplain,ImmunizationsFLUVaccines,ImmunizationsTravelVaccines,ImmunizationsOtherExplain,WeightLossClinics,NutritionServices,
OtherRetirementCommunities,OtherAssistedLivingFacilities,OtherHospiceCenters,OtherSkilledNursingFacilities,DeliveryServicesNoCharge,
DeliveryServicesChargeFee,Created,Modified,RowVersion from (
 SELECT 
PMID,DiabetesEducatorCertified,DiabetesEducatorNonCertified,HypertensionTesting,AsthmaServices,CholesterolServices,CompoundingLevel1thru3,
CompoundingLevel4Sterile,DMELight,DMEHeavy,DMEAccreditedPharmacy,Contracted340BSelfAdministered,Contracted340BThirdPartyAdministered,
Contracted340BExplain,ImmunizationsFLUVaccines,ImmunizationsTravelVaccines,ImmunizationsOtherExplain,WeightLossClinics,NutritionServices,
OtherRetirementCommunities,OtherAssistedLivingFacilities,OtherHospiceCenters,OtherSkilledNursingFacilities,DeliveryServicesNoCharge,
DeliveryServicesChargeFee,'11/07/2012' as Created,'11/07/2012' as Modified,1 as RowVersion from import_pm_servicessurvey where
 pmid   not  in (select pmid from pm_servicessurvey  ) and pmid is not null  
 )ch

--FOR REPORT

select p.PMID,p.AccountName as [Account Name], p.TM, p.AAPAccountNo as [AAP#], p.NCPDP, p.City, p.State, p.Addr1 ,p.Addr2, p.Zip, p.Phone from v_pm_allwithaffiliates p
join
(
select * from pm_servicessurvey
)s
on p.pmid = s.pmid order by TM


GO
