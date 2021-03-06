USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_exec_EmailNotifications]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Vrindha Nair>
-- Create date: <09-03-2014>
-- Description:	To generate csv files for email attachments.
-- =============================================
CREATE PROCEDURE [dbo].[sppm_exec_EmailNotifications]

	-- Add the parameters for the stored procedure here
      (@ChainCode int, @DT datetime)

AS
BEGIN


SELECT    PM_Modifications.ModType AS ACTION, 
		  CONVERT(varchar(10), GETDATE(), 101) AS EFFECTIVE, 
		  PM_Modifications.Reason AS WHY_MODIFIED, 
          --preserves the leading zeros in excel, can use any of these: CHAR(28), CHAR(29), CHAR(30), CHAR(31)
          --  Will not work for xml format.
		  CHAR(30) + v_AAPAccounts_Notification .NCPDP AS NCPDP,
		  v_AAPAccounts_Notification .ChainCode AS CHAIN_CODE,  
		  v_AAPAccounts_Notification .storename AS PHARMACY_NAME,  
		  v_AAPAccounts_Notification .aapid AS UD_ACCT,  
		 (CASE WHEN  LEN(addr2)>0
		  THEN LTRIM(RTRIM(addr1)) + ',' + ' '+ LTRIM(RTRIM( addr2 ))
		  ELSE LTRIM(RTRIM(addr1))
		  END ) AS ADDR1,
		  pm_addressmaster.Address AS ADDR2, 
		  v_AAPAccounts_Notification .COUNTY AS COUNTY , 
		  v_AAPAccounts_Notification .CITY AS CITY, 
		  v_AAPAccounts_Notification .STATE AS STATE , 
		  CHAR(30) + v_AAPAccounts_Notification .ZIP AS ZIP, 
		  v_AAPAccounts_Notification .ownerfirst AS CONTACT_FNAME, 
		  v_AAPAccounts_Notification .ownerlast AS CONTACT_LNAME,  
		  v_AAPAccounts_Notification .AreaCode AS VOICE_AREA,  
		  v_AAPAccounts_Notification .phone AS VOICE_LOCAL, 
		  v_AAPAccounts_Notification .FaxAreaCode AS FAX_AREA, 
		  v_AAPAccounts_Notification .fax AS FAX_LOCAL, 
		  CHAR(30) + v_AAPAccounts_Notification .StateLicNo AS STATE_LICENSE_NUMBER, 
		  CONVERT(varchar(10),  v_AAPAccounts_Notification .StateLicExpDate, 101)  AS STATE_LICENSE_EXPIRATION_DATE,
		  v_AAPAccounts_Notification .DEA AS DEA_NUMBER, 
		  CONVERT(varchar(10), v_AAPAccounts_Notification .DEAEXP, 101) AS DEA_EXPIRATION_DATE, 
		  CHAR(30) + v_AAPAccounts_Notification .StateMedicaidNo AS STATE_MEDICAID_NUMBER, 
		  v_AAPAccounts_Notification .GroupDesignation AS GROUP_DESIGNATION,  
		  v_AAPAccounts_Notification .HolidayHours AS HOLIDAY_HOURS,  
		  v_AAPAccounts_Notification .ProfLiabCarrier AS CARRIER, 
		  v_AAPAccounts_Notification .ProfPolicyNumber AS POLICY_NUMBER, 
		  v_AAPAccounts_Notification .ProfLiabLimit1 AS LIABILITY_LIMIT_1,  
		  v_AAPAccounts_Notification .ProfLiabLimit2 AS LIABILITY_LIMIT_2,  
		  CONVERT(varchar(10),  v_AAPAccounts_Notification .ProfLiabInsExpDate, 101) AS INSURANCE_EXPIRATION_DATE,
		  PM_Pharmacists.PharFullName AS PHARMACIST_IC_NAME, 
		  PM_Pharmacists.PharTitle AS PHARMACIST_IC_TITLE,  
		  CHAR(30) + PM_Pharmacists.PharLicNo AS LICENSE_NUMBER,
		  CONVERT(varchar(10), PM_Pharmacists.PharExpDate, 101)AS LICENSE_EXPIRATION_DATE,  
	      v_AAPAccounts_Notification .NPI AS NPI 
				 FROM PharmacyMaster.dbo.v_AAPAccounts_Notification  
				 left join PharmacyMaster.dbo.PM_Pharmacists 
				 ON v_AAPAccounts_Notification .PMID = PM_Pharmacists.PMID 
				 left join PharmacyMaster.dbo.PM_Modifications 
				 ON v_AAPAccounts_Notification .PMID = PM_Modifications.PMID 
				  left join PharmacyMaster.dbo.pm_addressmaster 
				 ON v_AAPAccounts_Notification .PMID = pm_addressmaster.PMID 
				 WHERE v_AAPAccounts_Notification .ChainCode = + @ChainCode and PM_Modifications.ModDate >= + @DT 
                       and (PharPrime <> '0' or PM_Pharmacists.PMID is NULL) and address_type_id = '2' 
				 ORDER BY modtype desc, NCPDP -- PharPrime <> '0' or

END
GO
