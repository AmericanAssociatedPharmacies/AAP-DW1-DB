USE [WebDev]
GO
/****** Object:  View [dbo].[v_SpecialtyStatus]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_SpecialtyStatus]
AS
SELECT DISTINCT 
                      TOP (100) PERCENT a.PMID, a.AccountName, CASE WHEN LEFT(a.NCPDP, 1) = '0' THEN CHAR(61) + CHAR(34) + a.NCPDP + CHAR(34) ELSE a.NCPDP END AS Expr1, 
                      a.NPI, a.ContactFullName AS [PM Contact], a.Email, a.Addr1, a.Addr2, a.City, a.State, a.Zip, a.Phone, a.Fax, a.ComputerSoftware, a.TMFirstName, a.TMLastName, 
                      CASE WHEN EXISTS
                          (SELECT     o.pmid
                            FROM          PharmacyMaster.dbo.PM_ProgramStepMember o
                            WHERE      o.PMID = i.pmid AND o.ProgramID = 183 AND o.ProgramStepID = 1) THEN 'Yes' ELSE 'No' END AS [Enrollment completed?],
                          (SELECT     CONVERT(VARCHAR(10), StartDate, 101) AS Expr1
                            FROM          PharmacyMaster.dbo.PM_ProgramStepMember AS o
                            WHERE      (PMID = i.PMID) AND (ProgramID = 183) AND (ProgramStepID = 1)) AS [Enrollment date],
                          (SELECT     TOP (1) AnswerInput
                            FROM          dbo.SurveyAnswer AS o
                            WHERE      (PMId = a.PMID) AND (OptionId = 181)
                            ORDER BY Id DESC) AS [Enrollment contact], CASE WHEN EXISTS
                          (SELECT     o.pmid
                            FROM          PharmacyMaster.dbo.PM_ProgramStepMember o
                            WHERE      o.PMID = i.pmid AND o.ProgramID = 183 AND o.ProgramStepID = 2) THEN 'Yes' ELSE 'No' END AS [Training completed?],
                          (SELECT     TOP (1) CONVERT(VARCHAR(10), StartDate, 101) AS Expr1
                            FROM          PharmacyMaster.dbo.PM_ProgramStepMember AS o
                            WHERE      (PMID = i.PMID) AND (ProgramID = 183) AND (ProgramStepID = 2)
                            ORDER BY StartDate DESC) AS [Training completion date], CASE WHEN EXISTS
                          (SELECT     o.pmid
                            FROM          PharmacyMaster.dbo.PM_ProgramStepMember o
                            WHERE      o.PMID = i.pmid AND o.ProgramID = 183 AND o.ProgramStepID = 2) THEN
                          (SELECT     TOP 1 o.AnswerInput
                            FROM          dbo.SurveyAnswer o
                            WHERE      o.PMId = a.pmid AND o.OptionID = 176
                            ORDER BY o.Id DESC) ELSE NULL END AS [Person completing training],
                          (SELECT     TOP (1) CONVERT(VARCHAR(10), StartDate, 101) AS Expr1
                            FROM          PharmacyMaster.dbo.PM_MemberPrograms AS o
                            WHERE      (ProgramID = 183) AND (PMID = a.PMID)) AS [Go live date]
FROM         PharmacyMaster.dbo.v_PM_AllWithAffiliates AS a LEFT OUTER JOIN
                      PharmacyMaster.dbo.PM_ProgramStepMember AS i ON a.PMID = i.PMID LEFT OUTER JOIN
                      PharmacyMaster.dbo.software AS s ON s.ID = a.ComputerSoftware
WHERE     (i.ProgramID = 183)
ORDER BY [Training completed?]
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
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 290
               Bottom = 125
               Right = 452
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 490
               Bottom = 110
               Right = 650
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
      Begin ColumnWidths = 24
         Width = 284
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
         ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_SpecialtyStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_SpecialtyStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_SpecialtyStatus'
GO
