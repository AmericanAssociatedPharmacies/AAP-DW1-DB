USE [DynamicsODS]
GO
/****** Object:  Table [Staging].[CRM_AccountEntity_Address]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CRM_AccountEntity_Address](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [uniqueidentifier] NULL,
	[address1_addressid] [uniqueidentifier] NULL,
	[address1_addresstypecode] [int] NULL,
	[address1_addresstypecodename] [nvarchar](250) NULL,
	[address1_city] [nvarchar](80) NULL,
	[address1_composite] [nvarchar](4000) NULL,
	[address1_country] [nvarchar](80) NULL,
	[address1_county] [nvarchar](50) NULL,
	[address1_fax] [nvarchar](50) NULL,
	[address1_freighttermscode] [int] NULL,
	[address1_freighttermscodename] [nvarchar](250) NULL,
	[address1_latitude] [float] NULL,
	[address1_line1] [nvarchar](250) NULL,
	[address1_line2] [nvarchar](250) NULL,
	[address1_line3] [nvarchar](250) NULL,
	[address1_longitude] [float] NULL,
	[address1_name] [nvarchar](200) NULL,
	[address1_postalcode] [nvarchar](20) NULL,
	[address1_postofficebox] [nvarchar](20) NULL,
	[address1_primarycontactname] [nvarchar](100) NULL,
	[address1_shippingmethodcode] [int] NULL,
	[address1_shippingmethodcodename] [nvarchar](250) NULL,
	[address1_stateorprovince] [nvarchar](50) NULL,
	[address1_telephone1] [nvarchar](50) NULL,
	[address1_telephone2] [nvarchar](50) NULL,
	[address1_telephone3] [nvarchar](50) NULL,
	[address1_upszone] [nvarchar](4) NULL,
	[address1_utcoffset] [int] NULL,
	[address2_addressid] [uniqueidentifier] NULL,
	[address2_addresstypecode] [int] NULL,
	[address2_addresstypecodename] [nvarchar](250) NULL,
	[address2_city] [nvarchar](80) NULL,
	[address2_country] [nvarchar](80) NULL,
	[address2_county] [nvarchar](50) NULL,
	[address2_fax] [nvarchar](50) NULL,
	[address2_freighttermscode] [int] NULL,
	[address2_freighttermscodename] [nvarchar](250) NULL,
	[address2_latitude] [float] NULL,
	[address2_line1] [nvarchar](250) NULL,
	[address2_line2] [nvarchar](250) NULL,
	[address2_line3] [nvarchar](250) NULL,
	[address2_longitude] [float] NULL,
	[address2_name] [nvarchar](200) NULL,
	[address2_postalcode] [nvarchar](20) NULL,
	[address2_postofficebox] [nvarchar](20) NULL,
	[address2_primarycontactname] [nvarchar](100) NULL,
	[address2_shippingmethodcode] [int] NULL,
	[address2_shippingmethodcodename] [nvarchar](250) NULL,
	[address2_stateorprovince] [nvarchar](50) NULL,
	[address2_telephone1] [nvarchar](50) NULL,
	[address2_telephone2] [nvarchar](50) NULL,
	[address2_telephone3] [nvarchar](50) NULL,
	[address2_upszone] [nvarchar](4) NULL,
	[address2_utcoffset] [int] NULL,
	[new_financialcity] [nvarchar](100) NULL,
	[new_financialstate] [nvarchar](100) NULL,
	[new_financialstreet1] [nvarchar](100) NULL,
	[new_financialstreet2] [nvarchar](100) NULL,
	[new_financialstreet3] [nvarchar](100) NULL,
	[new_financialzip] [nvarchar](100) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DateKey] [int] NULL,
	[address2_composite] [nvarchar](4000) NULL,
	[emailaddress1] [nvarchar](100) NULL,
	[emailaddress2] [nvarchar](100) NULL,
	[emailaddress3] [nvarchar](100) NULL,
	[new_address1_composite] [nvarchar](4000) NULL,
	[new_address2_composite] [nvarchar](4000) NULL,
 CONSTRAINT [CPK_Staging_CRM_AccountEntity_Address] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Staging_CRM_AccountEntity_Address] UNIQUE NONCLUSTERED 
(
	[accountid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CRM_AccountEntity_Address] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
