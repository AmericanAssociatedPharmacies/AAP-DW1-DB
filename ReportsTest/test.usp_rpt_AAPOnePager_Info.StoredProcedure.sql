USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_AAPOnePager_Info]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_rpt_AAPOnePager_Info]
AS
SET NOCOUNT ON;
SELECT 
t1.AccountName
,t1.AAPAccountNo
,t1.APIAccountNo
,t1.NCPDP
,t1.MailAddr1 
,t1.MailAddr2 
,t1.MailCity 
,t1.MailState 
,t1.MailZip 
,COUNT(t3.ProgramID) AS TotalPrograms
FROM [PharmacyMaster].dbo.v_PM_AllWithAffiliates AS t1
JOIN [PharmacyMaster].dbo.PM_MemberPrograms AS t2 ON t2.PMID = t1.PMID
JOIN [PharmacyMaster].dbo.PM_Programs AS t3 ON t3.ProgramID = t2.ProgramID
GROUP BY 
t1.AccountName
,t1.AAPAccountNo
,t1.APIAccountNo
,t1.NCPDP
,t1.MailAddr1 
,t1.MailAddr2 
,t1.MailCity 
,t1.MailState 
,t1.MailZip
ORDER BY t1.AccountName
GO
