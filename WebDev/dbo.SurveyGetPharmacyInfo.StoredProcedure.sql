USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetPharmacyInfo]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 8/29/2014
-- Description:	SurveyGetPharmacyInfo
				--added member status field 09/03/2015 DG
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetPharmacyInfo]
	-- Add the parameters for the stored procedure here
	@PMID INT = 0, 
	@NCPDP NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT TOP 1 * FROM dbo.v_CA_PM_AllWithAffiliates WHERE PMID = @PMID;

SELECT TOP 1 a.*,  case when t.isAAP=1 then
   case when t.isMCorNPP=1 then 'AAP Member and Managed Care participant' else 'AAP Member only' end 
else case when t.isMCorNPP=1 then 'Managed Care participant only' else 'Not in AAP or Managed Care, please review' end end [MCorAAP]
FROM dbo.v_CA_PM_AllWithAffiliates a left join
PharmacyMaster.dbo.v_test t on a.pmid=t.pmid
WHERE a.PMID = @PMID;

--




    -- Insert statements for procedure here
/*
	SELECT TOP 1 PMID, NCPDP, AccountName, IsStoreComplianceGuardian, IsStoreStaffGuard, IsStoreAAP, IsStoreManagedCare, IsStoreNonManagedCare, IsStoreNPP, Email, OwnerName, Addr1, Addr2, City, State, Zip, Phone, Fax, NPI, ComplianceGuardianStartDate, ComplianceGuardianEndDate, StaffGuardStartDate, StaffGuardEndDate, AAPAccountNo, ChainCode, MCQuitDate, AAPQuitDate, IsNPP, rn
	FROM [dbo].[v_CA_PM_Stores] store 
		WHERE	store.PMID = (CASE WHEN @PMID > 0 THEN @PMID ELSE store.PMID END)
				AND store.NCPDP = (CASE WHEN LEN(@NCPDP) > 1 THEN @NCPDP ELSE store.NCPDP END)
*/

/*

SELECT TOP 1 * FROM [dbo].[v_CA_PM_Stores] where PMID = 100001

SELECT TOP 1 * FROM [PharmacyMaster].[dbo].[PM_Pharmacy] WHERE PMID = 100002 NCPDP = '1234567'

SELECT TOP 1 NCPDP, NPI, AccountName, * FROM dbo.v_CA_PM_AllWithAffiliates WHERE PMID = 100002

SELECT TOP 1 * FROM dbo.v_CA_PM_AllWithAffiliates WHERE NCPDP = '1234567'


GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyGetPharmacyInfo]
		@PMID = 100001, @NCPDP = '0102462'

SELECT	'Return Value' = @return_value

GO
*/
END
GO
