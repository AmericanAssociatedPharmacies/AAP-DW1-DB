USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_PM_AddressMaster_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_PM_AddressMaster_Load]

AS

/*******************************************************************************

-- Author: Scott Edwards
-- Description: Used to get data for PharmacyMaster ETL.
-- InParameter: N\A
-- OutParameter: N\A
-- Created Date: 04/23/2018
-- Revision History :
-- Modified Date Modified By version Description
-- Test code: Execute sproc as is.

********************************************************************************/

SET NOCOUNT ON;

BEGIN

	MERGE dbo.PM_AddressMaster AS t
	USING Staging.PM_AddressMaster AS s  ON t.PMID = s.PMID
													AND t.Address_Type_Id = s.Address_Type_Id
	WHEN MATCHED THEN
	UPDATE SET PMID = s.PMID
	, Address_Type_Id = s.Address_Type_Id
	, [Address] = s.[Address]
	, Address2 = s.Address2
	, City = s.City
	, County = s.County
	, [State] = s.State
	, Zip = s.Zip
	, ContactFullName = s.ContactFullName
	, Fax = s.Fax
	, Phone = s.Phone
	, AlternatePhone = s.AlternatePhone
	, Email = s.Email
	, Modified = s.Modified
	, [RowVersion] = s.[Rowversion]

	WHEN NOT MATCHED THEN
	INSERT(PMID, Address_Type_Id, [Address], Address2, City, County, [State]
											, Zip, ContactFullName, Fax, Phone, AlternatePhone, Email, Modified, [RowVersion]
											)
	VALUES(s.PMID, s.Address_Type_Id, s.[Address], s.Address2, s.City, s.County, s.[State]
											, s.Zip, s.ContactFullName, s.Fax, s.Phone, s.AlternatePhone, s.Email, s.Modified, s.[RowVersion]
											);
	

END

GO
