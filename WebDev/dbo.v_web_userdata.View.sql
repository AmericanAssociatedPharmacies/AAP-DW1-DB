USE [WebDev]
GO
/****** Object:  View [dbo].[v_web_userdata]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE VIEW [dbo].[v_web_userdata]
AS
SELECT DISTINCT 
                      u.loginid, u.login, u.roleid, u.execpassword,r.rolename, u.defaultpmid, u.nslogin, u.nspwd, u.active, u.perms, p.pmid, p.pmparentid, p.aapaccountno, p.aapstatus, p.apiaccountno, 
                      p.ncpdp, p.dea, p.deaexp, p.npi, p.statelicno, p.statelicexpdate, p.mcquitdate, p.accountname, p.corporatename, p.addr1,p.addr2,p.city, p.state, p.zip, p.phone, p.fax, p.email, p.isAPI, 
                      p.isAAP, p.isMC, p.isTSROnly, p.isElite, p.parent_account, p.TMName, p.GenLiabCarrier, p.GenInsExpDate, p.ProfLiabCarrier, p.ProfLiabInsExpDate, 
                      p.software
                      ,isClaimData
                      ,case when p.isClaimData=1 then 'Yes' else 'No' end as isClaimDataDescription
                      ,p.wholesaler,
                      --dbo.fnWebUserDescription(p.accountname, isnull(p.city,''), isnull(p.state,''), isnull(p.isElite,0)) AS description, --deprecated Elite
                      dbo.fnWebUserDescription(p.accountname, isnull(p.city,''), isnull(p.state,''), 0) AS description,
                      p.CommunicationPreference,p.affiliate,p.affiliate_directpay,p.chaincode
                      ,p.OwnerName
FROM         dbo.userlogin AS u LEFT OUTER JOIN
                      PharmacyMaster.dbo.v_web_pm_userdata AS p ON u.defaultpmid = p.pmid LEFT OUTER JOIN
                      dbo.userrole AS r ON r.roleid = u.roleid






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
         Begin Table = "u"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 402
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 192
               Right = 189
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_web_userdata'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_web_userdata'
GO
