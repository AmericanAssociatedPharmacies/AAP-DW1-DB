USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ParentOrganization_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ParentOrganization_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[ParentOrganization] AS T
	USING (SELECT [ParentOrganizationID], [ParentOrganizationName], [Address1], [Address2], [City], [StateCode], [ZipCode], [PhoneNumber], [Extension], [FAXNumber], [ParentOrganizationNPI]
				, [ParentOrganizationFederalTaxID], [ContactName], [ContactTitle], [EmailAddress], [DeleteDate]
		   FROM [Staging].[vw_NCPDP_ParentOrganization]) AS S
				([ParentOrganizationID], [ParentOrganizationName], [Address1], [Address2], [City], [StateCode], [ZipCode], [PhoneNumber], [Extension], [FAXNumber]
				, [ParentOrganizationNPI], [ParentOrganizationFederalTaxID], [ContactName], [ContactTitle], [EmailAddress], [DeleteDate])
		  ON T.[ParentOrganizationID] = S.[ParentOrganizationID]

WHEN MATCHED THEN

UPDATE SET   [ParentOrganizationName] = S.[ParentOrganizationName]
		   , [Address1] = S.[Address1]
		   , [Address2] = S.[Address2]
		   , [City] = S.[City]
		   , [StateCode] = S.[StateCode]
		   , [ZipCode] = S.[ZipCode]
		   , [PhoneNumber] = S.[PhoneNumber]
		   , [Extension] = S.[Extension]
		   , [FAXNumber] = S.[FAXNumber]
		   , [ParentOrganizationNPI] = S.[ParentOrganizationNPI]
		   , [ParentOrganizationFederalTaxID] = S.[ParentOrganizationFederalTaxID]
		   , [ContactName] = S.[ContactName]
		   , [ContactTitle] = S.[ContactTitle]
		   , [EmailAddress] = S.[EmailAddress]
		   , [DeleteDate] = S.[DeleteDate]
		
	
		 

WHEN NOT MATCHED THEN
		INSERT ([ParentOrganizationID], [ParentOrganizationName], [Address1], [Address2], [City], [StateCode], [ZipCode], [PhoneNumber], [Extension], [FAXNumber], [ParentOrganizationNPI]
				, [ParentOrganizationFederalTaxID], [ContactName], [ContactTitle], [EmailAddress], [DeleteDate])
		VALUES (S.[ParentOrganizationID], S.[ParentOrganizationName], S.[Address1], S.[Address2], S.[City], S.[StateCode], S.[ZipCode], S.[PhoneNumber], S.[Extension], S.[FAXNumber], S.[ParentOrganizationNPI]
				, S.[ParentOrganizationFederalTaxID], S.[ContactName], S.[ContactTitle], S.[EmailAddress], S.[DeleteDate]);
END


GO
