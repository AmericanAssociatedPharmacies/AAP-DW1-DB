USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CRM_AccountEntity_API_20180305]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_AccountEntity_API_20180305](
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
	[new_apiwarehousename] [nvarchar](250) NULL
) ON [PRIMARY]
GO
