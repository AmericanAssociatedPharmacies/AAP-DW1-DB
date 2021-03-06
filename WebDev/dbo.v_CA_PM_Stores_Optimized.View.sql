USE [WebDev]
GO
/****** Object:  View [dbo].[v_CA_PM_Stores_Optimized]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_CA_PM_Stores_Optimized]
AS
SELECT        *
FROM            (SELECT        phy.PMID, phy.NCPDP, phy.AccountName, CASE WHEN ((pmp.ProgramId = 197 AND (pmp.EndDate IS NULL OR
                                                    pmp.EndDate > getDate())) OR
                                                    ((((pmc.ChainCode IS NOT NULL) AND (pmc.MCQuitDate IS NULL) AND (phy.AAPAccountNo IS NOT NULL OR
                                                    phy.AAPAccountNo <> '') OR
                                                    (pmc.ChainCode IS NOT NULL) AND (pmc.MCQuitDate IS NULL) AND (phy.AAPAccountNo IS NULL) AND (phy.IsNPP <> 0)) OR
                                                    phy.isNPP = - 1) AND ((pmc.MCQuitDate IS NULL OR
                                                    pmc.MCQuitDate > getdate()) AND (phy.AAPQuitDate IS NULL OR
                                                    phy.AAPQuitDate > getdate())) OR
                                                    phy.isNPP = - 1)) THEN 1 ELSE 0 END AS IsStoreComplianceGuardian, CASE WHEN pmp.ProgramId = 196 THEN 1 ELSE 0 END AS IsStoreStaffGuard, CASE WHEN ISNULL(LTRIM(RTRIM(phy.AAPAccountNo)), null) <> ''
and (phy.AAPQuitDate is null OR phy.AAPQuitDate > getdate()) THEN 1 ELSE 0 END AS IsStoreAAP, 
                                                    CASE WHEN ((((pmc.ChainCode IS NOT NULL) AND (pmc.MCQuitDate IS NULL) AND (phy.AAPAccountNo IS NOT NULL OR
                                                    phy.AAPAccountNo <> '') OR
                                                    (pmc.ChainCode IS NOT NULL) AND (pmc.MCQuitDate IS NULL) AND (phy.AAPAccountNo IS NULL) AND (phy.IsNPP <> 0)) OR
                                                    phy.isNPP = - 1) AND ((pmc.MCQuitDate IS NULL OR
                                                    pmc.MCQuitDate > getdate()) AND (phy.AAPQuitDate IS NULL OR
                                                    phy.AAPQuitDate > getdate())) OR
                                                    phy.isNPP = - 1) THEN 1 ELSE 0 END AS IsStoreManagedCare, CASE WHEN NOT (((((pmc.ChainCode IS NOT NULL) AND (pmc.MCQuitDate IS NULL) AND 
                                                    (phy.AAPAccountNo IS NOT NULL OR
                                                    phy.AAPAccountNo <> '') OR
                                                    (pmc.ChainCode IS NOT NULL) AND (pmc.MCQuitDate IS NULL) AND (phy.AAPAccountNo IS NULL) AND (phy.IsNPP <> 0)) OR
                                                    phy.isNPP = - 1) AND ((pmc.MCQuitDate IS NULL OR
                                                    pmc.MCQuitDate > getdate()) AND (phy.AAPQuitDate IS NULL OR
                                                    phy.AAPQuitDate > getdate())) OR
                                                    phy.isNPP = - 1)) THEN 1 ELSE 0 END AS IsStoreNonManagedCare, CASE WHEN (IsNPP != 0) THEN 1 ELSE 0 END AS IsStoreNPP, phy.Email, 
                                                    phy.OwnerName, pam.Address AS [Addr1], pam.Address2 AS [Addr2], pam.City, pam.State, pam.Zip, pam.Phone, pam.Fax, phy.NPI, 
                                                    CASE WHEN pmp.ProgramID = 197 THEN pmp.StartDate ELSE NULL END AS ComplianceGuardianStartDate, 
                                                    CASE WHEN pmp.ProgramID = 197 THEN pmp.EndDate ELSE NULL END AS ComplianceGuardianEndDate, 
                                                    CASE WHEN pmp.ProgramID = 196 THEN pmp.StartDate ELSE NULL END AS StaffGuardStartDate, 
                                                    CASE WHEN pmp.ProgramID = 196 THEN pmp.EndDate ELSE NULL END AS StaffGuardEndDate, phy.AAPAccountNo, pmc.ChainCode, pmc.MCQuitDate, 
                                                    phy.AAPQuitDate, phy.IsNPP, /* to get rid of old pmids when there is a transfer of ownership*/ ROW_NUMBER() OVER (Partition BY NCPDP
                          ORDER BY aapeffectivedate DESC, aapquitdate ASC, aapaccountno DESC) 
                         AS rn
/*Rank() OVER (Partition BY NCPDP order by aapeffectivedate desc, aapquitdate asc, aapaccountno desc) as rn*/ FROM [PharmacyMaster].[dbo].[PM_Pharmacy] phy LEFT OUTER
                          JOIN
                         [PharmacyMaster].[dbo].[PM_AddressMaster] pam ON phy.PMID = pam.PMID AND pam.Address_Type_Id = 1 LEFT OUTER JOIN
                         [PharmacyMaster].[dbo].[PM_ManagedCare] pmc ON phy.PMID = pmc.PMID LEFT OUTER JOIN
                         [PharmacyMaster].[dbo].[PM_MemberPrograms] pmp ON phy.PMID = pmp.PMID AND (pmp.ProgramID = 197 OR
                         pmp.ProgramID = 196)) a
WHERE        a.rn = 1 AND a.isstorecomplianceguardian = 1
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_CA_PM_Stores_Optimized'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_CA_PM_Stores_Optimized'
GO
