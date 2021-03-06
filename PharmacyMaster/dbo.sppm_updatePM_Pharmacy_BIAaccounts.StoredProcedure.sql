USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_updatePM_Pharmacy_BIAaccounts]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <03/29/2010>
-- Description:	Backup and Truncate PM_Cred to recreate
-- =============================================
CREATE PROCEDURE [dbo].[sppm_updatePM_Pharmacy_BIAaccounts]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  --HERE 106675 is the new account and 102904 is the old accounts 
-- This will move the APIAccountNo to the new one (Linda puts a -BIA on the old one) and it will fix the PM_APIAccounts table
	 --select * from pm_pharmacy where pmid = 106675 --19137515
--
--select * from pm_pharmacy where pmid = 102904
-- 
--select * from pm_apiaccounts where pmid = 106675
--select * from pm_apiaccounts where pmid = 102904
--
--update pm_pharmacy set apiaccountno = '19137515' where pmid = 106675
--update pm_pharmacy set apistatus = 'ACTIVE' where pmid = 106675
--update pm_pharmacy set isWarehouse =  -1 where pmid = 106675
--update pm_pharmacy set BusinessClass =  'C00' where pmid = 106675
--
-- select * from pm_apiaccounts where apiaccountno = '03200081'
-- update pm_apiaccounts set pmid = 106692 where apiaccountno = '03200081'
-- update pm_apiaccounts set date = null where apiaccountno = '03200081'

 
END








GO
