USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_ParentOrganization]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ParentOrganization]

AS


SELECT ParentOrganizationKey, ParentOrganizationID, ParentOrganizationName, Address1, Address2, City, StateCode, ZipCode
, PhoneNumber, Extension, FAXNumber, ParentOrganizationNPI, ParentOrganizationFederalTaxID, ContactName, ContactTitle
, EmailAddress
, CASE	
	WHEN DeleteDate = '00000000' THEN '29991231'
	ELSE RIGHT(DeleteDate, 4) + LEFT(DeleteDate, 2) +  SUBSTRING(DeleteDate,3,2)
	END AS DeleteDate
, RowCreatedDate
FROM [dbo].[ParentOrganization]
GO
