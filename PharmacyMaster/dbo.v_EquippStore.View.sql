USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_EquippStore]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_EquippStore]
AS
SELECT     TOP (100) PERCENT dbo.v_PM_AllWithAffiliates.PMID AS StoreID, dbo.v_PM_AllWithAffiliates.AccountName AS StoreName, 
                      dbo.GetAffiliate_Equipp(dbo.v_PM_AllWithAffiliates.Affiliate, dbo.v_PM_AllWithAffiliates.AAPParentNo, dbo.PM_VendorAccts.VendorID) AS Grouping1, 
                      dbo.GetPMID_new(dbo.v_PM_AllWithAffiliates.AAPParentNo) AS Grouping2, '' AS Grouping3, dbo.v_PM_AllWithAffiliates.NPI AS PharmacyNPI, 
                      dbo.v_PM_AllWithAffiliates.Addr1 AS Address1, dbo.v_PM_AllWithAffiliates.Addr2 AS Address2, dbo.v_PM_AllWithAffiliates.City, dbo.v_PM_AllWithAffiliates.State, 
                      dbo.v_PM_AllWithAffiliates.Zip, dbo.v_PM_AllWithAffiliates.Phone
FROM         dbo.v_PM_AllWithAffiliates LEFT OUTER JOIN
                      dbo.PM_VendorAccts ON dbo.v_PM_AllWithAffiliates.PMID = dbo.PM_VendorAccts.PMID
WHERE     (dbo.v_PM_AllWithAffiliates.ChainCode IS NOT NULL) AND (dbo.v_PM_AllWithAffiliates.MCQuitDate IS NULL) AND 
                      (dbo.v_PM_AllWithAffiliates.AAPQuitDate IS NULL) OR
                      (dbo.v_PM_AllWithAffiliates.IsNPP <> 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[29] 2[22] 3) )"
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
         Begin Table = "v_PM_AllWithAffiliates"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 314
               Right = 325
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PM_VendorAccts"
            Begin Extent = 
               Top = 30
               Left = 463
               Bottom = 277
               Right = 761
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
         Column = 13125
         Alias = 1995
         Table = 3600
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_EquippStore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_EquippStore'
GO
