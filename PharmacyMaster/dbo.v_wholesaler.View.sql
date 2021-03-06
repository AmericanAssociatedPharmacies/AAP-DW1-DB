USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_wholesaler]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_wholesaler]

AS

SELECT     CH.PMID
, V.VendorID AS 'PRIMARY ID'
, (SELECT VendorName
    FROM dbo.PM_Vendors
    WHERE (VendorID = V.VendorID)
	) AS 'PRIMARY DESCRIPTION'
, CH.Marker, CH.IsMCAOnFile AS 'IS MCA ON FILE'
, CH.CHParentCode AS 'CA PARENT CODE'
, CH.Division, CH.CHAccountNoPrimary AS 'PRIMARY CA ACCT#'
, CH.CHAccountNo2 AS '2ND CARDINAL CUST'
, CH.CHAccountNo3 AS '3RD CARDINAL CUST'
, CH.POSAcct AS 'POS ACCT'
, CH.ScanTossAcct AS 'SCAN TOSS ACCT'
, CH.CSOSAcct AS 'CSOS ACCT'
, CH.AAPContractDate AS 'AAP CONTRACT DATE'
, CH.TerminationDate AS 'PVA TERMINATION DATE'
, CH.IsMultipleStore AS 'IS MULTIPLE STORE'
, CH.MultipleStoreCode AS 'MULTIPLE STORE CODE'
, CH.CurrEstMoSales AS 'CURR EST MO SALES'
, CH.CurrGroupTotal AS 'CURR GROUP TOTAL'
, CH.EstVolAtLoad AS 'EST VOL AT LOAD'
, CH.LastReviewDate AS 'LAST REVIEW DATE'
, CH.CurrAPICOG AS 'MATRIX COG'
, CH.CurrCHCOG AS 'CURR CA COG'
, CH.PayTermsDesc AS 'PAY TERMS DESC'
, CH.PayTermsCode AS 'PAY TERMS CODE'
, CH.IsPendingChanges AS 'IS PENDING CHANGES'
, CH.NotesCOGDifferences AS 'NOTES COG DIFF'
, CH.Notes AS 'GENERAL NOTES'
, CH.IsExcptToMatrix AS 'IS EXCEPTION TO MATRIX'
, CH.IsOptionalPayTerms AS 'IS OPTIONAL PAY TERMS'
, CH.IsFrontLoadNoReb AS 'FRONT LOAD-NO REB'
, CH.WAPD
, CH.DSO
, CH.LastUpdate AS 'LAST UPDATE'
, CH.WAPD2ndAcct AS 'WAPD 2ND ACCT'
, CH.DSO2ndAcct AS 'DSO 2ND ACCT'
, CH.IsSublogicChange AS 'SUBLOGIC CHANGE'
, CH.NotesOnTerms AS 'NOTES ON TERMS'
, CH.ChangePending AS 'NOTES ON CHANGE PENDING'
FROM dbo.pm_chaccounts_adj AS CH 
LEFT OUTER JOIN dbo.PM_VendorAccts AS V ON V.PMID = CH.PMID


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
         Begin Table = "CH"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "V"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 121
               Right = 428
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_wholesaler'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_wholesaler'
GO
