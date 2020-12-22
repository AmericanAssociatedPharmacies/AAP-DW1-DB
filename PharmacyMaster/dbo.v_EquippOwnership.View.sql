USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_EquippOwnership]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_EquippOwnership]
AS
SELECT     dbo.GetPMID_new(dbo.PM_Pharmacy.AAPParentNo) AS Username, MIN(dbo.v_PM_AllWithAffiliates.OwnerName) AS Name, '' AS ProfDesignation, '' AS Title, 
                      MIN(dbo.v_PM_AllWithAffiliates.Email) AS Email, MIN(RTRIM(dbo.v_PM_AllWithAffiliates.Addr1) + ', ' + CASE WHEN RTRIM(LTRIM(v_PM_AllWithAffiliates.Addr2)) 
                      <> '' OR
                      v_PM_AllWithAffiliates.Addr2 IS NOT NULL THEN RTRIM(LTRIM(v_PM_AllWithAffiliates.Addr2)) + ',' ELSE '' END + RTRIM(dbo.v_PM_AllWithAffiliates.City) 
                      + ', ' + dbo.v_PM_AllWithAffiliates.State + ', ' + dbo.v_PM_AllWithAffiliates.Zip) AS Address, MIN(dbo.v_PM_AllWithAffiliates.Phone) AS Phone, 
                      dbo.GetPMID_new(dbo.PM_Pharmacy.AAPParentNo) AS [Level of Access]
FROM         dbo.PM_Pharmacy LEFT OUTER JOIN
                      dbo.v_PM_AllWithAffiliates ON dbo.PM_Pharmacy.AAPParentNo = dbo.v_PM_AllWithAffiliates.AAPAccountNo LEFT OUTER JOIN
                      dbo.PM_ManagedCare ON dbo.PM_Pharmacy.PMID = dbo.PM_ManagedCare.PMID
WHERE     (dbo.PM_Pharmacy.AAPQuitDate IS NULL) AND (dbo.PM_ManagedCare.ChainCode IS NOT NULL) AND (dbo.PM_ManagedCare.MCQuitDate IS NULL) OR
                      (dbo.PM_Pharmacy.IsNPP <> 0)
GROUP BY dbo.PM_Pharmacy.AAPParentNo
HAVING      (COUNT(*) > 1) AND (dbo.PM_Pharmacy.AAPParentNo > 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[25] 2[30] 3) )"
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
         Begin Table = "PM_Pharmacy"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 286
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v_PM_AllWithAffiliates"
            Begin Extent = 
               Top = 112
               Left = 366
               Bottom = 231
               Right = 576
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PM_ManagedCare"
            Begin Extent = 
               Top = 6
               Left = 572
               Bottom = 125
               Right = 787
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
      Begin ColumnWidths = 12
         Column = 7740
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_EquippOwnership'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_EquippOwnership'
GO
