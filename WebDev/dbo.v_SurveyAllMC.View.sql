USE [WebDev]
GO
/****** Object:  View [dbo].[v_SurveyAllMC]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_SurveyAllMC]
AS
SELECT DISTINCT 
                      a.PMID, a.NCPDP, a.AccountName, (CASE WHEN CG.StartDate IS NULL THEN 0 ELSE 1 END) AS IsStoreComplianceGuardian, (CASE WHEN SG.StartDate IS NULL 
                      THEN 0 ELSE 1 END) AS IsStoreStaffGuard, CASE WHEN ISNULL(LTRIM(RTRIM(a.AAPAccountNo)), NULL) <> '' AND (a.AAPQuitDate IS NULL OR
                      a.AAPQuitDate > getdate()) THEN 1 ELSE 0 END AS IsStoreAAP, CASE WHEN ((((a.ChainCode IS NOT NULL) AND (a.MCQuitDate IS NULL) AND 
                      (a.AAPAccountNo IS NOT NULL OR
                      a.AAPAccountNo <> '') OR
                      (a.ChainCode IS NOT NULL) AND (a.MCQuitDate IS NULL) AND (a.AAPAccountNo IS NULL) AND (a.IsNPP <> 0)) OR
                      a.isNPP = - 1) AND ((a.MCQuitDate IS NULL OR
                      a.MCQuitDate > getdate()) AND (a.AAPQuitDate IS NULL OR
                      a.AAPQuitDate > getdate())) OR
                      a.isNPP = - 1) THEN 1 ELSE 0 END AS IsStoreManagedCare, CASE WHEN NOT (((((a.ChainCode IS NOT NULL) AND (a.MCQuitDate IS NULL) AND 
                      (a.AAPAccountNo IS NOT NULL OR
                      a.AAPAccountNo <> '') OR
                      (a.ChainCode IS NOT NULL) AND (a.MCQuitDate IS NULL) AND (a.AAPAccountNo IS NULL) AND (a.IsNPP <> 0)) OR
                      a.isNPP = - 1) AND ((a.MCQuitDate IS NULL OR
                      a.MCQuitDate > getdate()) AND (a.AAPQuitDate IS NULL OR
                      a.AAPQuitDate > getdate())) OR
                      a.isNPP = - 1)) THEN 1 ELSE 0 END AS IsStoreNonManagedCare, CASE WHEN (IsNPP != 0) THEN 1 ELSE 0 END AS IsStoreNPP, a.Email, a.OwnerName, a.Addr1, 
                      a.Addr2, a.City, a.State, a.Zip, a.Phone, a.Fax, a.NPI, CG.StartDate AS ComplianceGuardianStartDate, CG.EndDate AS ComplianceGuardianEndDate, 
                      SG.StartDate AS StaffGuardStartDate, SG.EndDate AS StaffGuardEndDate, a.AAPAccountNo, a.ChainCode, a.MCQuitDate, a.AAPQuitDate, a.IsNPP, 1 AS rn
FROM         PharmacyMaster.dbo.v_PM_AllWithAffiliates AS a LEFT OUTER JOIN
                          (SELECT     PMID, ProgramID, StartDate, EndDate, Comment, Created, Modified, RowVersion, AAP
                            FROM          PharmacyMaster.dbo.PM_MemberPrograms AS zzz
                            WHERE      (ProgramID = 197)) AS CG ON a.PMID = CG.PMID LEFT OUTER JOIN
                          (SELECT     PMID, ProgramID, StartDate, EndDate, Comment, Created, Modified, RowVersion, AAP
                            FROM          PharmacyMaster.dbo.PM_MemberPrograms AS zz
                            WHERE      (ProgramID = 196)) AS SG ON a.PMID = SG.PMID
WHERE     (a.ChainCode IS NOT NULL) AND (a.MCQuitDate IS NULL) AND (a.AAPAccountNo IS NOT NULL OR
                      a.AAPAccountNo <> '') AND (a.AAPQuitDate IS NULL) OR
                      (a.ChainCode IS NOT NULL) AND (a.MCQuitDate IS NULL) AND (a.IsNPP = - 1)
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
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 14
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CG"
            Begin Extent = 
               Top = 6
               Left = 270
               Bottom = 125
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SG"
            Begin Extent = 
               Top = 6
               Left = 468
               Bottom = 125
               Right = 628
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
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
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_SurveyAllMC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_SurveyAllMC'
GO
