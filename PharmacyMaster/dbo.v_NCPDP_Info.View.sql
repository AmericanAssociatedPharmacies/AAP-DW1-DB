USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_NCPDP_Info]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_NCPDP_Info]
AS
SELECT        dbo.NCPDP_Provider.ProviderID AS NCPDP, dbo.NCPDP_Provider.NPI, dbo.NCPDP_Provider.DEA, dbo.NCPDP_Provider.[DEA Expiration Date] AS DEAEXP, 
                         dbo.NCPDP_Provider.Name, dbo.NCPDP_Provider.[Physical Location Address 1] AS Address, dbo.NCPDP_Provider.[Physical Location Address 2] AS Address1, 
                         dbo.NCPDP_Provider.[Physical Location City] AS City, dbo.NCPDP_Provider.[Physical Location State Code] AS State, 
                         dbo.NCPDP_Provider.[Physical Location Zip Code] AS Zip, dbo.NCPDP_Provider.[Physical Location Phone Number] AS Phone, 
                         dbo.NCPDP_Provider.[Physical Location Extension] AS Ext, dbo.NCPDP_Provider.[Physical Location FAX Number] AS Fax, 
                         dbo.NCPDP_Provider.[Physical Location E-Mail Address] AS Email, dbo.NCPDP_ProviderRelationship.[Relationship ID] AS ChainCode, 
                         dbo.NCPDP_RelationshipDemographicInformation.Name AS AffiliateName, dbo.NCPDP_RelationshipType_Affiliates.TypeName AS AffiliateType, 
                         dbo.NCPDP_ProviderRelationship.[Is Primary]
FROM            dbo.NCPDP_RelationshipDemographicInformation LEFT OUTER JOIN
                         dbo.NCPDP_RelationshipType_Affiliates ON 
                         dbo.NCPDP_RelationshipDemographicInformation.[Relationship Type] = dbo.NCPDP_RelationshipType_Affiliates.RelationshipType RIGHT OUTER JOIN
                         dbo.NCPDP_ProviderRelationship ON 
                         dbo.NCPDP_RelationshipDemographicInformation.RelationshipID = dbo.NCPDP_ProviderRelationship.[Relationship ID] RIGHT OUTER JOIN
                         dbo.NCPDP_Provider ON dbo.NCPDP_ProviderRelationship.[NCPDP Provider ID] = dbo.NCPDP_Provider.ProviderID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[19] 2[35] 3) )"
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
         Begin Table = "NCPDP_RelationshipDemographicInformation"
            Begin Extent = 
               Top = 15
               Left = 723
               Bottom = 334
               Right = 1062
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NCPDP_RelationshipType_Affiliates"
            Begin Extent = 
               Top = 20
               Left = 1101
               Bottom = 115
               Right = 1371
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NCPDP_ProviderRelationship"
            Begin Extent = 
               Top = 17
               Left = 366
               Bottom = 261
               Right = 648
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NCPDP_Provider"
            Begin Extent = 
               Top = 7
               Left = 11
               Bottom = 320
               Right = 283
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
         Column = 2985
         Alias = 3135
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_NCPDP_Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_NCPDP_Info'
GO
