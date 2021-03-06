USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vw_CRM_AccountEntity_API]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_CRM_AccountEntity_API]

AS

SELECT [APIKey]
	  , [accountid]
	  ,	[new_api_account] AS APIAccount
	  ,	[new_api_app_credit_date] AS API_AAPCreditDate
	  ,	[new_api_app_status] AS API_AAPStatus
	  ,	[new_api_app_statusname] AS APIAPP_Statusname
	  ,	[new_api_approved_date] AS APIApprovedDate
	  ,	[new_api_csos_approved_date] AS APICsosApprovedDate
	  ,	[new_api_csos_declined_date] AS APICsosDeclinedDate
	  ,	[new_api_csos_installed_date] AS APICsosInstalledDate
	  ,	[new_api_csos_profile_received_date] AS APICsosProfileReceivedDate
	  ,	[new_api_cutoff] AS APICutoff
	  ,	[new_api_cutoffname] AS APICutoffname
	  ,	[new_api_order_method] AS APIOrderMethod
	  ,	[new_api_order_methodname] AS APIOrderMethodname
      ,	[new_api_photos_received_date] AS APIPhotosReceivedDate
	  ,	[new_api_terms] AS APITerms
	  ,	[new_api_termsname] AS APITermsname
	  ,	[new_apiaccountactivation] AS APIAccountactivation
	  ,	[new_apialert] AS APIalert
	  , [new_apialertname] AS APIalertname
	  ,	[new_apibrands] AS APIbrand
	  ,	[new_apicreditalert] AS APIcreditalert
	  ,	[new_apicreditalertname] AS APIcreditalertname
	  ,	[new_apicreditlimit] AS APIcreditlimit
	  ,	[new_apicsosalert] AS APIcsosalert
	  ,	[new_apicsosalertname] AS APIcsosalertname
	  ,	[new_apicsosstatus] AS APIcsosstatus
	  ,	[new_apicsosstatusname] AS APIcsosstatusname
	  ,	[new_apifreight] AS APIfreight
	  ,	[new_apifreightname] AS APIfreightname
	  ,	[new_apigenerics] AS APIgenerics
	  ,	[new_apimot] AS APImot
	  ,	[new_apimotname] AS APImotname
	  ,	[new_apiotcs] AS APIotcs
	  ,	[new_apipaymentmethod] AS APIpaymentmethod
	  ,	[new_apipaymentmethodname] AS APIpaymentmethodname
	  ,	[new_apiquestionniare] AS APIquestionniare
	  ,	[new_apiquestionniarename] AS APIquestionniarename
	  ,	[new_apirefrigerated] AS APIrefrigerated
	  ,	[new_apirefrigeratedname] AS APIrefrigeratedname
	  ,	[new_apistatus] AS APIstatus
	  ,	[new_apistatusname] AS APIstatusname
	  ,	[new_apitotals] AS APItotals
	  ,	[new_apiwarehouse] AS APIwarehouse
	  ,	[new_apiwarehousename] AS APIwarehousename
	  , [RowCreatedDate] 
	  ,	[DateKey] 
	  ,	[new_apidefaultshipping] AS APIdefaultshipping
	  ,	[new_apidefaultshippingname] AS APIdefaultshippingname
	  ,	[new_apifirstorder] AS APIfirstorder
	  ,	[new_apigenericsq1] AS APIgenericsq1
	  ,	[new_apigenericsq2] AS APIgenericsq2
	  ,	[new_apigenericsq3] AS APIgenericsq3
	  ,	[new_apigenericsq4] AS APIgenericsq4
	  ,	[new_apigenericsrecommendation] AS APIgenericsrecommendation
	  ,	[new_apigenericsytd] AS APIgenericsytd
	  ,	[new_apiparent] AS APIparent
	  ,	[new_apiparentname] AS APIparentname
	  ,	[new_apiparentno] AS APIparentno
	  ,	[new_apiparentyominame] AS APIparentyominame
	  ,	[new_apipaymentmethodprofileform] AS APIpaymentmethodprofileform
	  ,	[new_apipaymentmethodprofileformname] AS APIpaymentmethodprofileformname
	  ,	[new_apipriority] AS APIpriority
	  ,	[new_apipriorityname] AS APIpriorityname
	  ,	[new_apipurchasegoal] AS APIpurchasegoal
	  ,	[new_apipurchasesdaterange] AS APIpurchasesdaterange
	  ,	[new_apirecommendationdate] AS APIrecommendationdate
	  , [new_apideactivation] AS APIDecativationDate
FROM [dbo].[CRM_AccountEntity_API]


GO
