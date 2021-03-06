USE [DynamicsODS]
GO
/****** Object:  View [Staging].[vw_PM_Pharmacy_DB1]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [Staging].[vw_PM_Pharmacy_DB1]

AS

SELECT dt.PMID
, PMParentID
, AAPAccountNo
, AAPEffectiveDate
, AAPParentNo
, AAPPreviousGroup
, AAPQuitDate
, AAPStatus
, AccountDescription
, AccountName
, AllowDupDEA
, APIAccountNo
, APIDEA
, APIMemberNo
, APIPMID
, APIStatus
, AvgWholesaleVolume
, BusinessClass
, CAHStatus
, CardinalDC
, CategoryID
, CompetitiveAcct
, ComputerSoftware
, ContractDate
, CorporateName
, CustPayTermsAPI
, DateOpened
, DBA
, DEA
, DEAEXP
, Email
, EmergencyPhone
, EstMonthlyVol
, FedID
, GroupNo
, HolidayHours
, Hours
, IsHighVolume
, StoreHours_HolidayAM
, StoreHours_HolidayPM
, StoreHours_MondayFridayAM
, StoreHours_MondayFridayPM
, StoreHours_SaturdayAM
, StoreHours_SaturdayPM
, StoreHours_SundayAM
, StoreHours_SundayPM
, IsStartUpStore
, NCPDP
, NPI
, NumReactivated
, OrigStartDate
, OwnerName
, Payee_id
, PrimaryCAAccountNo
, PrimaryWholesaler
, QPS
, Rank
, Resigned
, Source
, Status
, Territory
, UDAccountNo
, UDNonPharmacy
, UDParentNo
, UDQuitDate
, UDStatus
, Website
, Wholesaler
, WholesalerAccountNo
, WhyResigned
, IsBuyingGroup
, IsPos
, IsPva
, FeePaid
, IsManagedCare
, IsWarehouse
, IsNPP
, ACHEmail
, Created
, Modified
, RowVersion
, MembershipType
, OrganizationType
, AuthorizedVoter
, MembershipOwner
, WHSNUM
, PlansExcluded
, IsClaimData
, IsUPCData
, MedicarePartBNo
, DoNotFax
, CommunicationPreference
, APIPaymentMode
, AAPPaymentMode
, NCPA
, OptOutNCPA
, ReasonNotEligibleNCPA
, StatusCodeName
, TMEmailAddress
FROM(SELECT CONVERT(INT, new_pmid) AS PMID
	, NULL AS PMParentID
	, CONVERT(VARCHAR(20), new_aap_account) AS AAPAccountNo
	, CONVERT(DATETIME, new_aap_effective_date) AS AAPEffectiveDate
	, CONVERT(VARCHAR(20), new_aapparent) AS AAPParentNo
	, NULL AS AAPPreviousGroup -- Not needed per Wayne.Use what is in PM_Pharmacy
	, CONVERT(DATETIME, new_aapquit) AS AAPQuitDate
	, CONVERT(VARCHAR(32), Case 
							WHEN new_aapstatusname = 'TERMINATED' THEN 'INACTIVE'
							WHEN new_aapstatusname = 'PENDING TERMINATION' THEN 'ACTIVE'
							WHEN new_aapstatusname = 'ACTIVE' THEN 'ACTIVE'
							ELSE NULL
							END
							) AS AAPStatus
	 , CONVERT (VARCHAR (200), CASE                                                  
								WHEN s.statuscodename = 'AAP Member' THEN 'Full Member'
                                WHEN s.statuscodename = 'Affiliate Group Member' THEN 'Affiliate Group Member'
                                WHEN s.statuscodename = 'Affiliate Group Pharmacy' THEN 'Affiliate Group Pharmacy'
                                WHEN s.statuscodename = 'Corporate Office' THEN 'Corporate Office'
                                WHEN s.statuscodename = 'Customer' THEN 'Customer'
                                WHEN s.statuscodename LIKE LTRIM(RTRIM(CONVERT(VARCHAR(100),'%Sold%'))) THEN 'Store Resigned'
								WHEN s.statuscodename = 'Arete Only' THEN 'UD NPP Store'
								WHEN s.statuscodename = 'Participant-PVA' THEN 'Participant-PVA'
                                WHEN s.statuscodename = 'Distributor' THEN 'Distributor'
                                WHEN s.statuscodename = 'Physician Group' THEN 'Physician Group'
								WHEN s.statuscodename LIKE LTRIM(RTRIM(CONVERT(VARCHAR(100),'%Prospect%'))) THEN 'Store Resigned'
                                ELSE NULL
                                END
                                ) AS AccountDescription--Have mapping but only 1 PMID has the new_account_subtypename field filled. Will use what is in PharmacyMaster for now.
	--WHEN s.statuscodename LIKE LTRIM(RTRIM(CONVERT(VARCHAR(100), 'AAP%'))) THEN 'Full Member'
	--WHEN s.statuscodename LIKE LTRIM(RTRIM(CONVERT(VARCHAR(100), 'Arete'))) THEN 'UD NPP Store'
	--WHEN s.statuscodename LIKE LTRIM(RTRIM(CONVERT(VARCHAR(100), 'Participant%'))) THEN 'Participant-PVA'
	, CONVERT(VARCHAR(65), s.name) AS AccountName
	, NULL AS AllowDupDEA -- Per notes from TH, no longer needed per Linda J.
	, CONVERT(VARCHAR(20), a.[new_api_account]) AS APIAccountNo
	, NULL AS APIDEA
	, NULL AS APIMemberNo --Per Andrea, not being used. 
	, CONVERT(INT, new_pmid) AS APIPMID
	, CONVERT(VARCHAR(32) , a.new_apistatusname) AS APIStatus
	, NULL AS AvgWholesaleVolume --Per TH, not needed. Keep whats in PM_Phamrmacy
	, CONVERT(VARCHAR(4), LEFT(new_businessclassname, 3)) AS BusinessClass
	, CONVERT(VARCHAR(32) , c.new_cahpvastatusname) AS CAHStatus
	, NULL AS CardinalDC -- Per TH, data not current in PM_Pharmacy
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
	, NULL AS CompetitiveAcct --Per notes from TH, per Wayne no longer used.
	, CONVERT(VARCHAR(255), new_computer_softwarename) AS ComputerSoftware
	, CONVERT(DATETIME, c.new_cahpvacontractdate) AS ContractDate
	, CONVERT(VARCHAR(100), new_corporatename) AS CorporateName
	, CONVERT(VARCHAR(20), 
							CASE
							WHEN a.[new_api_termsname] = 'Standard' THEN 'DAY'
							WHEN a.[new_api_termsname] = 'ACH - 2 day/ROG' THEN 'ROG'
							WHEN a.[new_api_termsname] = 'ACH - 10 day' THEN 'A10'
							WHEN a.[new_api_termsname] = 'ACH - Weekly' THEN 'ATA'
							WHEN a.[new_api_termsname] = 'Prepay' THEN 'Prepay'
							ELSE NULL
							END
							) AS CustPayTermsAPI -- Will only use values from CRM for any new rows. 
	, new_apiaccountactivation AS DateOpened -- Per TH, date should be added in CRM by mid-May
	, CONVERT(VARCHAR(65), s.name)  AS DBA
	, CONVERT(VARCHAR(50), new_dea) AS DEA
	, CONVERT(DATETIME, new_deaexpiration) AS DEAEXP
	, CONVERT(VARCHAR(255), ad.emailaddress1) AS Email
	, CONVERT(VARCHAR(15), s.telephone1) AS EmergencyPhone
	, NULL AS EstMonthlyVol --Per LAC, not used.
	, CONVERT(VARCHAR(12), new_fed_tax) AS FedID
	, CONVERT(VARCHAR(20), new_group) AS GroupNo 
	, CONVERT(VARCHAR(100), ('M-F ' + new_hours_weekdays_open + ' - ' + new_hours_weekdays_close) + ISNULL((', SAT ' + new_hours_saturday_open + ' - ' + new_hours_saturday_close + ', SUN ' + new_hours_sunday_open + ' - ' + new_hours_sunday_close), ''))  AS [Hours]
	, NULL AS IsHighVolume
	, NULL AS [StoreHours_HolidayAM]
	, NULL AS [StoreHours_HolidayPM]
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
	, NULL AS [OrigStartDate] -- Per LAC, not used. Per notes from TH, per Linda J not being used.
	, CONVERT(VARCHAR(200), new_pharmacyownerlookupname) AS OwnerName
	, NULL AS Payee_id -- Use what is PM_Pharmacy. All new rows leave NULL
	, CONVERT (VARCHAR(32), new_cah_account) AS [PrimaryCAAccountNo] -- Use what is PM_Pharmacy. All new rows leave NULL
	, NULL AS PrimaryWholesaler --CONVERT(VARCHAR(25), new_primarywholesalernewname) AS PrimaryWholesaler -- Use what is PM_Pharmacy. All new rows leave NULL
	, NULL AS QPS -- Per notes from TH, per Wayne not being used.
	, NULL AS Rank -- Use what is PM_Pharmacy. All new rows leave NULL
	, NULL AS Resigned -- Per Wayne, not needed.
	, NULL AS Source -- Per notes from TH, per Linda J not being used anymore. This was a United Drugs only column.
	, NULL AS [Status]
	, CONVERT(VARCHAR(4), new_territoriesname) AS Territory
	 , NULL AS [UDAccountNo] -- Use what is in PM_Pharmacy
	 , NULL [UDNonPharmacy] -- Use what is in PM_Pharmacy
	 , NULL [UDParentNo] -- Use what is in PM_Pharmacy
	 , NULL [UDQuitDate] -- Use what is in PM_Pharmacy
	 , NULL AS UDStatus -- Use what is in PM_Pharmacy
	, CONVERT(VARCHAR(100), s.websiteurl) AS Website
	, CONVERT(VARCHAR(25), new_primarywholesalernewname) AS Wholesaler -- 04/22/2019 Need Tracie to tell source for this column
	, NULL AS [WholesalerAccountNo] -- Per Wayne, not used
	, CONVERT(VARCHAR(255), new_aap_resignation_reasonname) AS [WhyResigned]
	, CONVERT(SMALLINT, 0) AS [IsBuyingGroup]
	, CONVERT(SMALLINT, 0) AS [IsPos]
	, CASE 
		WHEN new_primarywholesalernew LIKE '%Cardinal%' THEN -1
		ELSE 0
		END AS IsPVA --Per Wayne's email on 05/08/2018, not needed. But, after discussion and discovery, column is being used in compliance report and is needed.
	, CASE	
		WHEN new_fee_paidname = 'Yes' THEN 1
		ELSE 0
		END AS FeePaid
	, NULL AS IsManagedCare -- Use what is in PM_Pharmacy
	, NULL AS IsWarehouse -- Use what is in PM_Pharmacy
	, NULL AS IsNPP -- Use what is in PM_Pharmacy. Per LAC, this is used. Need more info.
	, CONVERT(VARCHAR(255), ad.emailaddress2) AS ACHEmail 
	, CONVERT(DATETIME, s.createdon) AS Created
	, CONVERT(DATETIME, s.modifiedon) AS Modified
	, 1 AS [RowVersion] 
	, CONVERT(INT, CASE
                    WHEN [new_ownertypename] LIKE '%Individual%' THEN '1'
                    WHEN [new_ownertypename] LIKE '%Entity%' THEN '2'
                    WHEN [new_ownertypename] = NULL THEN '0'
                    END
            ) AS MembershipType
	, CONVERT(INT, CASE
					WHEN new_org_typename LIKE '%Corporation%' THEN 1
					WHEN new_org_typename LIKE '%LLC%' THEN 2
					WHEN new_org_typename LIKE '%Partnership%' THEN 3
					WHEN new_org_typename LIKE '%Sole Proprietorship%' THEN 4
					WHEN new_org_typename LIKE '%Other-Government%' THEN 5
					WHEN new_org_typename LIKE '%C-Corporation%' THEN 6
                    WHEN new_org_typename LIKE '%S-Corporation%' THEN 7
                    WHEN new_org_typename LIKE '%Other-Non Government%' THEN 8
                    ELSE NULL
					END
		) AS OrganizationType 
	, CONVERT(NVARCHAR(50), new_authorized_voter) AS AuthorizedVoter
	, CONVERT(VARCHAR(200), u.new_membershipowner) AS MembershipOwner -- Use what is in Dynamics. New rows use what is in CRM. Per Tracie email request on 04/22/2019 we changed owneridname column to new_membershipowner
	, CONVERT(VARCHAR(2), CASE 
							WHEN a.new_apiwarehousename = 'Scottsboro' THEN '1'
							WHEN a.new_apiwarehousename = 'Memphis' THEN '2'
							ELSE NULL
							END
							)  AS WHSNUM
	, NULL AS PlansExcluded -- -Use what is in PM_Pharmacy. UD only.
	, 0 AS IsClaimData --Use what is in PM_Pharmacy. Default value is 0. Per AA, UD only.
	, 0 AS IsUPCData --Use what is in PM_Pharmacy. Default value is 0. Per AA, UD only.
	, NULL AS MedicarePartBNo -- Per TH, no longer needed
	, CONVERT(smallint, s.donotfax) AS DoNotFax 
	, 'E' AS CommunicationPreference --Use what is in PM_Pharmacy or use default value of "email"
	, NULL AS APIPaymentMode --Use what is in PM_Pharmacy
	, NULL AS AAPPaymentMode --Use what is in PM_Pharmacy
	, CONVERT(VARCHAR(50), new_ncpaid) AS NCPA 
	, NULL AS OptOutNCPA -- Needs to be added to CRM. Use what is in PM_Pharmacy for now
	, NULL AS ReasonNotEligibleNCPA -- Per TH, not needed
	, s.versionnumber 
	, s.[statuscodename] 
	, NULL AS HolidayHours
	, TRY_CONVERT(VARCHAR(250), RTRIM(LTRIM(r.internalemailaddress))) AS TMEmailAddress
	FROM [DynamicsODS].[dbo].[CRM_AccountEntity_User] AS u
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_Sys] AS s ON u.accountid = s.accountid
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_API] AS a ON u.accountid = a.accountid
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_CAH] AS c ON u.accountid = c.accountid
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_Address] AS ad ON u.accountid = ad.accountid
	LEFT OUTER JOIN DynamicsODS.[dbo].[CRM_UserEntity] AS r ON r.systemuserid = s.ownerid
	WHERE new_PMID IS NOT NULL
	--AND s.[statuscodename] <> 'Prospect' --RSE: Per TH on 05/03/2019, will need "Prospect" when a Pharmacy already exist in PM
	) AS dt















GO
