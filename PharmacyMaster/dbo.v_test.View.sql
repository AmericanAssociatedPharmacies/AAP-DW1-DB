USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_test]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_test]
AS
SELECT DISTINCT 
                         p.PMID, p.PMParentID, p.AAPAccountNo, p.AAPEffectiveDate, p.AAPParentNo, p.AAPPreviousGroup, p.AAPQuitDate, p.AAPStatus, p.AccountDescription, 
                         p.AccountName, p.AllowDupDEA, p.APIAccountNo, p.APIMemberNo, p.APIStatus, p.AvgWholesaleVolume, p.BusinessClass, p.CAHStatus, p.CardinalDC, 
                         p.CompetitiveAcct, p.ComputerSoftware, p.ContractDate, p.CorporateName, p.CustPayTermsAPI, p.DateOpened, p.DBA, p.DEA, p.DEAEXP, p.Email, 
                         p.EmergencyPhone, p.FedID, p.HolidayHours, p.Hours, p.IsStartUpStore, p.NCPDP, p.NPI, p.NumReactivated, p.OrigStartDate, p.OwnerName, p.Payee_id, 
                         p.PrimaryCAAccountNo, p.QPS, p.Rank, p.Resigned, p.Source, p.Status, p.Territory, p.UDAccountNo, p.UDNonPharmacy, p.UDParentNo, p.UDQuitDate, p.UDStatus, 
                         p.Website, p.Wholesaler, p.WholesalerAccountNo, p.WhyResigned, p.IsBuyingGroup, p.IsPos, p.IsPva, p.FeePaid, p.IsManagedCare, p.IsWarehouse, p.IsNPP, 
                         p.ACHEmail, a.ContactFullName, p.Created, p.Modified, p.RowVersion, a.Addr1, a.Addr2, a.City, a.State, a.Zip, a.Phone, a.Fax, m.ChainCode, m.MCEffectiveDate, 
                         m.MCQuitDate, c.StateLicExpDate, c.StateLicNo, gx.Group_Name AS Affiliate, p.GroupNo, p.CategoryID, p.AuthorizedVoter, p.MembershipOwner, 
                         dbo.PM_Territory.FirstName AS TMFirstName, dbo.PM_Territory.LastName AS TMLastName, dbo.PM_Territory.Territory AS TM, af.FinAddr1, af.FinAddr2, af.FinCity, 
                         af.FinState, af.FinZip, af.fincontact, am.MailContact, am.MailAddr1, am.MailAddr2, am.MailCity, am.MailState, am.MailZip, CASE WHEN (p.AAPAccountno IS NOT NULL 
                         AND p.AAPAccountno <> '' AND p.AAPQuitdate IS NULL) OR
                         APISTATUS IN ('ACTIVE', 'SUSPENDED') OR
                         (isNPP <> 0 AND mcquitdate IS NULL) THEN 1 ELSE 0 END AS isActive, CASE WHEN (m.MCQuitDate IS NULL AND m.chaincode IS NOT NULL) AND 
                         (((p.AAPAccountno IS NOT NULL AND p.AAPAccountno <> '') AND p.AAPQuitdate IS NULL)) THEN 1 ELSE 0 END AS isMCnotNPP, CASE WHEN (m.MCQuitDate IS NULL 
                         AND m.chaincode IS NOT NULL) AND (((p.AAPAccountno IS NOT NULL AND p.AAPAccountno <> '') AND p.AAPQuitdate IS NULL)) OR
                         (isNPP <> 0 AND mcquitdate IS NULL) THEN 1 ELSE 0 END AS isMCorNPP,
                             (SELECT        CASE WHEN COUNT(MemberPrograms.PMID) > 0 THEN 1 ELSE 0 END AS Expr1
                               FROM            dbo.PM_MemberPrograms AS MemberPrograms
                               WHERE        (ProgramID = 182) AND (EndDate IS NULL) AND (PMID = p.PMID)) AS IsAuditGuard,
                             (SELECT        CASE WHEN COUNT(MemberPrograms.PMID) > 0 THEN 1 ELSE 0 END AS Expr1
                               FROM            dbo.PM_MemberPrograms AS MemberPrograms
                               WHERE        (ProgramID = 184) AND (EndDate IS NULL) AND (PMID = p.PMID)) AS IsAAPElite, 
                         CASE WHEN ComputerSoftware LIKE 'Rx3%' THEN 1 ELSE 0 END AS IsRx30, p.CommunicationPreference, CASE WHEN (p.AAPAccountno IS NOT NULL AND 
                         p.AAPAccountno <> '' AND p.AAPQuitdate IS NULL) THEN 1 ELSE 0 END AS isAAP
                         ,ExecMailAddr1,ExecMailAddr2,ExecMailCity,ExecMailState,ExecMailContact,ExecEmail
FROM            dbo.PM_Pharmacy AS p LEFT OUTER JOIN
                         dbo.PM_Territory ON p.Territory = dbo.PM_Territory.Territory LEFT OUTER JOIN
                             (SELECT        g.Group_Name, g.AffiliateID, x.PMID
                               FROM            dbo.PM_Groups_xref AS x INNER JOIN
                                                         dbo.PM_Groups AS g ON x.Group_ID = g.Group_ID
                               WHERE        (g.AffiliateID IS NOT NULL)) AS gx ON p.PMID = gx.PMID LEFT OUTER JOIN
                             (SELECT        PMID, Address AS Addr1, Address2 AS Addr2, ContactFullName, City, State, Zip, Phone, Fax
                               FROM            dbo.PM_AddressMaster
                               WHERE        (Address_Type_Id = 1)) AS a ON p.PMID = a.PMID LEFT OUTER JOIN
                             (SELECT        PMID, Address AS FinAddr1, Address2 AS FinAddr2, City AS FinCity, State AS FinState, Zip AS FinZip, ContactFullName AS fincontact
                               FROM            dbo.PM_AddressMaster AS PM_AddressMaster_2
                               WHERE        (Address_Type_Id = 3)) AS af ON p.PMID = af.PMID LEFT OUTER JOIN
                             (SELECT        PMID, Address AS MailAddr1, Address2 AS MailAddr2, City AS MailCity, State AS MailState, Zip AS MailZip, ContactFullName AS MailContact
                               FROM            dbo.PM_AddressMaster AS PM_AddressMaster_1
                               WHERE        (Address_Type_Id = 2)) AS am ON p.PMID = am.PMID LEFT OUTER JOIN
                             (SELECT        ChainCode, MCEffectiveDate, MCQuitDate, PMID
                               FROM            dbo.PM_ManagedCare) AS m ON p.PMID = m.PMID LEFT OUTER JOIN
                             (SELECT        StateLicExpDate, StateLicNo, PMID
                               FROM            dbo.PM_Cred) AS c ON p.PMID = c.PMID
								LEFT OUTER JOIN
                             (SELECT        PMID, Address AS ExecMailAddr1, Address2 AS ExecMailAddr2, City AS ExecMailCity, State AS ExecMailState, Zip AS ExecMailZip
												, ContactFullName AS ExecMailContact
												,email as ExecEmail
                               FROM            dbo.PM_AddressMaster AS PM_AddressMaster_1
                               WHERE        (Address_Type_Id = 9)) AS em ON p.PMID = em.PMID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[40] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PM_Territory"
            Begin Extent = 
               Top = 6
               Left = 308
               Bottom = 125
               Right = 468
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gx"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 230
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 126
               Left = 236
               Bottom = 245
               Right = 406
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "af"
            Begin Extent = 
               Top = 6
               Left = 506
               Bottom = 125
               Right = 666
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "am"
            Begin Extent = 
               Top = 6
               Left = 704
               Bottom = 125
               Right = 864
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 354
               Left = 38
               Bottom = 473
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_test'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     End
         Begin Table = "c"
            Begin Extent = 
               Top = 366
               Left = 246
               Bottom = 470
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 19080
         Alias = 3120
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_test'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_test'
GO
