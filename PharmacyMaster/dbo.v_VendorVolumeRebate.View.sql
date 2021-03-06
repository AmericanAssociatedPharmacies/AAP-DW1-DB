USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_VendorVolumeRebate]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_VendorVolumeRebate]
AS
SELECT     dbo.VendorTransaction.PaidDt, dbo.Partners.VendorName, dbo.VendorVolumeRebate.ID, dbo.VendorVolumeRebate.VendorID, dbo.VendorVolumeRebate.PMID, 
                      dbo.VendorVolumeRebate.UDNo, dbo.VendorVolumeRebate.StoreName, dbo.VendorVolumeRebate.VolumeAmt, dbo.VendorVolumeRebate.RebateAmt, 
                      dbo.VendorVolumeRebate.AccruedStartdt, dbo.VendorVolumeRebate.AccruedEnddt, dbo.VendorVolumeRebate.FileID, dbo.VendorVolumeRebate.TransactionID, 
                      dbo.VendorLoad.FileName, dbo.VendorLoad.LoadDate, dbo.VendorLoad.LoadedBy, dbo.VendorVolumeRebate.Eligibility, dbo.VendorVolumeRebate.PayTo, 
                      dbo.VendorVolumeRebate.StorePaidDt, dbo.VendorVolumeRebate.Affiliate, dbo.Partners.RebateReportDisplayName
FROM         dbo.Partners INNER JOIN
                      dbo.VendorTransaction ON dbo.Partners.VendorID = dbo.VendorTransaction.VendorID INNER JOIN
                      dbo.VendorVolumeRebate ON dbo.VendorTransaction.TransactionID = dbo.VendorVolumeRebate.TransactionID LEFT OUTER JOIN
                      dbo.VendorLoad ON dbo.VendorVolumeRebate.FileID = dbo.VendorLoad.FileID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[25] 2[18] 3) )"
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
         Begin Table = "Partners"
            Begin Extent = 
               Top = 218
               Left = 708
               Bottom = 341
               Right = 922
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VendorTransaction"
            Begin Extent = 
               Top = 220
               Left = 457
               Bottom = 345
               Right = 659
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VendorVolumeRebate"
            Begin Extent = 
               Top = 53
               Left = 68
               Bottom = 342
               Right = 293
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VendorLoad"
            Begin Extent = 
               Top = 66
               Left = 457
               Bottom = 210
               Right = 660
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
      Begin ColumnWidths = 17
         Width = 284
         Width = 3270
         Width = 2010
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
         Column = 2325
         Alias = 900
         Table = 2895
         Output = 720
         App' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_VendorVolumeRebate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'end = 1400
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_VendorVolumeRebate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_VendorVolumeRebate'
GO
