USE [WebDev]
GO
/****** Object:  View [dbo].[v_QC_DDICurrent]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_QC_DDICurrent]
AS
SELECT     TOP (100) PERCENT dbo.QC_DDI.PharmID, dbo.QC_DDI.PatID, dbo.QC_DDI.DrugName, dbo.QC_DDI.RxNbr, dbo.QC_DDI.RfNbr, dbo.QC_DDI.DDIDrugName, 
                      dbo.QC_DDI.DDIRxNbr, dbo.QC_DDI.hide, dbo.QC_DDI.id, dbo.QC_DDI.DDIRfNbr, dbo.QC_DDI.[Rx Date], dbo.QC_DDI.DDIRxDate, dbo.QC_DDI.[Day Supply], 
                      dbo.QC_DDI.DDIDS, dbo.QC_DDI.RA, dbo.QC_DDI.DDIRA, dbo.QC_DDI.Catg, dbo.QC_DDI_Interactions.Description AS interact
FROM         dbo.QC_DDI LEFT OUTER JOIN
                      dbo.QC_DDI_Interactions ON dbo.QC_DDI.Catg = dbo.QC_DDI_Interactions.InterID
WHERE     (DATEDIFF(dd, dbo.QC_DDI.[Rx Date], GETDATE()) < dbo.QC_DDI.[Day Supply]) AND (dbo.QC_DDI.RA > dbo.QC_DDI.RfNbr) AND 
                      (dbo.QC_DDI.DDIRA > dbo.QC_DDI.DDIRfNbr)
ORDER BY dbo.QC_DDI.PharmID, dbo.QC_DDI.PatID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[11] 3) )"
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
         Begin Table = "QC_DDI"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 277
               Right = 371
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "QC_DDI_Interactions"
            Begin Extent = 
               Top = 24
               Left = 440
               Bottom = 113
               Right = 600
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
      Begin ColumnWidths = 9
         Width = 284
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_QC_DDICurrent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_QC_DDICurrent'
GO
