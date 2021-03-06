USE [Medispan]
GO
/****** Object:  View [dbo].[v_API]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_API]

AS

SELECT dbo.M25_A.NDC_UPC_HRI AS NDC
, dbo.M25_J.Product_Description_Abbreviat AS [Desc]
, dbo.M25_M.Strength
, dbo.M25_L.Package_Size_Unit_of_Measure AS Unit
, dbo.M25_L.Package_Size AS Size
, dbo.M25_G.Generic_Product_Identifier AS GPI
, dbo.v_LastAWP.AWP
FROM dbo.M25_A 
LEFT OUTER JOIN dbo.M25_J ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_J.NDC_UPC_HRI 
LEFT OUTER JOIN dbo.v_LastAWP ON dbo.M25_A.NDC_UPC_HRI = dbo.v_LastAWP.NDC 
LEFT OUTER JOIN dbo.M25_M ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_M.NDC_UPC_HRI 
LEFT OUTER JOIN dbo.M25_L ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_L.NDC_UPC_HRI 
LEFT OUTER JOIN dbo.M25_G ON dbo.M25_A.NDC_UPC_HRI = dbo.M25_G.NDC_UPC_HRI
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[32] 2[15] 3) )"
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
         Begin Table = "M25_A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 302
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "M25_J"
            Begin Extent = 
               Top = 198
               Left = 395
               Bottom = 313
               Right = 634
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v_LastAWP"
            Begin Extent = 
               Top = 84
               Left = 617
               Bottom = 212
               Right = 769
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "M25_M"
            Begin Extent = 
               Top = 179
               Left = 1183
               Bottom = 294
               Right = 1432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "M25_L"
            Begin Extent = 
               Top = 20
               Left = 1153
               Bottom = 135
               Right = 1398
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "M25_G"
            Begin Extent = 
               Top = 180
               Left = 911
               Bottom = 295
               Right = 1121
            End
            DisplayFlags = 280
            TopColumn = 5
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
         Column = 3675
         Alias' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_API'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 1770
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_API'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_API'
GO
