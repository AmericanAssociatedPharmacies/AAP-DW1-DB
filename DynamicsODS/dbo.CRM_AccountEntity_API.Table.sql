USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[CRM_AccountEntity_API]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_AccountEntity_API](
	[APIKey] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [uniqueidentifier] NULL,
	[new_api_account] [nvarchar](100) NULL,
	[new_api_app_credit_date] [datetime] NULL,
	[new_api_app_status] [int] NULL,
	[new_api_app_statusname] [nvarchar](250) NULL,
	[new_api_approved_date] [datetime] NULL,
	[new_api_csos_approved_date] [datetime] NULL,
	[new_api_csos_declined_date] [datetime] NULL,
	[new_api_csos_installed_date] [datetime] NULL,
	[new_api_csos_profile_received_date] [datetime] NULL,
	[new_api_cutoff] [int] NULL,
	[new_api_cutoffname] [nvarchar](250) NULL,
	[new_api_order_method] [int] NULL,
	[new_api_order_methodname] [nvarchar](250) NULL,
	[new_api_photos_received_date] [datetime] NULL,
	[new_api_terms] [int] NULL,
	[new_api_termsname] [nvarchar](250) NULL,
	[new_apiaccountactivation] [datetime] NULL,
	[new_apialert] [int] NULL,
	[new_apialertname] [nvarchar](250) NULL,
	[new_apibrands] [int] NULL,
	[new_apicreditalert] [int] NULL,
	[new_apicreditalertname] [nvarchar](250) NULL,
	[new_apicreditlimit] [int] NULL,
	[new_apicsosalert] [int] NULL,
	[new_apicsosalertname] [nvarchar](250) NULL,
	[new_apicsosstatus] [int] NULL,
	[new_apicsosstatusname] [nvarchar](250) NULL,
	[new_apifreight] [int] NULL,
	[new_apifreightname] [nvarchar](250) NULL,
	[new_apigenerics] [int] NULL,
	[new_apimot] [int] NULL,
	[new_apimotname] [nvarchar](250) NULL,
	[new_apiotcs] [int] NULL,
	[new_apipaymentmethod] [int] NULL,
	[new_apipaymentmethodname] [nvarchar](250) NULL,
	[new_apiquestionniare] [int] NULL,
	[new_apiquestionniarename] [nvarchar](250) NULL,
	[new_apirefrigerated] [bit] NULL,
	[new_apirefrigeratedname] [nvarchar](250) NULL,
	[new_apistatus] [int] NULL,
	[new_apistatusname] [nvarchar](250) NULL,
	[new_apitotals] [int] NULL,
	[new_apiwarehouse] [int] NULL,
	[new_apiwarehousename] [nvarchar](250) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DateKey] [int] NULL,
	[new_apidefaultshipping] [int] NULL,
	[new_apidefaultshippingname] [nvarchar](250) NULL,
	[new_apifirstorder] [date] NULL,
	[new_apigenericsq1] [decimal](28, 0) NULL,
	[new_apigenericsq2] [decimal](28, 0) NULL,
	[new_apigenericsq3] [decimal](28, 0) NULL,
	[new_apigenericsq4] [decimal](28, 0) NULL,
	[new_apigenericsrecommendation] [int] NULL,
	[new_apigenericsytd] [money] NULL,
	[new_apiparent] [uniqueidentifier] NULL,
	[new_apiparentname] [nvarchar](100) NULL,
	[new_apiparentno] [nvarchar](4000) NULL,
	[new_apiparentyominame] [nvarchar](100) NULL,
	[new_apipaymentmethodprofileform] [int] NULL,
	[new_apipaymentmethodprofileformname] [nvarchar](250) NULL,
	[new_apipriority] [int] NULL,
	[new_apipriorityname] [nvarchar](250) NULL,
	[new_apipurchasegoal] [nvarchar](200) NULL,
	[new_apipurchasesdaterange] [nvarchar](100) NULL,
	[new_apirecommendationdate] [date] NULL,
	[RowUpdatedDate] [datetime] NULL,
	[RowversionID] [timestamp] NOT NULL,
	[new_apideactivation] [date] NULL,
	[OriginalAPIAccountNumber] [varchar](100) NULL,
	[new_api_historical] [nvarchar](255) NULL,
 CONSTRAINT [CPK_CRM_AccountEntity_API] PRIMARY KEY CLUSTERED 
(
	[APIKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_CRM_AccountEntity_API] UNIQUE NONCLUSTERED 
(
	[accountid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CRM_AccountEntity_API] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
