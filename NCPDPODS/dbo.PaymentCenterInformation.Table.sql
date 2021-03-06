USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[PaymentCenterInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentCenterInformation](
	[PaymentCenterKey] [int] IDENTITY(1,1) NOT NULL,
	[PaymentCenterID] [varchar](6) NULL,
	[PaymentCenterName] [varchar](35) NULL,
	[PaymentCenterAddress1] [varchar](55) NULL,
	[PaymentCenterAddress2] [varchar](55) NULL,
	[PaymentCenterCity] [varchar](30) NULL,
	[PaymentCenterStateCode] [varchar](2) NULL,
	[PaymentCenterZipCode] [varchar](9) NULL,
	[PaymentCenterPhoneNumber] [varchar](10) NULL,
	[PaymentCenterExtension] [varchar](5) NULL,
	[PaymentCenterFaxNumber] [varchar](10) NULL,
	[PaymentCenterNPI] [varchar](10) NULL,
	[PaymentCenterFedralTaxID] [varchar](15) NULL,
	[PaymentCenterContactName] [varchar](30) NULL,
	[PaymentCenterContactTitle] [varchar](30) NULL,
	[PaymentCenterEmailAddress] [varchar](50) NULL,
	[DeleteDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_PaymentCenterInformation] PRIMARY KEY CLUSTERED 
(
	[PaymentCenterKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentCenterInformation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
