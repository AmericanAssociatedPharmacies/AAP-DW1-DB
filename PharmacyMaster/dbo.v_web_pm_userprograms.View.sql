USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_web_pm_userprograms]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*show selected programs with 1 for participant, 0 non-participant B.Grant 6/2012
sorted in the web display code
added 'webprofile' field to pm_programs, previously used the "AAP" field 
originally used v_PM_AllWithAffiliates_NotForClaims switched back to v_PM_AllWithAffiliates
*/
CREATE VIEW [dbo].[v_web_pm_userprograms]
AS
SELECT     dt1.PMID, dt2.ProgramID, dt2.Description, CASE WHEN mp.pmid IS NULL THEN 0 ELSE CASE WHEN mp.enddate IS NULL AND 
                      mp.startdate IS NOT NULL THEN 1 ELSE 0 END END AS isInProgram
FROM         (SELECT DISTINCT PMID
                       FROM          dbo.v_PM_AllWithAffiliates) AS dt1 INNER JOIN
						  (SELECT DISTINCT ProgramID, Description
							FROM          dbo.PM_Programs
							--WHERE      (ProgramID IN (193, 197, 6))) 
							--WHERE (isnull(AAP,0)<>0) or ProgramID=183)
							WHERE webprofile=1)
							AS dt2 ON dt1.PMID = dt1.PMID LEFT OUTER JOIN
                      dbo.PM_MemberPrograms AS mp ON mp.PMID = dt1.PMID AND mp.ProgramID = dt2.ProgramID
UNION
SELECT DISTINCT 
                      PMID, - 1 AS programid, 'Managed Care' AS description, CASE WHEN (MCQuitDate IS NULL AND chaincode IS NOT NULL) AND 
                      (((AAPAccountno IS NOT NULL AND AAPAccountno <> '') AND AAPQuitdate IS NULL) OR
                      (IsNPP = - 1)) THEN 1 ELSE 0 END AS isInProgram
FROM         dbo.v_PM_AllWithAffiliates  AS v_PM_AllWithAffiliates_3
UNION
SELECT DISTINCT 
                      PMID, - 2 AS programid, 'AAP Member' AS description, CASE WHEN (AAPaccountno IS NOT NULL AND AAPaccountno<>'') AND AAPquitdate IS NULL 
                      THEN 1 ELSE 0 END AS isInProgram
FROM         dbo.v_PM_AllWithAffiliates  AS v_PM_AllWithAffiliates_2
UNION
SELECT DISTINCT PMID, - 3 AS programid, 'API Customer' AS description, CASE WHEN APIStatus = 'ACTIVE' THEN 1 ELSE 0 END AS isInProgram
FROM         dbo.v_PM_AllWithAffiliates  AS v_PM_AllWithAffiliates_1







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
         Configuration = "(H (4[30] 2[40] 3) )"
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
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
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
      Begin ColumnWidths = 5
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_web_pm_userprograms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_web_pm_userprograms'
GO
