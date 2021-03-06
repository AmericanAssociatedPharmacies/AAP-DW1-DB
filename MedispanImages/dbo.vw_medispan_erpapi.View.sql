USE [MedispanImages]
GO
/****** Object:  View [dbo].[vw_medispan_erpapi]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  *****
and MFG like 'CERN%'
order by m.NDC*/
CREATE VIEW [dbo].[vw_medispan_erpapi]
AS
SELECT DISTINCT 
                         m.NDC, m.NDC_10, f.Formatted_ID_Number AS ndc_upc_hri_formatted, m.GPI, m.DrugName AS drug_name, m.GPIDesc AS description, m.MFG AS manufacturer, m.DrugType AS drug_type, m.Form, 
                         m.PD AS packaging_description, CAST(m.PackageQuantity AS VARCHAR(10)) + ' X ' + CAST(CAST(m.PS AS float) AS VARCHAR(10)) + ' ' + LOWER(m.Unit) AS qty, m.RxOTC AS rx_or_otc, m.AWP, 
                         m.RouteAdmin AS route_of_administration, { fn CONCAT(m.Strength, m.Strength_Unit_Measure) } AS strength, m.Strength_Unit_Measure AS unit_of_measure, m.Unit, m.DEA AS dea_schedule, f.TEE_Code AS ab_code, 
                         i.Image_Filename, o.DrugName AS brand_name, a.TC_GPI_Name AS drug_class, b.TC_GPI_Name AS drug_subclass
FROM            Medispan.dbo.DrugMaster AS m LEFT OUTER JOIN
                         Medispan.dbo.M25_A AS f ON m.NDC = f.NDC_UPC_HRI LEFT OUTER JOIN
                         dbo.vw_image_by_ndc AS i ON m.NDC = i.NDC LEFT OUTER JOIN
                         Medispan.dbo.DrugMaster AS o ON m.GPI = o.GPI AND o.MSC = 'o' LEFT OUTER JOIN
                         Medispan.dbo.M25TCRF_5 AS a ON LEFT(m.GPI, 4) = LEFT(a.Therapeutic_Classification_Co, 4) AND a.Record_Type_Code = 2 LEFT OUTER JOIN
                         Medispan.dbo.M25TCRF_5 AS b ON LEFT(m.GPI, 6) = LEFT(b.Therapeutic_Classification_Co, 6) AND b.Record_Type_Code = 3
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[13] 2[49] 3) )"
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
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 251
               Bottom = 136
               Right = 518
            End
            DisplayFlags = 280
            TopColumn = 32
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 6
               Left = 556
               Bottom = 136
               Right = 823
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 305
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 138
               Left = 343
               Bottom = 268
               Right = 590
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 285
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
         Column = 4305
         Alias = 2130
         Table = 1170
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_medispan_erpapi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   Output = 720
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_medispan_erpapi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_medispan_erpapi'
GO
