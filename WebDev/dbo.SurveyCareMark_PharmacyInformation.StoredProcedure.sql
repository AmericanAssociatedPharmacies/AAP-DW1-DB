USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyCareMark_PharmacyInformation]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John, Ngo
-- Create date: 4/3/2015
-- Description:	Generate The Excel Credentialing File for CareMark
-- =============================================
CREATE PROCEDURE [dbo].[SurveyCareMark_PharmacyInformation]
	@PMId INT,
	@Opt INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--DECLARE @PMId INT
DECLARE @SurveyId INT
--SELECT @PMId = 106489
SELECT @SurveyId = 25

DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
DECLARE @ColumnName AS NVARCHAR(MAX)

SELECT @ColumnName= ISNULL(@ColumnName + ',','') 
       + QUOTENAME(ColumnName)
FROM dbo.SurveyDocument 
WHERE DocumentName = 'credentialing2015' AND Section = 'pharmacy' AND IsActive = 1
ORDER BY [Index]

-- SELECT @ColumnName

--Prepare the PIVOT query using the dynamic 
SET @DynamicPivotQuery = 
  N'SELECT *
FROM (SELECT (CASE WHEN QuestionId IS NULL THEN DefaultValue ELSE [dbo].[fnSurveyGetAnswerByQuestion](QuestionId,' + CONVERT(NVARCHAR,@PMId) + ' ,' + CONVERT(NVARCHAR,@SurveyId) + ' ,0,NULL) END) AS Answer,ColumnName
FROM dbo.SurveyDocument WHERE DocumentName = ''credentialing2015'' AND Section = ''pharmacy'' AND IsActive = 1
) AS d          
PIVOT( MAX(Answer)             
	FOR ColumnName IN (' + @ColumnName + ')) AS PVTTable'
--Execute the Dynamic Pivot Query

---SELECT @DynamicPivotQuery

EXEC sp_executesql @DynamicPivotQuery


END

/*
	SELECT '' [Action], '' LocationType, '' [Effective Date],'' [Legal Name], '' DBA, '' FEIN, '' [Store Number]
	,'' [Address],'' [Address 2],'' City,''  [State],''  Zip  
	,'' [Mailing Address],'' [Mailing Address 2],'' [Mailing City],''  [Mailing State],''  [Mailing Zip]
	,'' Phone, '' Fax, '' [Toll Free], '' [TTY/TDD], '' Email, '' URL 
	,'' [Authorized Contact], '' Title, '' [Contact Phone]
	,'' NPI,'' NCPDP1, '' [Multiple NCPDP], '' [NCPDP2], '' [NCPDP3], '' DEA, '' [DEA Expiration]
	,'' [State License], '' [State License Expiration], '' [Policy Insurer], '' [Policy Number], '' [Policy Expiration], '' [Policy Limits]
	,'' [Medicaid ID1],'' [Medicaid State1],'' [Medicaid ID2],'' [Medicaid State2],'' [Medicaid ID3],'' [Medicaid State3]
	,'' [24 Hrs],'' [7 Days],'' [Emergency],'' [Emergency Phone],'' [Drive Thru],'' [Delivery],'' [Delivery Charges]
	,'' [Clinic],'' [Pressure],'' [Written Consultation],'' [Med Consulation],'' [Compliance],'' [Disease]  ,'' [Infusion],'' [Vision],'' [Tabacco]
	,'' [Monday],'' [Tuesday],'' [Wednesday],'' [Thursday],'' [Friday],'' [Saturday],'' [Sunday]
	,'' [Language],'' [Printed],'' [ASL],'' [Braille],'' [Translation],'' [Dispense 340B],'' [340 Owned],'' [340B Contracted]  
	,'' [Accessible],'' [Distance],'' [ADA],'' [DME],'' [DME Type],'' [DMEPOS],'' [VIPPS],'' [Retail],'' [Pharm Type],'' [Mail]
	,'' [PCAB],'' [ISMP],'' [Errors],'' [MedB],'' [Assignment],'' [MedD],'' [Electronic Coordination]  
	,'' [Long Term Care],'' [Home Infusion],'' [Update NCPDP]
	,'' [Ownership Type],'' [Ownership Change],'' [Owner Pharmacist],'' [Good Standing],'' [Denied],'' [Criminal Offense],'' [Excluded]
*/

GO
