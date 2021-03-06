USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vwPharmacyDim]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwPharmacyDim]

AS


SELECT ISNULL(v.PMID, p.PMID) AS PMID
, AAPAccountNo AS AAPNumber
, ISNULL(v.AAPEffectiveDate, p.AAPEffectiveDate) AS AAPEffectiveDate
, AAPParentNo AS AAPParent
, ISNULL(v.AAPQuitDate, p.AAPQuitDate) AS AAPQuitDate
, AAPStatus AS AAPStatusName
, AccountName AS Name
, ISNULL(v.APIAccountNo, p.APIAccountNo) AS APINumber
, APIStatus AS APIStatusName
, CAHStatus AS CAH_PVA_Statusname
, CorporateName
, DEA AS DEA_HIN 
, DEAEXP AS DEA_HINExpiration
, Email AS GeneralEmail
, FedID AS FederalTaxID
, GroupNo  AS GroupNumber
, NCPDP 
, NPI
, OwnerName AS PharmacyOwnerLookupName
--, [Status] AS AAPStatusName
, Territory AS TerritoriesName
, Website 
, Wholesaler AS PrimaryWholesalerNewName
, WhyResigned AS AAPResignationReasonname
, ACHEmail AS FinancialEmail
, AuthorizedVoter AS IATV
, MembershipOwner AS OwnerIDName
, DoNotFax AS DonotallowFaxes
, NCPA AS NCPAID
FROM [dbo].[v_APItoPMID_LifeTime] AS v
FULL OUTER JOIN dbo.PM_Pharmacy AS p ON v.PMID = p.PMID
WHERE NOT EXISTS(SELECT 1
					FROM RXMaster.dbo.PharmacyDim AS pd
					WHERE p.PMID = pd.PMID
				 )
GO
