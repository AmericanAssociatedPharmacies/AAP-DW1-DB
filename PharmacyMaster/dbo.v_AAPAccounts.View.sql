USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_AAPAccounts]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_AAPAccounts]
AS
SELECT     TOP (100) PERCENT p.CorporateName AS CorpName, p.AccountName AS storename, p.AAPAccountNo AS aapid, p.AAPParentNo AS parentaapid, 
                      am.Address AS addr1, am.Address2 AS addr2, am.City, am.State, am.Zip, SUBSTRING(am.Phone, 1, 3) AS AreaCode, SUBSTRING(am.Phone, 5, 8) 
                      AS phone, SUBSTRING(am.Fax, 1, 3) AS FaxAreaCode, SUBSTRING(am.Fax, 5, 8) AS fax, p.Territory AS nsterritory, p.FeePaid, a.NppMbr, p.DEA, 
                      p.DEAEXP, p.NCPDP, p.NPI, mc.ArgusAgree, p.CompetitiveAcct, p.Email, a.GroupDesignation, a.IsMember, a.IsAffiliateGroup, p.IsBuyingGroup, 
                      p.IsNPP, p.IsWarehouse, p.IsPva, p.IsPos, dbo.PMListGroupNames(p.PMID) AS AffiliateGroupName, am.County, SUBSTRING(p.OwnerName, 1, 
                      CHARINDEX(' ', p.OwnerName)) AS ownerfirst, dbo.PMGetOwnerLastName(p.OwnerName) AS ownerlast, a.Effective, p.AvgWholesaleVolume, 
                      p.AAPEffectiveDate AS effectiveaap, p.IsStartUpStore, a.IsPharmacy, mc.ChainCode, p.FedID, p.AAPPreviousGroup, a.SwitchedFrom, 
                      p.UDQuitDate AS quitdate, a.PreviousAcctNo, a.APIPreviousAcctNo, p.WholesalerAccountNo AS apiwarehouseacctno, a.Bulletin, a.TS, c.StateLicNo, 
                      c.StateMedicaidNo, c.StateLicExpDate, p.Payee_id, p.EmergencyPhone, 'M-F: ' + ISNULL(p.StoreHours_MondayFridayAM, 'No ') 
                      + 'AM-' + ISNULL(p.StoreHours_MondayFridayPM, 'No ') + 'PM, SAT: ' + ISNULL(p.StoreHours_SaturdayAM, 'No ') 
                      + 'AM-' + ISNULL(p.StoreHours_SaturdayPM, 'No ') + 'PM' + CASE WHEN P.STOREHOURS_SUNDAYAM IS NULL 
                      THEN '' ELSE ', SUN: ' + ISNULL(P.STOREHOURS_SUNDAYAM, 'No ') + 'AM-' + ISNULL(P.STOREHOURS_SUNDAYPM, 'No ') + 'PM' END AS Hours, 
                      p.HolidayHours, c.GenLiabCarrier, c.GenLiabPolicyNumber, c.GenLiabilityLimit1, c.GenLiabilityLimit2, c.GenInsExpDate, c.ProfLiabCarrier, 
                      c.ProfLiabInsExpDate, c.ProfPolicyNumber, c.ProfLiabLimit1, c.ProfLiabLimit2, c.DeliveryService, c.EmergencyServices, 
                      c.AnsweringServiceOrMachine, c.AlternativeLanguages, c.SpecialtyServices, p.ComputerSoftware, c.Obra90, c.CounselingArea, c.PatientMR, 
                      c.DrugInformation, c.FraudFelonyConviction, c.FraudFelonyExplanation, c.RxLicenseSuspendedOrRevoked, c.SuspensionRevokationExplanation, 
                      c.UnrestrictedLicense, c.UnrestrictedLicenseExplanation, c.UAICoverage, c.Judgements, c.CompliesWithADAAct, c.AverageWaitTime, 
                      c.MedicationErrorsDocumented, c.ErrorCount12Months, c.HasResolutionPolicy, c.doesCompoundPrescriptions, c.UnitDosing, c.ProvidesDME, 
                      c.ProvidesIV, c.CertifiedDiseaseMgmt, c.CDMExplanation, c.GroupPresentations, c.ContinuingEducationRequired, c.StoreSizeClassification, 
                      c.CopyReleaseInfo, p.DBA, p.Website, p.Resigned, a.ContactFirst, a.ContactLast, a.ContactTitle, p.WhyResigned, p.AccountDescription, 
                      mc.MCEffectiveDate, mc.MCQuitDate, p.PMID, p.QPS, p.AAPQuitDate, p.APIAccountNo
FROM         dbo.PM_Pharmacy AS p LEFT OUTER JOIN
                      dbo.PM_ManagedCare AS mc ON mc.PMID = p.PMID LEFT OUTER JOIN
                      AAP.dbo.AAPAccount AS a ON a.AAPID = p.AAPAccountNo LEFT OUTER JOIN
                      dbo.PM_AddressMaster AS am ON am.PMID = p.PMID AND am.Address_Type_Id = 1 LEFT OUTER JOIN
                      dbo.PM_Cred AS c ON c.PMID = p.PMID
WHERE     (p.AAPAccountNo IS NOT NULL)
ORDER BY a.AccountID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[24] 2[22] 3) )"
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
               Top = 27
               Left = 22
               Bottom = 372
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "mc"
            Begin Extent = 
               Top = 50
               Left = 667
               Bottom = 165
               Right = 833
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 329
               Left = 465
               Bottom = 444
               Right = 710
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "am"
            Begin Extent = 
               Top = 178
               Left = 861
               Bottom = 293
               Right = 1032
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 889
               Bottom = 121
               Right = 1134
            End
            DisplayFlags = 280
            TopColumn = 47
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 116
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Widt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_AAPAccounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'h = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3765
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2430
         Alias = 2235
         Table = 1710
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_AAPAccounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_AAPAccounts'
GO
