USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spCM_GetDistributionList]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 4/18/2014
-- Description:	Get the distribution get for communication master
-- =============================================
CREATE PROCEDURE [dbo].[spCM_GetDistributionList] 
(
	@PMIds as nvarchar(max) = '', -- 1,2,46
	@CorpIds as nvarchar(max) = '' -- 1,2,46
)
	 AS 
BEGIN 

SELECT DISTINCT * 
FROM 
(	(SELECT  DISTINCT PMID, 0 As CorpId,Source, AccountName, MCEffectiveDate,AAPEffectiveDate, 
			Addr1,   Addr2, City, [State], Zip, ContactFullName,  
			Territory, Phone,  Fax, Email, Status, BusinessClass, AAPAccountNo, 
			AAPParentNo, APIAccountNo,   
			ChainCode, aapstatus, 
			apistatus, -- ,GroupID,group_name 
			mcquitdate,
			dea,ncpdp,npi,statelicno,
			computersoftware,GroupNo
		FROM	
			dbo.v_pm_allwithaffiliates 
			-- dbo.pm_pharmacy 
			-- dbo.v_Address_Mailing_ListGen_NEW_PM
		WHERE Exists (SELECT IdInt from dbo.Split(@PMIds,',') WHERE IdInt = PMID)
    )
	UNION  
	(SELECT DISTINCT cast('' as varchar(10)) as PMID,am.CorpId as CorpId,am.Source,am.AccountName,cast(null as datetime)as MCEffectiveDate,
			cast(null as datetime)as AAPEffectiveDate,am.Addr1,am.Addr2,am.City,am.State,am.Zip,am.ContactFullName,  
			am.Territory,am.Phone,am.Fax,am.Email,am.Status,am.BusinessClass,am.AAPAccountNo
			,AAPParentNo,  am.APIAccountNo, 
			cast('' as varchar(10)) as ChainCode,cast('' as varchar(10)) as aapstatus,  
			cast('' as varchar(10)) as apistatus, --,cast('' as varchar(25)) as GroupID,cast('' as varchar(10)) as group_name
			cast(null as datetime)as mcquitdate,  
			cast('' as varchar(35)) as dea, cast('' as varchar(35)) as ncpdp ,cast('' as varchar(35)) as npi,cast('' as varchar(35))as statelicno,
			cast('' as varchar(100))as computersoftware,cast('' as varchar(50))as GroupNo
	FROM PM_Corporate am 
	WHERE am.CorpId IN (SELECT IdInt from dbo.Split(@CorpIds,','))
	)
) List

END

/*

EXEC [dbo].[spCM_GetDistributionList] '',''

*/
GO
