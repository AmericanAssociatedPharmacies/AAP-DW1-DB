USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_NCPDP_FileProcessed]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_NCPDP_FileProcessed]

AS

SET NOCOUNT ON;

BEGIN


DECLARE @Loop INT = 1
DECLARE @FileProcessed varchar(150)
DECLARE @SQL varchar(MAX)
DECLARE @FileName varchar(15)
DECLARE @TableName varchar(150)
DECLARE @TotalCount INT
DECLARE @NCPDP TABLE (ID INT IDENTITY, TblName varchar(150), FileName varchar(15))

INSERT INTO @NCPDP

SELECT TABLE_SCHEMA + '.' + TABLE_NAME, CASE TABLE_NAME WHEN 'NCPDP_ChangeofOwnershipInformation' THEN 'mas_coo.txt'
			           WHEN 'NCPDP_EPrescribingInformation' THEN 'mas_erx.txt'
			           WHEN 'NCPDP_FraudWasteandAbuseTrainingAttestation' THEN 'mas_fwa.txt'
			           WHEN 'NCPDP_MedicaidInformation' THEN 'mas_md.txt'
			           WHEN 'NCPDP_ParentOrganization' THEN 'mas_pr.txt'
			           WHEN 'NCPDP_PaymentCenterInformation' THEN 'mas_pc.txt'
			           WHEN 'NCPDP_ProviderInformation' THEN 'mas.txt'
			           WHEN 'NCPDP_ProviderRelationship' THEN 'mas_rr.txt'
			           WHEN 'NCPDP_RelationshipDemographicInformation' THEN 'mas_af.txt'
			           WHEN 'NCPDP_RemitAndReconciliation' THEN 'mas_rec.txt'
			           WHEN 'NCPDP_ServicesOffered' THEN 'mas_svc.txt'
			           WHEN 'NCPDP_StateLicense' THEN 'mas_stl.txt'
			           WHEN 'NCPDP_Taxonomy' THEN 'mas_tx.txt'
			 END AS FileName
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME like '%NCPDP%'

SET @TotalCount = @@ROWCOUNT

WHILE @Loop <= @TotalCount
BEGIN

SELECT @TableName = TblName, @FileName = FileName
FROM @NCPDP
WHERE ID = @Loop

SELECT @FileProcessed = FileDirectory + '\' + LEFT(FileName,LEN(FileName)-4) + CONVERT(varchar(10), FileCreateTime, 112) + '.txt'
FROM mtvf_GetFileInfo('\\fs1.aap.local\server\IT Department\NCPDP\Staging')
WHERE FileName = @FileName

SET @SQL = 'UPDATE ' + @TableName + ' SET FileProcessed = ''' + @FileProcessed + ''''
EXEC (@SQL)
--PRINT @SQL 
SET @Loop = @Loop + 1

END

END

GO
