USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spCG_EmailPRSFiles]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 4/18/2014
-- Description:	Sending PRS latest file to specific emails or default to roz
--               11/03/2015 modified DG --Replaced Roz's email with CG operations team's group email
--               11/17/2015 modified DG --Moving Compliance Guardian code (in C:\Data)  to T:\Data on uddw1 machine
-- =============================================
CREATE PROCEDURE [dbo].[spCG_EmailPRSFiles] 
(
	@emails NVARCHAR(max) = null
)
	 AS 
BEGIN 

IF @emails is null or @emails = '' BEGIN
	--SET @emails = 'roz.white@uniteddrugs.com'
	SET @emails = 'cgadmins@uniteddrugs.com'
END

EXEC msdb.dbo.sp_send_dbmail
  @profile_name='uddw1',
  @recipients=@emails,
  @subject='PRS latest files: store and employee details',
  @body='Hi,  Here are PRS latest files.',
  @file_attachments='T:\Data\ComplianceGUARDIAN\PRSCommunication\PRS-ResponseStoreDetails.xls;T:\Data\ComplianceGUARDIAN\PRSCommunication\PRS-ResponseEmployeeDetails.xls',
  @body_format = 'HTML' ;

END

/*

EXEC [dbo].[spCG_EmailPRSFiles] 'john.medema@uniteddrugs.com'

*/
GO
