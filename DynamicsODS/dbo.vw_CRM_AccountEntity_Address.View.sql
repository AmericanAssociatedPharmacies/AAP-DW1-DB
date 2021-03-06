USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vw_CRM_AccountEntity_Address]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_CRM_AccountEntity_Address]

AS

SELECT [AddressKey] 
	  , [accountid]
	  , [address1_addressid] AS Address1Id
	  , [address1_addresstypecode] AS Address1Typecode
	  , [address1_addresstypecodename] AS Address1Typecodename
	  , [address1_city] AS Address1City
	  , [address1_composite] AS Address1Composite
	  , [address1_country] AS Address1Country
	  , [address1_county] AS Address1County
	  , [address1_fax] AS Address1Fax
	  , [address1_freighttermscode] AS Address1Freighttermscode
	  , [address1_freighttermscodename] AS Address1Freighttermscodename
	  , [address1_latitude] AS Address1Latitude
	  , [address1_line1] AS Address1Line1
	  , [address1_line2] AS Address1Line2
	  , [address1_line3] AS Address1Line3
	  , [address1_longitude] AS Address1Longitude
	  , [address1_name] AS Address1Name
	  , [address1_postalcode] AS Address1Postalcode
	  , [address1_postofficebox] AS Address1Postofficebox
	  , [address1_primarycontactname] AS Address1Primarycontactname
	  , [address1_shippingmethodcode] AS Address1Shippingmethodcode
	  , [address1_shippingmethodcodename] AS Address1Shippingmethodcodename
	  , [address1_stateorprovince] AS Address1Stateorprovince
	  , [address1_telephone1] AS Address1Telephone1
	  , [address1_telephone2] AS Address1Telephone2
	  , [address1_telephone3] AS Address1Telephone3
	  , [address1_upszone] AS Address1Upszone
	  , [address1_utcoffset] AS Address1Utcoffset
	  , [address2_addressid] AS Address2Id
	  , [address2_addresstypecode] AS Address2Addresstypecode
	  , [address2_addresstypecodename] AS Address2Typecodename
	  , [address2_city] AS Address2City
	  , [address2_country] AS Address2Country
	  , [address2_county] AS Address2County
	  , [address2_fax] AS Address2Fax
	  , [address2_freighttermscode] AS Address2Freighttermscode
	  , [address2_freighttermscodename] AS Address2Freighttermscodename
	  , [address2_latitude] AS Address2Latitude
	  , [address2_line1] AS Address2Line1
	  , [address2_line2] AS Address2Line2
	  , [address2_line3] AS Address2Line3
	  , [address2_longitude] AS Address2Longitude
	  , [address2_name] AS Address2Name
	  , [address2_postalcode] AS Address2Postalcode
	  , [address2_postofficebox] AS Address2Postofficebox
	  , [address2_primarycontactname] AS Address2Primarycontactname
	  , [address2_shippingmethodcode] AS Address2Shippingmethodcode
	  , [address2_shippingmethodcodename] AS Address2Shippingmethodcodename
	  , [address2_stateorprovince] AS Address2Stateorprovince
	  , [address2_telephone1] AS Address2Telephone1
	  , [address2_telephone2] AS Address2Telephone2
	  , [address2_telephone3] AS Address2Telephone3
	  , [address2_upszone] AS Address2Upszone
	  , [address2_utcoffset] AS Address2Utcoffset
	  , [new_financialcity] AS financialcity
	  , [new_financialstate] AS financialstate
	  , [new_financialstreet1] AS financialstreet1
	  , [new_financialstreet2] AS financialstreet2
	  , [new_financialstreet3] AS financialstreet3
	  , [new_financialzip] AS financialzip
	  , [RowCreatedDate] 
	  , [DateKey] 
	  , [address2_composite] AS Address2Composite
	  , [emailaddress1]
	  , [emailaddress2]
	  , [emailaddress3]
	  , [new_address1_composite] AS Address1_Composite
	  , [new_address2_composite] AS Address2_Composite
FROM dbo.CRM_AccountEntity_Address
	  


GO
