USE [WebDev]
GO
/****** Object:  View [dbo].[v_CA_StoreCredentialingStatus]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_CA_StoreCredentialingStatus]
AS
SELECT        s.PMID, s.NCPDP, s.AAPAccountNo, s.OwnerName, s.AccountName, pst.PharFullName AS PharmacistInChargeName, pst.PharTitle AS PharmacistInChargeTitle, 
                         pst.PharLicNo AS PharmacistInChargeLicence, pst.PharExpDate AS PharmacistInChargeLicenceExpirationDate, crd.StateLicNo AS PharmacyStateLicense, 
                         crd.StateLicExpDate AS PharmacyStateLicenseExpirationDate, crd.GenLiabPolicyNumber AS GeneralInsurancePolicy, 
                         crd.GenInsExpDate AS GeneralInsurancePolicyLiabilityExpirationDate, crd.ProfPolicyNumber AS ProfessionalInsurancePolicy, 
                         crd.ProfLiabInsExpDate AS ProfessionalInsurancePolicyLiabilityExpirationDate, crd.StateMedicaidNo AS StateMedicaidLicense, phy.DEA AS PharmacyDEA, 
                         phy.DEAEXP AS PharmacyDEAExpirationDate, s.Address, s.City, s.State, s.Zip, s.Email, s.Fax, s.Phone, s.IsStoreComplianceGuardian, s.IsStoreStaffGuard, 
                         s.IsStoreAAP, s.IsStoreManagedCare, s.IsStoreNonManagedCare, s.IsStoreNPP
FROM            dbo.v_CA_StoreStatus AS s LEFT OUTER JOIN
                         PharmacyMaster.dbo.PM_Pharmacists AS pst ON s.PMID = pst.PMID LEFT OUTER JOIN
                         PharmacyMaster.dbo.PM_Cred AS crd ON s.PMID = crd.PMID LEFT OUTER JOIN
                         PharmacyMaster.dbo.PM_Pharmacy AS phy ON s.PMID = phy.PMID
WHERE        (pst.PharExpDate < DATEADD(day, 30, GETDATE())) OR
                         (crd.StateLicExpDate < DATEADD(day, 30, GETDATE())) OR
                         (crd.GenInsExpDate < DATEADD(day, 30, GETDATE())) OR
                         (crd.ProfLiabInsExpDate < DATEADD(day, 30, GETDATE())) OR
                         (phy.DEAEXP < DATEADD(day, 30, GETDATE()))
--WHERE        (pst.PharExpDate < DATEADD(day, 30, '2015/11/01')) OR
--                         (crd.StateLicExpDate < DATEADD(day, 30, '2015/11/01')) OR
--                         (crd.GenInsExpDate < DATEADD(day, 30, '2015/11/01')) OR
--                         (crd.ProfLiabInsExpDate < DATEADD(day, 30, '2015/11/01')) OR
--                         (phy.DEAEXP < DATEADD(day, 30, '2015/11/01'))
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 281
               Right = 403
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "pst"
            Begin Extent = 
               Top = 258
               Left = 432
               Bottom = 387
               Right = 602
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "crd"
            Begin Extent = 
               Top = 115
               Left = 493
               Bottom = 244
               Right = 818
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "phy"
            Begin Extent = 
               Top = 7
               Left = 836
               Bottom = 136
               Right = 1084
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
      Begin ColumnWidths = 13
         Column = 1440
         Alias = 900
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
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_CA_StoreCredentialingStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_CA_StoreCredentialingStatus'
GO
