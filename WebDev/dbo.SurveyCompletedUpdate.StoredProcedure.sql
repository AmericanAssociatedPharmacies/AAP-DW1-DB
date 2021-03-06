USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyCompletedUpdate]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 10/22/2014
-- Description:	SurveyCompletedUpdate
               -- 9/22/2015 Attestation 2015 -- checked for SurveyId=39Insert to CA_StoreStatus table DG
				-- 9/24/2015 Attestation 2015 -- Insert surevy responses to Attestation table DG
-- =============================================
CREATE PROCEDURE [dbo].[SurveyCompletedUpdate]
	-- Add the parameters for the stored procedure here
	@SurveyId INT,
	@PMId INT, 
	@Login NVARCHAR(50),
	@Option NVARCHAR(MAX), -- default is ncpdp and base on surveyid to have different 
    @CollectionId INT = 0 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @StatusMsg NVARCHAR(MAX), @NCPDP NVARCHAR(15)  
	DECLARE @StatusId INT   -- 1. Yes, Can Create Survey now, 2. Survey Submitted, 
							-- 3. Not Time Expired, 4. not time yet -- any other constrains that limit from survey to display or create now
							-- 5. go to page with @StatusMsg = url
--- check status 
SET @NCPDP = (SELECT TOP 1 NCPDP FROM dbo.v_CA_PM_AllWithAffiliates WHERE pmid = @PMId)

--IF @SurveyId = 2 BEGIN -- Attestation 2014
IF @SurveyId = 39 BEGIN -- Attestation 2015
	--INSERT INTO dbo.CA_StoreStatus(NCPDP, CA_TaskID, [Status]) VALUES (@NCPDP, 3, 1);
   IF NOT EXISTS (SELECT [Status] FROM CA_StoreStatus 
                   WHERE NCPDP = @NCPDP
                   AND CA_TaskID = 3
                   )
	   BEGIN
		   INSERT INTO dbo.CA_StoreStatus(NCPDP, CA_TaskID, [Status]) VALUES (@NCPDP, 3, 1);


	   END
   ELSE
	   BEGIN
		   UPDATE dbo.CA_StoreStatus
		   SET [Status]=1
		   WHERE NCPDP = @NCPDP
					   AND  CA_TaskID = 3
	   END

--Insert Survey responses into Attestation table	
INSERT INTO Attestation
--(		
--select *
 --into Attestation
 --from (
SELECT    * 
FROM (SELECT     a.PMID, --CASE a.IsSubmitted WHEN 1 THEN 'Submitted' ELSE 'In progress' END AS Note, 
year(getdate()) as AttestationForYear,
'N' as HasFlag,
d.ColumnName, 
(CASE 
WHEN o.html like 'radio' THEN 
(CASE (select top 1 AnswerText from surveyanswer where pmid=a.pmid and optionid in (select id from surveyoption where questionid=q.id) order by id desc) WHEN 'Yes' THEN 'Y' WHEN 'No' THEN 'N'  ELSE 
(select top 1 AnswerText from surveyanswer where pmid=a.pmid and optionid in (select id from surveyoption where questionid=q.id) order by id desc) END) 
ELSE (select top 1 AnswerInput from surveyanswer where pmid=a.pmid and optionid=o.id order by id desc)  END) as Answer

FROM         dbo.SurveyQuestion AS q LEFT OUTER JOIN
                      dbo.SurveyOption AS o ON q.Id = o.QuestionId LEFT OUTER JOIN
                      dbo.SurveyDocument AS d ON d.QuestionId = o.QuestionId LEFT OUTER JOIN
                      dbo.SurveyAnswer AS a ON a.OptionId = o.Id
WHERE     (q.SurveyId = 39) AND (d.Section = 'Attestation') AND (q.IsActive = 1) AND (o.IsActive = 1)
and a.pmid =@PMId
)AS d          
PIVOT( MAX(Answer)
	FOR ColumnName IN (
[Licenses suspended]
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
,[Attestation Date]

)) AS PVTTable
--)as t

--Check if a pharmacy has an attestation flag
UPDATE Attestation
SET HasFlag='Y'
where PMID=@PMId and ([Licenses suspended in past]='Y'
 OR [Disciplinary action]='Y'
 OR [Pharmacist not covered Insurance]='Y'
 OR [PharmacyNotExcluded]='Y'
 OR [Disclosure of disciplinary actions]='N')
END

IF @SurveyId = 3 BEGIN -- Recredentialing
	INSERT INTO dbo.CA_StoreStatus(NCPDP, CA_TaskID, [Status]) VALUES (@NCPDP, 4, 1);
END

IF @SurveyId = 15 BEGIN -- Specialty Participant Confirmation

	-- SELECT Top 1 AnswerInput from dbo.SurveyAnswer WHERE pmid = 104339 AND OptionId = 245 ORDER BY DateTimeEnter DESC
	DECLARE @ActualGoLiveDate DATETIME 
	SET @ActualGoLiveDate = (SELECT Top 1 AnswerInput from dbo.SurveyAnswer WHERE pmid = @PMId AND OptionId = 245 ORDER BY DateTimeEnter DESC); -- need to extract from survey 15 and @pmid

	INSERT INTO PharmacyMaster..PM_ProgramStepMember (PMID, ProgramID, ProgramStepID, StartDate, EndDate) VALUES (@PMId, 183, 4, ISNULL(@ActualGoLiveDate, GETDATE()), NULL);

	-- may also need to update other legacy if we need to here in pharmacymaster

END


IF @SurveyId = 25 BEGIN

	UPDATE a SET a.IsSubmitted = 1
	FROM dbo.SurveyAnswer a INNER JOIN dbo.surveyoption o ON a.OptionId = o.Id
		INNER JOIN dbo.surveyquestion q ON o.QuestionID = q.Id
	WHERE q.SurveyId IN (17,23,24,25,26,27,28,31,32,33) 
			AND a.PMID IN(@PMId)

	UPDATE r SET r.IsSubmitted = 1
	FROM dbo.SurveyOwnerRelationship r 
	WHERE r.SurveyControlEntityId IN (SELECT e.ID FROM dbo.SurveyControlEntity e WHERE e.PMID IN(@PMId));


	UPDATE o SET o.IsSubmitted = 1
	FROM dbo.SurveyOwnership o 
	WHERE o.SurveyControlEntityId IN (SELECT e.ID FROM dbo.SurveyControlEntity e WHERE e.PMID IN(@PMId));

	UPDATE c SET c.IsSubmitted = 1
	FROM dbo.SurveyControlEntityCert c 
	WHERE c.ControlEntityId IN (SELECT e.ID FROM dbo.SurveyControlEntity e WHERE e.PMID IN(@PMId));

	UPDATE e SET e.IsSubmitted = 1
	FROM dbo.SurveyControlEntity e WHERE e.PMID IN(@PMId);

END


-- set status id and status msg
-- SELECT @IsSubmitted, @SurveyId, @IsSurvey10Submitted

SELECT 
	@StatusId = 1 
--(CASE WHEN @IsSubmitted = 1 AND @SurveyId = 4 AND @IsSurvey10Submitted = 0 THEN 5 WHEN @IsSubmitted = 1 THEN 1 ELSE 0 END)
	,@StatusMsg = '' 
/*( CASE WHEN @IsSubmitted = 1 AND ( (@SurveyId = 4 AND @IsSurvey10Submitted = 1) OR @SurveyId = 10 ) THEN 'This pharmacy has completed the AAP Specialty Pharmacy training and requests the go-live date on ' + CONVERT(VARCHAR(10), ISNULL(@GoliveDate,''), 101) + '. Please process them and confirm when they are operational.'
								 --WHEN @IsSubmitted = 1 AND @SurveyId = 4 AND @IsSurvey10Submitted = 0 THEN '/survey/surveyweb/#/viewSurvey10?surveyid=10&login=' + @Login + '&pmid=' + CAST(@PMId AS NVARCHAR(15))
								 WHEN @IsSubmitted = 1 AND @SurveyId = 4 AND @IsSurvey10Submitted = 0 THEN '#/viewSurvey10?surveyid=10&login=' + @Login + '&pmid=' + CAST(@PMId AS NVARCHAR(15))
								 WHEN @IsSubmitted = 1 AND @SurveyId = 9 THEN 'Your enrollment has been completed.' 
								 WHEN @IsSubmitted = 1 THEN 'Your survey submission has been received.' 
								 -- ELSE '' + CAST(@IsSubmitted AS NVARCHAR(15)) + CAST(@SurveyId AS NVARCHAR(15)) + CAST(@IsSurvey10Submitted AS NVARCHAR(15)) END);
								 ELSE '' END);
*/

	SELECT @StatusId StatusId, @StatusMsg StatusMsg, @@Error Errors
/****
-- SELECT * FROM dbo.SurveyAnswer

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyCompletedUpdate]
			@SurveyId = 10,
			@PMId =104339,
			@Login = 'itdev3',
			@Option = ''

SELECT	'Return Value' = @return_value

SELECT Top 1 * FROM PharmacyMaster..PM_ProgramStepMember  WHERE  ProgramID = 183 AND ProgramStepID = 3

*/
END

GO
