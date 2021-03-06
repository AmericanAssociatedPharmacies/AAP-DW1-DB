USE [WebDev]
GO
/****** Object:  View [dbo].[v_CA_StoreStatus]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_CA_StoreStatus]
AS
SELECT        e.*,  /* Employee CheckList Step 1 Status */ CASE WHEN e.Employees > 0 THEN 1 ELSE 0 END AS EmployeeCheckListStatus, 
                         CASE WHEN p.HIPAAManualStatus IS NULL THEN 0 ELSE p.HIPAAManualStatus END AS HIPAAManualStatus, CASE WHEN p.FWAManualStatus IS NULL 
                         THEN 0 ELSE p.FWAManualStatus END AS FWAManualStatus, CASE WHEN ehf.HIPAATrainingStatus IS NULL 
                         THEN 0 ELSE ehf.HIPAATrainingStatus END AS HIPAATrainingStatus, CASE WHEN ehf.FWATrainingStatus IS NULL 
                         THEN 0 ELSE ehf.FWATrainingStatus END AS FWATrainingStatus, CASE WHEN ehf.EmployeesWithOutAliasNames IS NULL 
                         THEN 0 ELSE ehf.EmployeesWithOutAliasNames END AS EmployeesWithOutAliasNames, CASE WHEN ehf.HIPAATrainedEmployees IS NULL 
                         THEN 0 ELSE ehf.HIPAATrainedEmployees END AS HIPAATrainedEmployees, CASE WHEN ehf.FWATrainedEmployees IS NULL 
                         THEN 0 ELSE ehf.FWATrainedEmployees END AS FWATrainedEmployees, 
						 --CASE WHEN a.AttestationStatus IS NULL THEN 0 ELSE a.AttestationStatus END AS AttestationStatus, a.AttestationDate,
						 [dbo].[fnSurveyIsCompletedInt](2,e.PMID,'') AttestationStatus, -- need to update here
						 [dbo].[fnSurveyGetDate](2, e.PMID, '') AttestationDate, -- need to update here 
                         CASE WHEN a.PharmacyNotExcluded = 1 THEN 1 ELSE 0 END AS AttestationPharmacyNotExcluded, 
                         CASE WHEN a.PersonnelNotExcluded = 1 THEN 1 ELSE 0 END AS AttestationPersonnelNotExcluded, 
                         CASE WHEN a.RecordRetention10yr = 1 THEN 1 ELSE 0 END AS AttestationRecordRetention10yr, 
                         CASE WHEN a.FWATraining = 1 THEN 1 ELSE 0 END AS AttestationFWATraining, 
                         CASE WHEN a.LogPersonnelFWATraining = 1 THEN 1 ELSE 0 END AS AttestationLogPersonnelFWATraining, 
                         CASE WHEN a.PharmacyMaintainsLicensesInsurance = 1 THEN 1 ELSE 0 END AS AttestationPharmacyMaintainsLicensesInsurance, 
                         CASE WHEN a.PersonnelMaintainsLicensesCertifications = 1 THEN 1 ELSE 0 END AS AttestationPersonnelMaintainsLicensesCertifications, 
                         CASE WHEN a.StandardsOfConductInWriting = 1 THEN 1 ELSE 0 END AS AttestationStandardsOfConductInWriting, 
                         CASE WHEN a.DesignatedComplianceOfficer = 1 THEN 1 ELSE 0 END AS AttestationDesignatedComplianceOfficer, 
                         CASE WHEN a.ProceduresToDetectFWA = 1 THEN 1 ELSE 0 END AS AttestationProceduresToDetectFWA, oiggsareport.IsOigGsaReportGenerated, 
                         oiggsareport.IsOigGsaReportEmailed, oiggsareport.IsOigGsaReportSuccess, oiggsareport.IsOigGsaReportValidEmail, 
                         oiggsareport.LastOigGsaReportGenerationAttemptedDate
						 --,(CASE WHEN (SELECT [WebTest].[dbo].[fnSurveyGetStatus] (3,e.PMID,null)) = 1 THEN 1 ELSE 0 END) AS ReCredentialingStatus
						 --,(SELECT [dbo].[fnSurveyGetFlagsStr](3,e.PMID,null)) AS AttestationFlagStr
FROM            dbo.v_CA_PM_StoresWithEmployeeExclusions AS e /* Training Status from PRS */ LEFT OUTER JOIN
                             (SELECT        NCPDP, [1] AS [HIPAAManualStatus], [2] AS [FWAManualStatus]
                               FROM            (SELECT        NCPDP, CA_TaskID, Status
                                                         FROM            dbo.CA_StoreStatus) AS SourceTable PIVOT (Max(Status) FOR CA_TaskId IN ([1], [2], [3])) AS p) AS p ON 
                         p.NCPDP = e.NCPDP LEFT OUTER JOIN
                             (SELECT        e1.NCPDP, CASE WHEN e1.Employees = h.HIPAATrainedEmployees THEN 1 ELSE 0 END AS HIPAATrainingStatus, 
                                                         CASE WHEN e1.Employees = f.FWATrainedEmployees THEN 1 ELSE 0 END AS FWATrainingStatus, e1.Employees AS EmployeesWithOutAliasNames, 
                                                         h.HIPAATrainedEmployees, f.FWATrainedEmployees
                               FROM            (SELECT        NCPDP, Count(*) AS Employees
                                                         FROM            [WebDev].[dbo].[CA_StoreEmployee]
                                                         WHERE        IsActive = 1 AND EmployeeNameType = 1
                                                         GROUP BY NCPDP) AS e1 LEFT OUTER JOIN
                                                             (SELECT        NCPDP, Count(*) HIPAATrainedEmployees
                                                               FROM            [WebDev].[dbo].[CA_StoreEmployee]
                                                               WHERE        IsActive = 1 AND EmployeeNameType = 1 AND IsHippaTrained = 1
                                                               GROUP BY NCPDP) h ON e1.NCPDP = h.NCPDP LEFT OUTER JOIN
                                                             (SELECT        NCPDP, Count(*) FWATrainedEmployees
                                                               FROM            [WebDev].[dbo].[CA_StoreEmployee]
                                                               WHERE        IsActive = 1 AND EmployeeNameType = 1 AND IsFWATrained = 1
                                                               GROUP BY NCPDP) AS f ON e1.NCPDP = f.NCPDP) AS ehf ON ehf.NCPDP = e.NCPDP /* Attestation Status */ LEFT OUTER JOIN
                             (SELECT        a.pmid, /* Individual Attestation Status */ a.PharmacyNotExcluded, a.PersonnelNotExcluded, a.RecordRetention10yr, a.FWATraining, 
                                                         a.LogPersonnelFWATraining, a.PharmacyMaintainsLicensesInsurance, a.PersonnelMaintainsLicensesCertifications, a.StandardsOfConductInWriting, 
                                                         a.DesignatedComplianceOfficer, a.ProceduresToDetectFWA, CASE WHEN /* Must be attested in current year */ a.Date BETWEEN DATEADD(month, - 6, 
                                                         GETDATE()) AND GETDATE() /* Must not contain any zeros in the following columns */ AND 0 NOT IN (a.PharmacyNotExcluded, 
                                                         a.PersonnelNotExcluded, a.RecordRetention10yr, a.FWATraining, a.LogPersonnelFWATraining, a.PharmacyMaintainsLicensesInsurance, 
                                                         a.PersonnelMaintainsLicensesCertifications, a.StandardsOfConductInWriting, a.DesignatedComplianceOfficer, a.ProceduresToDetectFWA) 
                                                         THEN 1 ELSE NULL END AS AttestationStatus, a.Date AS AttestationDate
                               FROM            /* GET PMIDs with Max Date */ (SELECT        *
                                                                                                                             FROM            (SELECT        *, ROW_NUMBER() OVER (PARTITION BY pmid
                                                                                                                                                       ORDER BY Date DESC) AS rn
                                                                                                                             FROM            cgattestations) AS a
                               WHERE        rn = 1) AS a) AS a ON a.PMID = e.PMID /* OIG & GSA Reports Status */ LEFT OUTER JOIN
    (SELECT        *
      FROM            (SELECT        NCPDP, PMID, IsReportGenerated AS IsOigGsaReportGenerated, IsEmailed AS IsOigGsaReportEmailed, IsSuccess AS IsOigGsaReportSuccess, 
                                                          IsValidEmail AS IsOigGsaReportValidEmail, DateCreated AS LastOigGsaReportGenerationAttemptedDate, ROW_NUMBER() OVER (PARTITION BY 
                                                          NCPDP
                                ORDER BY DateCreated DESC) AS rn
      FROM            [WebDev].[dbo].[CA_ReportEmailedStatus]
      WHERE        (YEAR(DateCreated) = YEAR(getdate()) AND MONTH(DateCreated) = MONTH(getdate())) AND ReportType = 1) AS a
WHERE        rn = 1) AS oiggsareport ON oiggsareport.NCPDP = e.NCPDP AND oiggsareport.PMID = e.PMID

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[32] 2[23] 3) )"
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
         Column = 6360
         Alias = 2280
         Table = 2400
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_CA_StoreStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_CA_StoreStatus'
GO
