USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_test2]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE VIEW [dbo].[v_test2]
/* copy of v_test with rank_over to pick top PMID for duplicate NCPDPs 
-- v1_test is copy of v_pm_allwithaffiliates with extra fields added at bottom of select list
-- EmailAll, Contact (ContactAll), isMCorNPP, isMCnotNPP
-- BG 10/2014
-- added EmailAll for email|ACHemail|Executive email
-- added Contact for contactfullname|fincontact|membershipowner
*/
AS
SELECT dt.* 

from
(
SELECT DISTINCT 
                      p.PMID, p.PMParentID, p.AAPAccountNo, p.AAPEffectiveDate, p.AAPParentNo, p.AAPPreviousGroup, p.AAPQuitDate, p.AAPStatus, p.AccountDescription, p.AccountName, 
                      p.AllowDupDEA, p.APIAccountNo, p.APIMemberNo, p.APIStatus, p.AvgWholesaleVolume, p.BusinessClass, p.CAHStatus, p.CardinalDC, p.CompetitiveAcct, 
                      p.ComputerSoftware, p.ContractDate, p.CorporateName, p.CustPayTermsAPI, p.DateOpened, p.DBA, p.DEA, p.DEAEXP, p.Email, p.EmergencyPhone, p.FedID, 
                      p.HolidayHours, p.Hours, p.IsStartUpStore, p.NCPDP, p.NPI, p.NumReactivated, p.OrigStartDate, p.OwnerName, p.Payee_id, p.PrimaryCAAccountNo, p.QPS, p.Rank, 
                      p.Resigned, p.Source, p.Status, p.Territory, p.UDAccountNo, p.UDNonPharmacy, p.UDParentNo, p.UDQuitDate, p.UDStatus, p.Website, p.Wholesaler, 
                      p.WholesalerAccountNo, p.WhyResigned, p.IsBuyingGroup, p.IsPos, p.IsPva, p.FeePaid, p.IsManagedCare, p.IsWarehouse, p.IsNPP, p.ACHEmail, a.ContactFullName, 
                      p.Created, p.Modified, p.RowVersion, a.Addr1, a.Addr2, a.City, a.State, a.Zip, a.Phone, a.Fax, m.ChainCode, m.MCEffectiveDate, m.MCQuitDate, c.StateLicExpDate, 
                      c.StateLicNo, gx.Group_Name AS Affiliate, p.GroupNo, p.CategoryID, p.AuthorizedVoter, p.MembershipOwner
                      , dbo.PM_Territory.FirstName AS TMFirstName, dbo.PM_Territory.LastName AS TMLastName, dbo.PM_Territory.Territory AS TM
                      , dbo.PM_Territory.FirstName + ' ' + dbo.PM_Territory.LastName AS TMFullName
                      , af.FinAddr1, af.FinAddr2, af.FinCity, af.FinState, af.FinZip, af.fincontact, 
                      am.MailContact, am.MailAddr1, am.MailAddr2, am.MailCity, am.MailState, am.MailZip
                      
                      -- isActive:active AAP or API; ManagedCare isMCnotNPP, isMCorNPP, isMC (same as isMCnotNPP)
                      , CASE WHEN (AAPSTATUS = 'ACTIVE' OR APISTATUS IN ('ACTIVE', 'SUSPENDED')) THEN 1 ELSE 0 END AS isActive
                      , CASE WHEN (AAPAccountno is not null and AAPQuitdate is null) then 1 else 0 end as isAAP
                      , CASE WHEN (m.MCQuitDate IS NULL AND m.chaincode IS NOT NULL) AND 
                      (((p.AAPAccountno IS NOT NULL AND p.AAPAccountno <> '') AND p.AAPQuitdate IS NULL)) THEN 1 ELSE 0 END AS isMCnotNPP,
                      CASE WHEN ((m.MCQuitDate IS NULL AND m.chaincode IS NOT NULL) AND 
                      (((p.AAPAccountno IS NOT NULL AND p.AAPAccountno <> '') AND p.AAPQuitdate IS NULL)) 
                      OR (isNPP = -1 and m.MCQuitDate IS NULL))
                      THEN 1 ELSE 0 END AS isMCorNPP
                       , CASE WHEN ((m.MCQuitDate IS NULL AND m.chaincode IS NOT NULL) AND 
                      (((p.AAPAccountno IS NOT NULL AND p.AAPAccountno <> '') AND p.AAPQuitdate IS NULL)) 
                      OR (isNPP = -1 and m.MCQuitDate IS NULL))
                      THEN 1 ELSE 0 END AS isMC,    
                      
                      --programs
                          (SELECT     CASE WHEN COUNT(MemberPrograms.PMID) > 0 THEN 1 ELSE 0 END AS Expr1
                            FROM          dbo.PM_MemberPrograms AS MemberPrograms
                            WHERE      (ProgramID = 182) AND (EndDate IS NULL) AND (PMID = p.PMID)) AS IsAuditGuard,
                          (SELECT     CASE WHEN COUNT(MemberPrograms.PMID) > 0 THEN 1 ELSE 0 END AS Expr1
                            FROM          dbo.PM_MemberPrograms AS MemberPrograms
                            WHERE      (ProgramID = 184) AND (EndDate IS NULL) AND (PMID = p.PMID)) AS IsAAPElite, 
                      CASE WHEN ComputerSoftware LIKE 'Rx3%' THEN 1 ELSE 0 END AS IsRx30
                      
                      --emailAll: if not null else achemail else executive
                      ,case when email is null then 
						case when achemail is null then aexec.ExecutiveEmail else achemail end 
						else email end as EmailAll
						
                      ,p.communicationpreference
                      
                      --- Contact use contactfullname or fincontact or membershipowner
                      ,case when a.ContactFullName is null then
						case when af.fincontact is null then p.MembershipOwner else af.fincontact end
						else a.ContactFullName end as Contact
						
					  --- if duplicate PMIDs for NCPDP, take higher PMID
                      ,rank() over (partition by p.ncpdp order by p.[pmid] desc) as [pmidrank]
					  --,ExecAddr1,ExecAddr2,ExecCity,ExecState,ExecZip,ExecContact
FROM         dbo.PM_Pharmacy AS p LEFT OUTER JOIN
                      dbo.PM_Territory ON p.Territory = dbo.PM_Territory.Territory LEFT OUTER JOIN
                          (SELECT     g.Group_Name, g.AffiliateID, x.PMID
                            FROM          dbo.PM_Groups_xref AS x INNER JOIN
                                                   dbo.PM_Groups AS g ON x.Group_ID = g.Group_ID
                            WHERE      (g.AffiliateID IS NOT NULL)) AS gx ON p.PMID = gx.PMID LEFT OUTER JOIN
                          (SELECT     PMID, Address AS Addr1, Address2 AS Addr2, ContactFullName, City, State, Zip, Phone, Fax
                            FROM          dbo.PM_AddressMaster
                            WHERE      (Address_Type_Id = 1)) AS a ON p.PMID = a.PMID LEFT OUTER JOIN
                          (SELECT     PMID, Address AS FinAddr1, Address2 AS FinAddr2, City AS FinCity, State AS FinState, Zip AS FinZip, ContactFullName AS fincontact
                            FROM          dbo.PM_AddressMaster AS PM_AddressMaster_2
                            WHERE      (Address_Type_Id = 3)) AS af ON p.PMID = af.PMID LEFT OUTER JOIN
                          (SELECT     PMID, Address AS MailAddr1, Address2 AS MailAddr2, City AS MailCity, State AS MailState, Zip AS MailZip, ContactFullName AS MailContact
                            FROM          dbo.PM_AddressMaster AS PM_AddressMaster_1
                            WHERE      (Address_Type_Id = 2)) AS am ON p.PMID = am.PMID LEFT OUTER JOIN
                            
                          (SELECT     PMID, Email as ExecutiveEmail,Address AS ExecAddr1,Address2 AS ExecAddr2,City AS ExecCity, State AS ExecState, Zip AS ExecZip, ContactFullName AS ExecContact
                            FROM          dbo.PM_AddressMaster AS PM_AddressMaster_Exec
                            WHERE      (Address_Type_Id = 9)) AS aexec ON p.PMID = aexec.PMID LEFT OUTER JOIN
                            
                          (SELECT     ChainCode, MCEffectiveDate, MCQuitDate, PMID
                            FROM          dbo.PM_ManagedCare) AS m ON p.PMID = m.PMID LEFT OUTER JOIN
                          (SELECT     StateLicExpDate, StateLicNo, PMID
                            FROM          dbo.PM_Cred) AS c ON p.PMID = c.PMID

) DT
WHERE pmidrank=1 or ncpdp is null or PMID=100364





GO
