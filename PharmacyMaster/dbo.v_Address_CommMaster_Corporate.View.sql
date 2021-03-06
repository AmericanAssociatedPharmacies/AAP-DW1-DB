USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_Address_CommMaster_Corporate]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Address_CommMaster_Corporate]
AS

 SELECT cast('' as varchar(10)) as PMID,Source,AccountName,cast('' as varchar(255)) as AccountDescription,
	cast(null as datetime)as AAPEffectiveDate,cast(null as datetime)as AAPQuitDate,cast(null as datetime)as MCEffectiveDate,cast(null as datetime)as mcquitdate,
   cast('' as varchar(10)) as ChainCode,  Addr1,Addr2,City,State,Zip,ContactFullName,  
	Territory,Phone,Fax,Email,Status,BusinessClass,AAPAccountNo,AAPParentNo, 
	APIAccountNo, cast('' as varchar(25)) as GroupID,   
	cast('' as varchar(10)) as aapstatus,  
	cast('' as varchar(10)) as apistatus ,cast('' as varchar(10)) as group_name,
	cast('' as varchar(35)) as dea, cast('' as varchar(35)) as ncpdp ,cast('' as varchar(35)) as npi,cast('' as varchar(35))as statelicno,
	cast('' as varchar(100))as computersoftware,cast('' as varchar(50))as GroupNo, 
	cast('' as varchar(35)) as StateMedicaidNo,cast(null as datetime)as StateLicExpDate,
	cast(null as datetime) as DEAExp,cast('' as varchar(35))as FedID,  cast(null as datetime) as isNPP,cast('' as varchar(35))as DoNotFax,
    cast('' as varchar(35))as CommunicationPreference, cast('' as varchar(35))as  VendorName, cast('' as varchar(526))as Programs
	FROM pharmacymaster..PM_Corporate

GO
