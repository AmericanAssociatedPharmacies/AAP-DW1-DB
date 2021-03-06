USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_SSIS_PM_AllWithAffiliates]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_SSIS_PM_AllWithAffiliates]
AS
SELECT     p.PMID, p.PMParentID, p.AAPAccountNo,  CONVERT(VARCHAR(10), p.AAPEffectiveDate, 101) as AAPEffectiveDate, p.AAPParentNo, p.AAPPreviousGroup, CONVERT(VARCHAR(10), p.AAPQuitDate, 101) as AAPQuitDate,
                      p.AAPStatus, p.AccountDescription, 
                      p.AccountName, p.AllowDupDEA, p.APIAccountNo, p.APIMemberNo, p.APIStatus, p.AvgWholesaleVolume, p.BusinessClass, p.CAHStatus, p.CardinalDC, 
                      p.CompetitiveAcct, p.ComputerSoftware, CONVERT(VARCHAR(10),p.ContractDate , 101) as ContractDate, p.CorporateName, p.CustPayTermsAPI, CONVERT(VARCHAR(10),p.DateOpened , 101) as DateOpened, p.DBA,p.DEA,  CONVERT(VARCHAR(10),p.DEAEXP , 101) as DEAEXP, p.Email, 
                      p.EmergencyPhone, p.FedID, p.HolidayHours, p.Hours, p.IsStartUpStore, p.NCPDP, p.NPI, p.NumReactivated, CONVERT(VARCHAR(10),p.OrigStartDate  , 101) as OrigStartDate, p.OwnerName, 
                      p.Payee_id, p.PrimaryCAAccountNo, p.QPS, p.Rank, p.Resigned, p.Source, p.Status, p.Territory, p.UDAccountNo, p.UDNonPharmacy, p.UDParentNo, 
                      CONVERT(VARCHAR(10),p.UDQuitDate , 101) as UDQuitDate, p.UDStatus, p.Website, p.Wholesaler, p.WholesalerAccountNo, p.WhyResigned, p.IsBuyingGroup, p.IsPos, p.IsPva, p.FeePaid, 
                      p.IsManagedCare, p.IsWarehouse, p.IsNPP, p.ACHEmail, a.ContactFullName , p.Created, p.Modified , 
                      p.RowVersion , a.Addr1, a.Addr2 ,   a.City, a.State, a.Zip, 
                      a.Phone, a.Fax , m.ChainCode,  CONVERT(VARCHAR(10),m.MCEffectiveDate, 101) as MCEffectiveDate, CONVERT(VARCHAR(10),m.MCQuitDate, 101) as MCQuitDate,
                      CONVERT(VARCHAR(10),c.StateLicExpDate , 101) as StateLicExpDate, c.StateLicNo , gx.Group_Name as Affiliate, CONVERT(VARCHAR(10),pm.[AAP Elite StartDate], 101) as [AAP Elite StartDate],CONVERT(VARCHAR(10),pm.[AAP Elite EndDate], 101) as [AAP Elite EndDate],p.GroupNo, p.AuthorizedVoter
FROM         dbo.PM_Pharmacy AS p LEFT OUTER JOIN
                          (SELECT     g.Group_Name, g.AffiliateID, x.PMID
                            FROM          dbo.PM_Groups_xref AS x INNER JOIN
                                                   dbo.PM_Groups AS g ON x.Group_ID = g.Group_ID
                            WHERE      (g.AffiliateID IS NOT NULL)) AS gx ON p.PMID = gx.PMID LEFT OUTER JOIN
                          (SELECT     PMID, Address AS Addr1, Address2 AS Addr2, ContactFullName, City, State, Zip, Phone, Fax
                            FROM          dbo.PM_AddressMaster
                            WHERE      (Address_Type_Id = 1)) AS a ON p.PMID = a.PMID LEFT OUTER JOIN
                          (SELECT     ChainCode, MCEffectiveDate, MCQuitDate, PMID
                            FROM          dbo.PM_ManagedCare) AS m ON p.PMID = m.PMID LEFT OUTER JOIN
                          (SELECT     StateLicExpDate, StateLicNo, PMID
                            FROM          dbo.PM_Cred) AS c ON p.PMID = c.PMID LEFT OUTER JOIN
						  (SELECT PMID,CONVERT(VARCHAR(10), startdate, 101) as [AAP Elite StartDate],CONVERT(VARCHAR(10), endDate, 101) as [AAP Elite EndDate] from pharmacymaster..pm_memberprograms 
							where programid = 184
							) pm
							on p.PMID = pm.PMID


GO
