USE [PharmacyMaster]
GO
/****** Object:  View [Staging].[vw_PM_Pharmacy_LA]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [Staging].[vw_PM_Pharmacy_LA]

AS

SELECT CONVERT(INT, new_pmid) AS PMID
, NULL AS PMParentID
, CONVERT(VARCHAR(20), new_aap_account) AS AAPAccountNo
, CONVERT(DATETIME, new_aap_effective_date) AS AAPEffectiveDate
, CONVERT(VARCHAR(20), new_aapparent) AS AAPParentNo
, CONVERT(VARCHAR(20),NULL) AS AAPPreviousGroup -- Not needed per Wayne.Use what is in PM_Pharmacy
, CONVERT(DATETIME, new_aapquit) AS AAPQuitDate
, CONVERT(VARCHAR(32), new_aapstatusname) AS AAPStatus
, CONVERT(VARCHAR(150), NULL) AS AccountDescription --Have mapping but only 1 PMID has the new_account_subtypename field filled. Will use what is in PharmacyMaster for now.
, CONVERT(VARCHAR(65), name) AS AccountName
, CONVERT(VARCHAR(10),NULL) AS AllowDupDEA -- Per notes from TH, no longer needed per Linda J.
, CONVERT(VARCHAR(20), [new_api_account]) AS APIAccountNo
, CONVERT(VARCHAR(150),NULL) AS APIDEA
, CONVERT(VARCHAR(150),NULL) AS APIMemberNo --Per Andrea, not being used. 
, CONVERT(INT, new_pmid) AS APIPMID
, CONVERT(VARCHAR(32) , new_apistatusname) AS APIStatus
, CONVERT(VARCHAR(150),NULL) AS AvgWholesaleVolume --Per TH, not needed. Keep whats in PM_Phamrmacy
, CONVERT(VARCHAR(4), LEFT(new_businessclassname, 3)) AS BusinessClass
, CONVERT(VARCHAR(32) , new_cahpvastatusname) AS CAHStatus
, CONVERT(VARCHAR(150),NULL) AS CardinalDC -- Per TH, data not current in PM_Pharmacy
, CONVERT(INT, CASE
				WHEN new_categoryname = 'Apothecary' THEN 1
				WHEN new_categoryname = 'Clinic' THEN 2
				WHEN new_categoryname = 'LTC/Clsd Door' THEN 3
				WHEN new_categoryname = 'Full Line' THEN 5
				WHEN new_categoryname = 'Grocery' THEN 6
				WHEN new_categoryname = 'Medical Supply' THEN 7
				WHEN new_categoryname = 'Compounding Phcy' THEN 8
				END
		) AS CategoryID 
, CONVERT(VARCHAR(150),NULL) AS CompetitiveAcct --Per notes from TH, per Wayne no longer used.
, CONVERT(VARCHAR(255), new_computer_softwarename) AS ComputerSoftware
, CONVERT(DATETIME, new_cahpvacontractdate) AS ContractDate
, CONVERT(VARCHAR(100), new_corporatename) AS CorporateName
, CONVERT(VARCHAR(20), 
						CASE
						WHEN [new_api_termsname] = 'Standard' THEN 'DAY'
						WHEN [new_api_termsname] = 'ACH - 2 day/ROG' THEN 'ROG'
						WHEN [new_api_termsname] = 'ACH - 10 day' THEN 'A10'
						WHEN [new_api_termsname] = 'ACH - Weekly' THEN 'ATA'
						ELSE NULL
						END
						) AS CustPayTermsAPI -- Will only use values from CRM for any new rows. 
, CONVERT(DATETIME,NULL) AS DateOpened -- Per TH, date should be added in CRM by mid-May
, CONVERT(VARCHAR(65), name)  AS DBA
, CONVERT(VARCHAR(50), new_dea) AS DEA
, CONVERT(DATETIME, new_deaexpiration) AS DEAEXP
, CONVERT(VARCHAR(255), emailaddress1) AS Email
, CONVERT(VARCHAR(15), telephone1) AS EmergencyPhone
, NULL AS EstMonthlyVol --Per LAC, not used.
, CONVERT(VARCHAR(12), new_fed_tax) AS FedID
, CONVERT(VARCHAR(20), new_group) AS GroupNo 
, CONVERT(VARCHAR(100), ('M-F ' + new_hours_weekdays_open + ' - ' + new_hours_weekdays_close) + ISNULL((', SAT ' + new_hours_saturday_open + ' - ' + new_hours_saturday_close + ', SUN ' + new_hours_sunday_open + ' - ' + new_hours_sunday_close), ''))  AS [Hours]
, CONVERT(VARCHAR(150),NULL) AS IsHighVolume
, CONVERT(VARCHAR(150),NULL) AS [StoreHours_HolidayAM]
, CONVERT(VARCHAR(150),NULL) AS [StoreHours_HolidayPM]
, CONVERT(VARCHAR(5), REPLACE(new_hours_weekdays_open, 'AM', '')) AS [StoreHours_MondayFridayAM]
, CONVERT(VARCHAR(5), REPLACE(new_hours_weekdays_close, 'PM', '')) [StoreHours_MondayFridayPM]
, CONVERT(VARCHAR(5), REPLACE(new_hours_saturday_open, 'AM', '')) AS [StoreHours_SaturdayAM]
, CONVERT(VARCHAR(5), REPLACE(new_hours_saturday_close, 'PM', '')) AS [StoreHours_SaturdayPM]
, CONVERT(VARCHAR(5), REPLACE(new_hours_sunday_open, 'AM', '')) AS [StoreHours_SundayAM]
, CONVERT(VARCHAR(5), REPLACE(new_hours_sunday_close, 'AM', '')) AS [StoreHours_SundayPM]
, CONVERT(SMALLINT, CASE
					WHEN new_startupname LIKE '%Yes%' THEN 1 
					ELSE 0
					END
	) AS IsStartUpStore
, CONVERT(VARCHAR(20) , new_ncpdp) AS NCPDP
, CONVERT(VARCHAR(50), new_npi) AS NPI
, NULL AS[NumReactivated] -- Not being used, Will leave NULL for now.
, CONVERT(DATETIME,NULL) AS [OrigStartDate] -- Per LAC, not used. Per notes from TH, per Linda J not being used.
, CONVERT(VARCHAR(200), new_pharmacyownerlookupname) AS OwnerName
, NULL AS Payee_id -- Use what is PM_Pharmacy. All new rows leave NULL
, NULL AS [PrimaryCAAccountNo] -- Use what is PM_Pharmacy. All new rows leave NULL
, CONVERT(VARCHAR(150),NULL) AS PrimaryWholesaler -- Use what is PM_Pharmacy. All new rows leave NULL
, CONVERT(VARCHAR(150),NULL) AS QPS -- Per notes from TH, per Wayne not being used.
, NULL AS Rank -- Use what is PM_Pharmacy. All new rows leave NULL
, CONVERT(VARCHAR(150),NULL) AS Resigned -- Per Wayne, not needed.
, CONVERT(VARCHAR(150),NULL) AS Source -- Per notes from TH, per Linda J not being used anymore. This was a United Drugs only column.
, CONVERT(VARCHAR(32), new_aapstatusname) AS [Status]
, CONVERT(VARCHAR(4), new_territoriesname) AS Territory
 , NULL AS [UDAccountNo] -- Use what is in PM_Pharmacy
 , NULL [UDNonPharmacy] -- Use what is in PM_Pharmacy
 , NULL [UDParentNo] -- Use what is in PM_Pharmacy
 , CONVERT(DATETIME,NULL) [UDQuitDate] -- Use what is in PM_Pharmacy
 , CONVERT(VARCHAR(150),NULL) AS UDStatus -- Use what is in PM_Pharmacy
, CONVERT(VARCHAR(100), websiteurl) AS Website
, CONVERT(VARCHAR(25), new_primarywholesalernewname) AS Wholesaler 
, NULL AS [WholesalerAccountNo] -- Per Wayne, not used
, CONVERT(VARCHAR(255), new_aap_resignation_reasonname) AS [WhyResigned]
, CONVERT(SMALLINT, 0) AS [IsBuyingGroup]
, CONVERT(SMALLINT, 0) AS [IsPos]
, CASE 
	WHEN new_wholesalername LIKE '%Cardinal%' THEN -1
	ELSE 0
	END AS IsPVA --Per Wayne's email on 05/08/2018, not needed. But, after discussion and discovery, column is being used in compliance report and is needed.
, CASE	
	WHEN new_fee_paidname = 'Yes' THEN 1
	ELSE 0
	END AS FeePaid
, CONVERT(VARCHAR(150),NULL) AS IsManagedCare -- Use what is in PM_Pharmacy
, CONVERT(VARCHAR(150),NULL) AS IsWarehouse -- Use what is in PM_Pharmacy
, CONVERT(VARCHAR(150),NULL) AS IsNPP -- Use what is in PM_Pharmacy. Per LAC, this is used. Need more info.
, emailaddress2 AS ACHEmail 
, CONVERT(DATETIME, createdon) AS Created
, CONVERT(DATETIME, modifiedon) AS Modified
, 1 AS [RowVersion] 
, CONVERT(INT, CASE
				WHEN [new_aapmembershiptypename] = 'Entity' THEN 1
				WHEN [new_aapmembershiptypename] = 'Individual' THEN 0
				WHEN [new_aapmembershiptypename] = 'Satellite' THEN 2
				ELSE NULL
				END
		) AS MembershipType 
, CONVERT(INT, CASE
				WHEN new_org_typename LIKE '%Corporation%' THEN 1
				WHEN new_org_typename LIKE '%LLC%' THEN 2
				WHEN new_org_typename LIKE '%Partnership%' THEN 3
				WHEN new_org_typename LIKE '%Sole Proprietorship%' THEN 4
				WHEN new_org_typename LIKE '%Other-Government%' THEN 5
				ELSE NULL
				END
	) AS OrganizationType 
, CONVERT(VARCHAR(50), new_authorized_voter) AS AuthorizedVoter
, CONVERT(VARCHAR(200), owneridname) AS MembershipOwner -- Use what is in Dynamics. New rows use what is in CRM.
, CONVERT(VARCHAR(2), CASE 
						WHEN new_apiwarehousename = 'Scottsboro' THEN '1'
						WHEN new_apiwarehousename = 'Memphis' THEN '2'
						ELSE NULL
						END
						)  AS WHSNUM
, CONVERT(VARCHAR(150),NULL) AS PlansExcluded -- -Use what is in PM_Pharmacy. UD only.
, 0 AS IsClaimData --Use what is in PM_Pharmacy. Default value is 0. Per AA, UD only.
, 0 AS IsUPCData --Use what is in PM_Pharmacy. Default value is 0. Per AA, UD only.
, CONVERT(VARCHAR(150),NULL) AS MedicarePartBNo -- Per TH, no longer needed
, CONVERT(smallint, donotfax) AS DoNotFax 
, 'E' AS CommunicationPreference --Use what is in PM_Pharmacy or use default value of "email"
, CONVERT(VARCHAR(150),NULL) AS APIPaymentMode --Use what is in PM_Pharmacy
, CONVERT(VARCHAR(150),NULL) AS AAPPaymentMode --Use what is in PM_Pharmacy
, CONVERT(VARCHAR(50), new_ncpaid) AS NCPA 
, CONVERT(VARCHAR(150),NULL) AS OptOutNCPA -- Needs to be added to CRM. Use what is in PM_Pharmacy for now
, CONVERT(VARCHAR(150),NULL) AS ReasonNotEligibleNCPA -- Per TH, not needed
, versionnumber 
FROM ODSIntake.[Staging].[CRM_AccountEntity]





GO
