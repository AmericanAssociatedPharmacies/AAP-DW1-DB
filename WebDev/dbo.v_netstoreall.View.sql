USE [WebDev]
GO
/****** Object:  View [dbo].[v_netstoreall]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_netstoreall]
AS
SELECT     dbo.NetstoreUsers.ClientID, dbo.NetstoreUsers.Password, dbo.NetstoreUsers.Enabled, dbo.NetstoreUsers.Name, 
                      PharmacyMaster.dbo.v_PM_AllWithAffiliates.NCPDP, PharmacyMaster.dbo.v_PM_AllWithAffiliates.PMID, dbo.NetstoreUsers.PMID AS NSPMID, 
                      PharmacyMaster.dbo.v_PM_AllWithAffiliates.AAPAccountNo, PharmacyMaster.dbo.v_PM_AllWithAffiliates.AAPQuitDate, 
                      PharmacyMaster.dbo.v_PM_AllWithAffiliates.APIAccountNo
FROM         dbo.NetstoreUsers LEFT OUTER JOIN
                      PharmacyMaster.dbo.v_PM_AllWithAffiliates ON dbo.NetstoreUsers.ClientID = PharmacyMaster.dbo.v_PM_AllWithAffiliates.APIAccountNo
WHERE     (dbo.NetstoreUsers.Enabled = 'Y')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[14] 2[26] 3) )"
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
         Begin Table = "NetstoreUsers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 194
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v_PM_AllWithAffiliates (PharmacyMaster.dbo)"
            Begin Extent = 
               Top = 12
               Left = 464
               Bottom = 328
               Right = 908
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
         Width = 3180
         Width = 1335
         Width = 1290
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 4725
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_netstoreall'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_netstoreall'
GO
