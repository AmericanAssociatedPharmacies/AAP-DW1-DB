USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_AccountEntity_Address_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_CRM_AccountEntity_Address_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[CRM_AccountEntity_Address] AS T
	USING (SELECT [accountid], [address1_addressid], [address1_addresstypecode], [address1_addresstypecodename]
			, [address1_city], [address1_composite], [address1_country], [address1_county], [address1_fax]
			, [address1_freighttermscode], [address1_freighttermscodename], [address1_latitude], [address1_line1]
			, [address1_line2], [address1_line3], [address1_longitude], [address1_name], [address1_postalcode]
			, [address1_postofficebox], [address1_primarycontactname], [address1_shippingmethodcode]
			, [address1_shippingmethodcodename], [address1_stateorprovince], [address1_telephone1], [address1_telephone2]
			, [address1_telephone3], [address1_upszone], [address1_utcoffset], [address2_addressid], [address2_addresstypecode]
			, [address2_addresstypecodename], [address2_city], [address2_country], [address2_county], [address2_fax]
			, [address2_freighttermscode], [address2_freighttermscodename], [address2_latitude], [address2_line1], [address2_line2]
			, [address2_line3], [address2_longitude], [address2_name], [address2_postalcode], [address2_postofficebox]
			, [address2_primarycontactname], [address2_shippingmethodcode], [address2_shippingmethodcodename]
			, [address2_stateorprovince], [address2_telephone1], [address2_telephone2], [address2_telephone3], [address2_upszone]
			, [address2_utcoffset], [new_financialcity], [new_financialstate], [new_financialstreet1], [new_financialstreet2]
			, [new_financialstreet3], [new_financialzip], [DateKey], [address2_composite], [emailaddress1]
			, [emailaddress2], [emailaddress3], [new_address1_composite], [new_address2_composite]			
		   FROM	[ODSIntake].[Staging].[CRM_AccountEntity_Address]) AS S 
		   ( [accountid], [address1_addressid], [address1_addresstypecode], [address1_addresstypecodename]
		   , [address1_city], [address1_composite], [address1_country], [address1_county], [address1_fax]
		   , [address1_freighttermscode], [address1_freighttermscodename], [address1_latitude], [address1_line1], [address1_line2]
		   , [address1_line3], [address1_longitude], [address1_name], [address1_postalcode], [address1_postofficebox]
		   , [address1_primarycontactname], [address1_shippingmethodcode], [address1_shippingmethodcodename]
		   , [address1_stateorprovince], [address1_telephone1], [address1_telephone2], [address1_telephone3], [address1_upszone]
		   , [address1_utcoffset], [address2_addressid], [address2_addresstypecode], [address2_addresstypecodename], [address2_city]
		   , [address2_country], [address2_county], [address2_fax], [address2_freighttermscode], [address2_freighttermscodename]
		   , [address2_latitude], [address2_line1], [address2_line2], [address2_line3], [address2_longitude], [address2_name]
		   , [address2_postalcode], [address2_postofficebox], [address2_primarycontactname], [address2_shippingmethodcode]
		   , [address2_shippingmethodcodename], [address2_stateorprovince], [address2_telephone1], [address2_telephone2]
		   , [address2_telephone3], [address2_upszone], [address2_utcoffset], [new_financialcity], [new_financialstate]
		   , [new_financialstreet1], [new_financialstreet2], [new_financialstreet3], [new_financialzip], [DateKey]
		   , [address2_composite], [emailaddress1], [emailaddress2], [emailaddress3], [new_address1_composite]
		   , [new_address2_composite]
			)
			ON T.accountid = S.accountid				

WHEN MATCHED THEN

UPDATE SET [address1_addressid] = S.[address1_addressid]
		 , [address1_addresstypecode] = S.[address1_addresstypecode]
		 , [address1_addresstypecodename] = S.[address1_addresstypecodename]
		 , [address1_city] = S.[address1_city]
		 , [address1_composite] = S.[address1_composite]
		 , [address1_country] = S.[address1_country]
		 , [address1_county] = S.[address1_county]
		 , [address1_fax] = S.[address1_fax]
		 , [address1_freighttermscode] = S.[address1_freighttermscode]
		 , [address1_freighttermscodename] = S.[address1_freighttermscodename]
		 , [address1_latitude] = S.[address1_latitude]
		 , [address1_line1] = S.[address1_line1]
		 , [address1_line2] = S.[address1_line2]
		 , [address1_line3] = S.[address1_line3]
		 , [address1_longitude] = S.[address1_longitude]
		 , [address1_name] = S.[address1_name]
		 , [address1_postalcode] = S.[address1_postalcode]
		 , [address1_postofficebox] = S.[address1_postofficebox]
		 , [address1_primarycontactname] = S.[address1_primarycontactname]
		 , [address1_shippingmethodcode] = S.[address1_shippingmethodcode]
		 , [address1_shippingmethodcodename] = S.[address1_shippingmethodcodename]
		 , [address1_stateorprovince] = S.[address1_stateorprovince]
		 , [address1_telephone1] = S.[address1_telephone1]
		 , [address1_telephone2] = S.[address1_telephone2]
		 , [address1_telephone3] = S.[address1_telephone3]
		 , [address1_upszone] = S.[address1_upszone]
		 , [address1_utcoffset] = S.[address1_utcoffset]
		 , [address2_addressid] = S.[address2_addressid]
		 , [address2_addresstypecode] = S.[address2_addresstypecode]
		 , [address2_addresstypecodename] = S.[address2_addresstypecodename]
		 , [address2_city] = S.[address2_city]
		 , [address2_country] = S.[address2_country]
		 , [address2_county] = S.[address2_county]
		 , [address2_fax] = S.[address2_fax]
		 , [address2_freighttermscode] = S.[address2_freighttermscode]
		 , [address2_freighttermscodename] = S.[address2_freighttermscodename]
		 , [address2_latitude] = S.[address2_latitude]
		 , [address2_line1] = S.[address2_line1]
		 , [address2_line2] = S.[address2_line2]
		 , [address2_line3] = S.[address2_line3]
		 , [address2_longitude] = S.[address2_longitude]
		 , [address2_name] = S.[address2_name]
		 , [address2_postalcode] = S.[address2_postalcode]
		 , [address2_postofficebox] = S.[address2_postofficebox]
		 , [address2_primarycontactname] = S.[address2_primarycontactname]
		 , [address2_shippingmethodcode] = S.[address2_shippingmethodcode]
		 , [address2_shippingmethodcodename] = S.[address2_shippingmethodcodename]
		 , [address2_stateorprovince] = S.[address2_stateorprovince]
		 , [address2_telephone1] = S.[address2_telephone1]
		 , [address2_telephone2] = S.[address2_telephone2]
		 , [address2_telephone3] = S.[address2_telephone3]
		 , [address2_upszone] = S.[address2_upszone]
		 , [address2_utcoffset] = S.[address2_utcoffset]
		 , [new_financialcity] = S.[new_financialcity]
		 , [new_financialstate] = S.[new_financialstate]
		 , [new_financialstreet1] = S.[new_financialstreet1]
		 , [new_financialstreet2] = S.[new_financialstreet2]
		 , [new_financialstreet3] = S.[new_financialstreet3]
		 , [new_financialzip] = S.[new_financialzip]
		 , [DateKey] = S.[DateKey]
		 , [address2_composite] = S.[address2_composite]
		 , [emailaddress1] = S.[emailaddress1]
		 , [emailaddress2] = S.[emailaddress2]
		 , [emailaddress3] = S.[emailaddress3]
		 , [new_address1_composite] = S.[new_address1_composite]
		 , [new_address2_composite] = S.[new_address2_composite]

WHEN NOT MATCHED THEN
		INSERT  ([accountid], [address1_addressid], [address1_addresstypecode], [address1_addresstypecodename]
		   , [address1_city], [address1_composite], [address1_country], [address1_county], [address1_fax]
		   , [address1_freighttermscode], [address1_freighttermscodename], [address1_latitude], [address1_line1], [address1_line2]
		   , [address1_line3], [address1_longitude], [address1_name], [address1_postalcode], [address1_postofficebox]
		   , [address1_primarycontactname], [address1_shippingmethodcode], [address1_shippingmethodcodename]
		   , [address1_stateorprovince], [address1_telephone1], [address1_telephone2], [address1_telephone3], [address1_upszone]
		   , [address1_utcoffset], [address2_addressid], [address2_addresstypecode], [address2_addresstypecodename], [address2_city]
		   , [address2_country], [address2_county], [address2_fax], [address2_freighttermscode], [address2_freighttermscodename]
		   , [address2_latitude], [address2_line1], [address2_line2], [address2_line3], [address2_longitude], [address2_name]
		   , [address2_postalcode], [address2_postofficebox], [address2_primarycontactname], [address2_shippingmethodcode]
		   , [address2_shippingmethodcodename], [address2_stateorprovince], [address2_telephone1], [address2_telephone2]
		   , [address2_telephone3], [address2_upszone], [address2_utcoffset], [new_financialcity], [new_financialstate]
		   , [new_financialstreet1], [new_financialstreet2], [new_financialstreet3], [new_financialzip], [DateKey]
		   , [address2_composite], [emailaddress1], [emailaddress2], [emailaddress3], [new_address1_composite]
		   , [new_address2_composite]
			)
		VALUES (S.[accountid], S.[address1_addressid], S.[address1_addresstypecode], S.[address1_addresstypecodename]
			, S.[address1_city], S.[address1_composite], S.[address1_country], S.[address1_county], S.[address1_fax]
			, S.[address1_freighttermscode], S.[address1_freighttermscodename], S.[address1_latitude], S.[address1_line1]
			, S.[address1_line2], S.[address1_line3], S.[address1_longitude], S.[address1_name], S.[address1_postalcode]
			, S.[address1_postofficebox], S.[address1_primarycontactname], S.[address1_shippingmethodcode]
			, S.[address1_shippingmethodcodename], S.[address1_stateorprovince], S.[address1_telephone1], S.[address1_telephone2]
			, S.[address1_telephone3], S.[address1_upszone], S.[address1_utcoffset], S.[address2_addressid], S.[address2_addresstypecode]
			, S.[address2_addresstypecodename], S.[address2_city], S.[address2_country], S.[address2_county], S.[address2_fax]
			, S.[address2_freighttermscode], S.[address2_freighttermscodename], S.[address2_latitude], S.[address2_line1], S.[address2_line2]
			, S.[address2_line3], S.[address2_longitude], S.[address2_name], S.[address2_postalcode], S.[address2_postofficebox]
			, S.[address2_primarycontactname], S.[address2_shippingmethodcode], S.[address2_shippingmethodcodename]
			, S.[address2_stateorprovince], S.[address2_telephone1], S.[address2_telephone2], S.[address2_telephone3], S.[address2_upszone]
			, S.[address2_utcoffset], S.[new_financialcity], S.[new_financialstate], S.[new_financialstreet1], S.[new_financialstreet2]
			, S.[new_financialstreet3], S.[new_financialzip], S.[DateKey], S.[address2_composite], S.[emailaddress1]
			, S.[emailaddress2], S.[emailaddress3], S.[new_address1_composite], S.[new_address2_composite]	
		);

END



GO
