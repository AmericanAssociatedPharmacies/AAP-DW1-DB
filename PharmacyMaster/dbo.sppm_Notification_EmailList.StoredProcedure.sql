USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_Notification_EmailList]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Vrindha Nair>
-- Create date: <07-24-2014>
-- Description:	<Generates email recipients from MaxDB for notifications>
-- =============================================
CREATE PROCEDURE [dbo].[sppm_Notification_EmailList] 
	-- Add the parameters for the stored procedure here
	(@in_678 varchar(2), @in_783 varchar(2))

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   
	DECLARE @SQL_Query   varchar(5000);
	DECLARE @SQL   varchar(5000);
	SET @SQL_Query = ''' SELECT united.contact.EMAIL, 
	Min(united.plan_contract.INCLUDES_RURAL) AS INC_678, 
	Min(united.plan_contract.INCLUDES_ALASKA) AS INC_783
	FROM united.plan_contract 
	  INNER JOIN united.contact 
	  ON united.plan_contract.CONTRACT_ID = united.contact.XREF_ID
	WHERE united.contact.XREF_TYPE=''''C''''
	  AND united.contact.CONTACT_TYPE=''''NOTIFY''''
	  AND united.plan_contract.NOTIFY <> 0 
	  AND united.plan_contract.ACTIVE <> 0
	  AND united.plan_contract.INCLUDES_RURAL =  ' + @in_678 + 
	' AND united.plan_contract.INCLUDES_ALASKA =  ' + @in_783 + 
	' GROUP BY united.contact.EMAIL
	HAVING united.contact.EMAIL Is Not Null ''' ;

--print @SQL_Query

-- Below sends the email 4 times, regardless of the conditions
--SET @SQL = '
--		select distinct * from openquery(uniteddb,' + @SQL_Query +
--		')' +
--		' UNION select ''plannotify@uniteddrugs.com'', -1, -1 from pharmacymaster..pm_pharmacy';
--
-- exec (@SQL);

-- This sends out email to 'plannotify@uniteddrugs.com' only when the condition is this: @in_678 = '-1' and @in_783 = '-1' 

SET @SQL = '
select distinct * from openquery(uniteddb,' + @SQL_Query +
')' ;
if(@in_678 = '-1' and @in_783 = '-1' )
BEGIN
SET @SQL = @SQL + ' UNION select ''plannotify@areterx.com'', -1, -1 from pharmacymaster..pm_pharmacy';
END 

exec (@SQL);

 

END
GO
