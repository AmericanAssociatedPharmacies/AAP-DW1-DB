USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_web_pm_userdata]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[v_web_pm_userdata]
AS
SELECT     p.PMID, p.PMParentID, p.AAPAccountNo, p.AAPStatus, p.APIAccountNo, p.NCPDP, p.DEA, CONVERT(varchar(10), p.DEAEXP, 1) AS deaexp, p.NPI, p.StateLicNo, 
                      p.StateLicExpDate, p.MCQuitDate, p.AccountName, p.CorporateName, 
                      p.Addr1,p.Addr2,
                      p.City, p.State, p.Zip, p.Phone, p.Fax, p.Email, 
                      CASE WHEN p.APIStatus = 'ACTIVE' THEN 1 ELSE 0 END AS isAPI, CASE WHEN p.AAPaccountno IS NOT NULL AND p.AAPquitdate IS NULL THEN 1 ELSE 0 END AS isAAP, 
                      CASE WHEN (p.MCQuitDate IS NULL AND p.chaincode IS NOT NULL) AND (((p.AAPAccountno IS NOT NULL AND p.AAPAccountno <> '') AND p.AAPQuitdate IS NULL) OR
                      (p.IsNPP = - 1) OR
                      (p.IsNPP = 1)) THEN 1 ELSE 0 END AS isMC, CASE WHEN (p.MCQuitDate IS NOT NULL AND datediff(month, p.MCQuitDate, getdate()) <= 6) OR
                      (p.chaincode IS NOT NULL AND p.AAPquitdate IS NOT NULL AND datediff(month, p.AAPquitdate, getdate()) <= 6) THEN 1 ELSE 0 END AS isTSROnly, 
                      CASE WHEN (mp.ProgramID = 184) AND (mp.EndDate IS NULL) AND (p.AAPAccountNo IS NOT NULL) AND (p.AAPQuitDate IS NULL) THEN 1 ELSE 0 END AS isElite, 
                      CASE WHEN p.aapparentno IS NULL OR
                      p.aapparentno = p.aapaccountno THEN '' ELSE
                          (SELECT     TOP 1 accountname
                            FROM          pm_pharmacy
                            WHERE      pm_pharmacy.aapaccountno = p.aapparentno) END AS parent_account, t.FirstName + ' ' + t.LastName AS TMName, c.GenLiabCarrier, 
                      CONVERT(varchar(10), c.GenInsExpDate, 1) AS GenInsExpDate, c.ProfLiabCarrier, CONVERT(varchar(10), c.ProfLiabInsExpDate, 1) AS ProfLiabInsExpDate, 
                      sw.SOFTWARE,
                      case when (p.computersoftware='RX30') then 1 else 0 end as isClaimData, --deprecate
					  wh.vendor as wholesaler,
					  case isnull(p.CommunicationPreference,'X') when 'E' then 'Email' when 'F' then 'Fax' else 'None' end as CommunicationPreference,
					  affiliate,
					  case when affiliate in ('PIPCO','LEGEND-LA & MS','KEYSTONE','KEYSTONE-PRS') then 1 else 0 end as affiliate_directpay
					  ,(select isnull(max([ProgramStepID]),0) from pharmacymaster..pm_programstepmember where pmid=p.pmid and programid=183) as SpecialtyStep 
					  ,p.chaincode
					  ,p.OwnerName
FROM         dbo.v_PM_AllWithAffiliates_noClaims AS p LEFT OUTER JOIN
                      dbo.PM_MemberPrograms AS mp ON mp.PMID = p.PMID AND mp.ProgramID = 184 LEFT OUTER JOIN
                      dbo.PM_Territory AS t ON t.Territory = p.Territory LEFT OUTER JOIN
                      dbo.PM_Cred AS c ON c.PMID = p.PMID LEFT OUTER JOIN
                      dbo.software AS sw ON p.ComputerSoftware = sw.ID LEFT OUTER JOIN
					  dbo.v_wholesaler_primary AS wh ON wh.PMID=p.PMID 







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
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mp"
            Begin Extent = 
               Top = 6
               Left = 261
               Bottom = 114
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 330
               Right = 331
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sw"
            Begin Extent = 
               Top = 6
               Left = 450
               Bottom = 84
               Right = 601
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_web_pm_userdata'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_web_pm_userdata'
GO
