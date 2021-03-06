USE [WebDev]
GO
/****** Object:  View [dbo].[v_Survey_CA_StoreStatus]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Survey_CA_StoreStatus]
AS

SELECT    --e.*     
e.PMID, e.NCPDP, e.AccountName, e.OwnerName, e.IsStoreComplianceGuardian,  e.IsStoreAAP,  
e.IsStoreNPP, e.Employees, e.EmployeeLastModifiedDate, e.EmployeeLastCreatedDate, e.ExclusionLastFoundDate, e.Exclusions, e.ComplianceGuardianStartDate, 
                      e.Phone, e.Email, e.Fax, e.NPI, e.AAPAccountNo, e.ChainCode, 
                      e.MCQuitDate, e.AAPQuitDate, e.IsNPP, e.TMFirstName, e.TMLastName, e.TM
,  /* Employee CheckList Step 1 Status */ CASE WHEN e.Employees > 0 THEN 1 ELSE 0 END AS EmployeeCheckListStatus, 
CASE WHEN p.HIPAAManualStatus IS NULL THEN 0 ELSE p.HIPAAManualStatus END AS HIPAAManualStatus, CASE WHEN p.FWAManualStatus IS NULL 
THEN 0 ELSE p.FWAManualStatus END AS FWAManualStatus, CASE WHEN ehf.HIPAATrainingStatus IS NULL 
THEN 0 ELSE ehf.HIPAATrainingStatus END AS HIPAATrainingStatus, CASE WHEN ehf.FWATrainingStatus IS NULL 
THEN 0 ELSE ehf.FWATrainingStatus END AS FWATrainingStatus, CASE WHEN ehf.EmployeesWithOutAliasNames IS NULL 
THEN 0 ELSE ehf.EmployeesWithOutAliasNames END AS EmployeesWithOutAliasNames, CASE WHEN ehf.HIPAATrainedEmployees IS NULL 
THEN 0 ELSE ehf.HIPAATrainedEmployees END AS HIPAATrainedEmployees, CASE WHEN ehf.FWATrainedEmployees IS NULL 
THEN 0 ELSE ehf.FWATrainedEmployees END AS FWATrainedEmployees, 
a.AttestationForYear,
CASE WHEN a.[Attestation Date] is null then 0 else 1 end as AttestationStatus
,CONVERT(varchar, a.[Attestation Date], 101) as [Attestation Date]
,a.[Licenses suspended]
,a.[Operate on Clear status]
,a.[Licenses suspended in past]
,a.[Disciplinary action]
,a.[Pharmacist not covered Insurance]
,a.[Pharmacists unrestricted license]
,a.[PharmacyNotExcluded]
,a.[PersonnelNotExcluded]
,a.[Review Personnel on OIG GSA]
,a.[Disclosure of disciplinary actions]
,a.[RecordRetention10yr]
,a.[FWATraining]
,a.[LogPersonnelFWATraining]
,a.[PharmacyMaintainsLicensesInsurance]
,a.[PersonnelMaintainsLicensesCertifications]
,a.[StandardsOfConductInWriting]
,a.[Conflict of Interest Policy]
,a.[DesignatedComplianceOfficer]
,a.[ProceduresToDetectFWA]
,a.[OBRA 90 rules compliance]
--,a.[NCPDP]
,a.[Pharmacy Name]
--,a.[NPI]
,a.[Person Attesting]
,a.[Compliance Officer name]
,a.HasFlag
-- ,[dbo].[fnSurveyIsCompletedInt] (3,e.PMID,null) ReCredentialingStatus -- need to update here
,[dbo].[fnSurveyGetFlagsStr](39,e.PMID,null) AttestationFlagStr -- need to update here
,oiggsareport.IsOigGsaReportGenerated, 
oiggsareport.IsOigGsaReportEmailed, oiggsareport.IsOigGsaReportSuccess, oiggsareport.IsOigGsaReportValidEmail, 
oiggsareport.LastOigGsaReportGenerationAttemptedDate
FROM	dbo.v_CA_PM_StoresWithEmployeeExclusions AS e /* Training Status from PRS */ 
LEFT OUTER JOIN
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
(SELECT        a.PMID,AttestationForYear,HasFlag,[Licenses suspended]
,[Operate on Clear status]
,[Licenses suspended in past]
,[Disciplinary action]
,[Pharmacist not covered Insurance]
,[Pharmacists unrestricted license]
,[PharmacyNotExcluded]
,[PersonnelNotExcluded]
,[Review Personnel on OIG GSA]
,[Disclosure of disciplinary actions]
,[RecordRetention10yr]
,[FWATraining]
,[LogPersonnelFWATraining]
,[PharmacyMaintainsLicensesInsurance]
,[PersonnelMaintainsLicensesCertifications]
,[StandardsOfConductInWriting]
,[Conflict of Interest Policy]
,[DesignatedComplianceOfficer]
,[ProceduresToDetectFWA]
,[OBRA 90 rules compliance]
,[NCPDP]
,[Pharmacy Name]
,[NPI]
,[Person Attesting]
,[Compliance Officer name]
,CONVERT(varchar, [Attestation Date], 101) as [Attestation Date] /* Individual Attestation Status */ 

FROM            /* GET PMIDs with Max Date */ (SELECT        *
FROM            (SELECT        *, ROW_NUMBER() OVER (PARTITION BY pmid
ORDER BY AttestationForYear DESC) AS rn
FROM            Attestation) AS a
WHERE        rn = 1) AS a) AS a ON a.PMID = e.PMID /* OIG & GSA Reports Status */ LEFT OUTER JOIN
(SELECT        *
FROM            (SELECT        NCPDP, PMID, IsReportGenerated AS IsOigGsaReportGenerated, IsEmailed AS IsOigGsaReportEmailed, IsSuccess AS IsOigGsaReportSuccess, 
IsValidEmail AS IsOigGsaReportValidEmail, DateCreated AS LastOigGsaReportGenerationAttemptedDate, ROW_NUMBER() OVER (PARTITION BY 
NCPDP
ORDER BY DateCreated DESC) AS rn
FROM            [WebDev].[dbo].[CA_ReportEmailedStatus]
WHERE        (YEAR(DateCreated) = YEAR(getdate()) AND MONTH(DateCreated) = MONTH(getdate())) AND ReportType = 1) AS a
WHERE        rn = 1) AS oiggsareport ON oiggsareport.NCPDP = e.NCPDP AND oiggsareport.PMID = e.PMID
where e.IsStoreNonManagedCare=0
and e.ComplianceGuardianEndDate is null 


GO
