USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[ShowExceptions]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Rudy Hinojosa
-- Create date: 7-2-2010
-- Description:	Provides a quick report of incomplete records
-- =============================================
CREATE PROCEDURE [dbo].[ShowExceptions]
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

--FIND INVALID WAREHOUSE RECORDS
select PMID,ACCOUNTNAME,'Flagged as Warehouse and there is no API Warehouse Account Number' as 'Description' from pm_pharmacy where iswarehouse = -1 and apiaccountno is null and aapquitdate is null
UNION all
--FIND INVALID MANAGED CARE RECORDS
select PMID,ACCOUNTNAME,'Flagged as Managed care and there is no Chain Code' as 'Description' from pm_pharmacy p where (p.ismanagedcare = -1 or p.ismanagedcare = 1) and p.pmid in 
   (select pmid from pm_managedcare where pmid = p.pmid and chaincode is null ) and p.aapaccountno is not null and p.aapquitdate is null
union all
select PMID,ACCOUNTNAME,'Flagged as Managed care and there is no Managed Care Record' as 'Description' from pm_PHARMACY p where (p.ismanagedcare = -1 or p.ismanagedcare = 1) and p.pmid NOT in 
   (select pmid from pm_MANAGEDCARE) AND (p.udquitdate is null or p.aapquitdate is null) and p.aapaccountno is not null and p.aapquitdate is null
union all
--FIND BLANK DEA's
select PMID,ACCOUNTNAME,'No DEA# on record.' as 'Description' from pm_pharmacy where dea is null and aapeffectivedate is not null and aapquitdate is null
--union
--FIND BLANK NCPDP's
--select PMID,ACCOUNTNAME,'No NCPDP# on record.' as 'Description' from pm_pharmacy where ncpdp is null

union all
select pmid,accountname,'Invalid space in DEA format' as 'Description' from pm_pharmacy where dea is not null and patindex('% %',substring(dea,1,9)) > 2 and aapquitdate is null

union all
select pmid,accountname,'Blank DEA Warning' as 'Description' from pm_pharmacy where dea is null AND RESIGNED = 'N' AND UDQUITDATE IS NULL AND AAPQUITDATE IS NULL 


union all
select pmid,accountname,'Missing AAP Effective Date' as 'Description' from pm_pharmacy where aapeffectivedate is null AND AAPACCOUNTNO IS NOT NULL 

UNION ALL
select pmid,(select ltrim(accountname) from pm_pharmacy where pmid = p.pmid) + ' (' + p.dea + ')' as 'accountname','Invalid DEA CheckDigit' as 'Description' from dbo.Show_Invalid_DEA_CheckDigit() p
order by accountname,[description]

END








GO
