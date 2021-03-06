USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_AuditInfo]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*- SELECT * FROM [dbo].[v_PM_AuditGuardInfo]*/
CREATE VIEW [dbo].[v_PM_AuditInfo]
AS
SELECT     audit.Id AS AuditId, audit.DateUDNotified, audit.NotifyType, audit.DateAuditNotice, audit.AuditDate, audit.InitialDateNotice, audit.InitialAuditAmount, 
                      audit.InitialAuditDeadline, audit.FinalDateNotice, audit.FinalAuditNoticeDate, audit.FinalAuditAmount, audit.Notes, audit.CreatedDate, audit.LastUpdatedBy, 
                      audit.MultipleStoreDiscount, audit.AmountBilledToPharmacy, auditFirm.AuditFirm, auditPlan.AuditPlan, auditType.AuditType,
                          (SELECT     CASE WHEN COUNT(MemberPrograms.PMID) > 0 THEN 1 ELSE 0 END AS Expr1
                            FROM          dbo.PM_MemberPrograms AS MemberPrograms
                            WHERE      (ProgramID = 182) AND (EndDate IS NULL) AND (PMID = affliliates.PMID)) AS IsAuditGuard,
                          (SELECT     CASE WHEN COUNT(MemberPrograms.PMID) > 0 THEN 1 ELSE 0 END AS Expr1
                            FROM          dbo.PM_MemberPrograms AS MemberPrograms
                            WHERE      (ProgramID = 184) AND (EndDate IS NULL) AND (PMID = affliliates.PMID)) AS IsAAPElite, 
                      CASE WHEN ComputerSoftware LIKE 'Rx3%' THEN 1 ELSE 0 END AS IsRx30, affliliates.IsManagedCare, affliliates.AccountName, affliliates.Addr1, affliliates.Addr2, 
                      affliliates.City, affliliates.Fax, affliliates.Phone, affliliates.Email, affliliates.NPI, affliliates.AAPAccountNo, affliliates.NCPDP
FROM         dbo.PM_Audit AS audit INNER JOIN
                      dbo.PM_AuditFirm AS auditFirm ON audit.AuditFirmId = auditFirm.Id INNER JOIN
                      dbo.PM_AuditPlan AS auditPlan ON audit.AuditPlanId = auditPlan.Id INNER JOIN
                      dbo.PM_AuditType AS auditType ON audit.AuditTypeId = auditType.Id LEFT OUTER JOIN
                      dbo.v_PM_AllWithAffiliates AS affliliates ON audit.PMID = affliliates.PMID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[24] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[53] 2[31] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[43] 3) )"
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
         Begin Table = "audit"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 407
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "auditFirm"
            Begin Extent = 
               Top = 332
               Left = 339
               Bottom = 421
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "auditPlan"
            Begin Extent = 
               Top = 112
               Left = 732
               Bottom = 201
               Right = 892
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "auditType"
            Begin Extent = 
               Top = 243
               Left = 507
               Bottom = 332
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "affliliates"
            Begin Extent = 
               Top = 6
               Left = 937
               Bottom = 356
               Right = 1170
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
         Column = 3420
         Alias = 3120' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_PM_AuditInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_PM_AuditInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_PM_AuditInfo'
GO
