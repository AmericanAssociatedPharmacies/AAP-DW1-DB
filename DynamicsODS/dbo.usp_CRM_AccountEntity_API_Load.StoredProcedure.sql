USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_AccountEntity_API_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_CRM_AccountEntity_API_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	MERGE [dbo].[CRM_AccountEntity_API] AS T
	USING (SELECT [accountid], [new_api_account], [new_api_app_credit_date], [new_api_app_status], [new_api_app_statusname], [new_api_approved_date], [new_api_csos_approved_date]
		  , [new_api_csos_declined_date], [new_api_csos_installed_date], [new_api_csos_profile_received_date], [new_api_cutoff], [new_api_cutoffname], [new_api_order_method], [new_api_order_methodname]
		  , [new_api_photos_received_date], [new_api_terms], [new_api_termsname], [new_apiaccountactivation], [new_apialert], [new_apialertname], [new_apibrands], [new_apicreditalert], [new_apicreditalertname]
		  , [new_apicreditlimit], [new_apicsosalert], [new_apicsosalertname], [new_apicsosstatus], [new_apicsosstatusname], [new_apifreight], [new_apifreightname], [new_apigenerics], [new_apimot], [new_apimotname]
		  , [new_apiotcs], [new_apipaymentmethod], [new_apipaymentmethodname], [new_apiquestionniare], [new_apiquestionniarename], [new_apirefrigerated], [new_apirefrigeratedname]
		  --, [new_apistatus]
		  --, [new_apistatusname]
		  , [new_apitotals], [new_apiwarehouse], [new_apiwarehousename], [RowCreatedDate], [DateKey], [new_apidefaultshipping], [new_apidefaultshippingname], [new_apifirstorder]
		  , [new_apigenericsq1], [new_apigenericsq2], [new_apigenericsq3], [new_apigenericsq4], [new_apigenericsrecommendation], [new_apigenericsytd], [new_apiparent], [new_apiparentname], [new_apiparentno]
		  , [new_apiparentyominame], [new_apipaymentmethodprofileform], [new_apipaymentmethodprofileformname], [new_apipriority], [new_apipriorityname], [new_apipurchasegoal], [new_apipurchasesdaterange]
		  , [new_apirecommendationdate], [new_apideactivation], new_api_historical
		  FROM [ODSIntake].[Staging].[CRM_AccountEntity_API]
		  ) AS S ([accountid], [new_api_account], [new_api_app_credit_date], [new_api_app_status], [new_api_app_statusname], [new_api_approved_date], [new_api_csos_approved_date]
				  , [new_api_csos_declined_date], [new_api_csos_installed_date], [new_api_csos_profile_received_date], [new_api_cutoff], [new_api_cutoffname], [new_api_order_method], [new_api_order_methodname]
				  , [new_api_photos_received_date], [new_api_terms], [new_api_termsname], [new_apiaccountactivation], [new_apialert], [new_apialertname], [new_apibrands], [new_apicreditalert], [new_apicreditalertname]
				  , [new_apicreditlimit], [new_apicsosalert], [new_apicsosalertname], [new_apicsosstatus], [new_apicsosstatusname], [new_apifreight], [new_apifreightname], [new_apigenerics], [new_apimot], [new_apimotname]
				  , [new_apiotcs], [new_apipaymentmethod], [new_apipaymentmethodname], [new_apiquestionniare], [new_apiquestionniarename], [new_apirefrigerated], [new_apirefrigeratedname]
				  --, [new_apistatus]
				  --, [new_apistatusname]
				  , [new_apitotals], [new_apiwarehouse], [new_apiwarehousename], [RowCreatedDate], [DateKey], [new_apidefaultshipping], [new_apidefaultshippingname], [new_apifirstorder]
				  , [new_apigenericsq1], [new_apigenericsq2], [new_apigenericsq3], [new_apigenericsq4], [new_apigenericsrecommendation], [new_apigenericsytd], [new_apiparent], [new_apiparentname], [new_apiparentno]
				  , [new_apiparentyominame], [new_apipaymentmethodprofileform], [new_apipaymentmethodprofileformname], [new_apipriority], [new_apipriorityname], [new_apipurchasegoal], [new_apipurchasesdaterange]
				  , [new_apirecommendationdate], [new_apideactivation], new_api_historical
					) ON T.accountid = S.accountid

	WHEN MATCHED THEN
	UPDATE SET [new_api_account] = S. [new_api_account]
		 , [new_api_app_credit_date] = S.[new_api_app_credit_date]
		 , [new_api_app_status] = S.[new_api_app_status]
		 , [new_api_app_statusname] = S.[new_api_app_statusname]
		 , [new_api_approved_date] = S.[new_api_approved_date]
		 , [new_api_csos_approved_date] = S.[new_api_csos_approved_date]
		 , [new_api_csos_declined_date] = S.[new_api_csos_declined_date]
		 , [new_api_csos_installed_date] = S.[new_api_csos_installed_date]
		 , [new_api_csos_profile_received_date]  = S.[new_api_csos_profile_received_date]
		 , [new_api_cutoff] = S.[new_api_cutoff]
		 , [new_api_cutoffname] = S.[new_api_cutoffname]
		 , [new_api_order_method] = S.[new_api_order_method]
		 , [new_api_order_methodname] = S.[new_api_order_methodname]
		 , [new_api_photos_received_date]  = S.[new_api_photos_received_date]
		 , [new_api_terms] = S.[new_api_terms]
		 , [new_api_termsname] = S.[new_api_termsname]
		 , [new_apiaccountactivation] = S.[new_apiaccountactivation]
		 , [new_apialert] = S.[new_apialert]
		 , [new_apialertname] = S.[new_apialertname]
		 , [new_apibrands] = S.[new_apibrands]
		 , [new_apicreditalert] = S.[new_apicreditalert]
		 , [new_apicreditalertname] = S.[new_apicreditalertname]
		 , [new_apicreditlimit] = S.[new_apicreditlimit]
		 , [new_apicsosalert] = S.[new_apicsosalert]
		 , [new_apicsosalertname] = S.[new_apicsosalertname]
		 , [new_apicsosstatus] = S.[new_apicsosstatus]
		 , [new_apicsosstatusname] = S.[new_apicsosstatusname]
		 , [new_apifreight] = S.[new_apifreight]
		 , [new_apifreightname] = S.[new_apifreightname]
		 , [new_apigenerics] = S.[new_apigenerics]
		 , [new_apimot] = S.[new_apimot]
		 , [new_apimotname] = S.[new_apimotname]
		 , [new_apiotcs] = S.[new_apiotcs]
		 , [new_apipaymentmethod] = S.[new_apipaymentmethod]
		 , [new_apipaymentmethodname] = S.[new_apipaymentmethodname]
		 , [new_apiquestionniare] = S.[new_apiquestionniare]
		 , [new_apiquestionniarename] = S.[new_apiquestionniarename]
		 , [new_apirefrigerated] = S.[new_apirefrigerated]
		 , [new_apirefrigeratedname] = S.[new_apirefrigeratedname]
		 --, [new_apistatus] = S.[new_apistatus]
		 --, [new_apistatusname] = S.[new_apistatusname]
		 , [new_apitotals] = S.[new_apitotals]
		 , [new_apiwarehouse] = S.[new_apiwarehouse]
		 , [new_apiwarehousename] = S.[new_apiwarehousename]
		 , [DateKey] = S.[DateKey]
		 , [new_apidefaultshipping] = S.[new_apidefaultshipping]
		 , [new_apidefaultshippingname] = S.[new_apidefaultshippingname]
		 , [new_apifirstorder] = S.[new_apifirstorder]
		 , [new_apigenericsq1] = S.[new_apigenericsq1]
		 , [new_apigenericsq2] = S.[new_apigenericsq2]
		 , [new_apigenericsq3] = S.[new_apigenericsq3]
		 , [new_apigenericsq4] = S.[new_apigenericsq4]
		 , [new_apigenericsrecommendation] = S.[new_apigenericsrecommendation]
		 , [new_apigenericsytd] = S.[new_apigenericsytd]
		 , [new_apiparent] = S.[new_apiparent]
		 , [new_apiparentname] = S.[new_apiparentname]
		 , [new_apiparentno] = S.[new_apiparentno]
		 , [new_apiparentyominame] = S.[new_apiparentyominame]
		 , [new_apipaymentmethodprofileform] = S.[new_apipaymentmethodprofileform]
		 , [new_apipaymentmethodprofileformname] = S.[new_apipaymentmethodprofileformname]
		 , [new_apipriority] = S.[new_apipriority]
		 , [new_apipriorityname] = S.[new_apipriorityname]
		 , [new_apipurchasegoal] = S.[new_apipurchasegoal]
		 , [new_apipurchasesdaterange] = S.[new_apipurchasesdaterange]
		 , [new_apirecommendationdate] = S.[new_apirecommendationdate]
		 , [new_apideactivation] = s.[new_apideactivation]
		 , new_api_historical = s.new_api_historical

	WHEN NOT MATCHED THEN
		 INSERT ([accountid], [new_api_account], [new_api_app_credit_date], [new_api_app_status], [new_api_app_statusname], [new_api_approved_date], [new_api_csos_approved_date]
		 , [new_api_csos_declined_date], [new_api_csos_installed_date], [new_api_csos_profile_received_date], [new_api_cutoff], [new_api_cutoffname], [new_api_order_method], [new_api_order_methodname]
		 , [new_api_photos_received_date], [new_api_terms], [new_api_termsname], [new_apiaccountactivation], [new_apialert], [new_apialertname], [new_apibrands], [new_apicreditalert], [new_apicreditalertname]
		 , [new_apicreditlimit], [new_apicsosalert], [new_apicsosalertname], [new_apicsosstatus], [new_apicsosstatusname], [new_apifreight], [new_apifreightname], [new_apigenerics], [new_apimot]
		 , [new_apimotname], [new_apiotcs], [new_apipaymentmethod], [new_apipaymentmethodname], [new_apiquestionniare], [new_apiquestionniarename], [new_apirefrigerated], [new_apirefrigeratedname]
		 --, [new_apistatus], [new_apistatusname]
		 , [new_apitotals], [new_apiwarehouse], [new_apiwarehousename], [DateKey], [new_apidefaultshipping], [new_apidefaultshippingname]
		 , [new_apifirstorder], [new_apigenericsq1], [new_apigenericsq2], [new_apigenericsq3], [new_apigenericsq4], [new_apigenericsrecommendation], [new_apigenericsytd], [new_apiparent], [new_apiparentname]
		 , [new_apiparentno], [new_apiparentyominame], [new_apipaymentmethodprofileform], [new_apipaymentmethodprofileformname], [new_apipriority], [new_apipriorityname], [new_apipurchasegoal]
		 , [new_apipurchasesdaterange], [new_apirecommendationdate], [new_apideactivation], new_api_historical
		 )
		 VALUES (S.[accountid], S.[new_api_account], S.[new_api_app_credit_date], S.[new_api_app_status], S.[new_api_app_statusname], S.[new_api_approved_date], S.[new_api_csos_approved_date]
		, S.[new_api_csos_declined_date], S.[new_api_csos_installed_date], S.[new_api_csos_profile_received_date], S.[new_api_cutoff], S.[new_api_cutoffname], S.[new_api_order_method], S.[new_api_order_methodname]
		, S.[new_api_photos_received_date], S.[new_api_terms], S.[new_api_termsname], S.[new_apiaccountactivation], S.[new_apialert], S.[new_apialertname], S.[new_apibrands], S.[new_apicreditalert], S.[new_apicreditalertname]
		, S.[new_apicreditlimit], S.[new_apicsosalert], S.[new_apicsosalertname], S.[new_apicsosstatus], S.[new_apicsosstatusname],  S.[new_apifreight], S.[new_apifreightname], S.[new_apigenerics], S.[new_apimot]
		, S.[new_apimotname], S.[new_apiotcs], S.[new_apipaymentmethod], S.[new_apipaymentmethodname], S.[new_apiquestionniare], S.[new_apiquestionniarename], S.[new_apirefrigerated], S.[new_apirefrigeratedname]
		--, S.[new_apistatus]
		--, S.[new_apistatusname]
		, S.[new_apitotals], S.[new_apiwarehouse], S.[new_apiwarehousename], S.[DateKey], S.[new_apidefaultshipping], S.[new_apidefaultshippingname]
		, S.[new_apifirstorder], S.[new_apigenericsq1], S.[new_apigenericsq2], S.[new_apigenericsq3], S.[new_apigenericsq4], S.[new_apigenericsrecommendation], S.[new_apigenericsytd], S.[new_apiparent], S.[new_apiparentname]
		, S.[new_apiparentno], S.[new_apiparentyominame], S.[new_apipaymentmethodprofileform], S.[new_apipaymentmethodprofileformname], S.[new_apipriority], S.[new_apipriorityname], S.[new_apipurchasegoal]
		, S.[new_apipurchasesdaterange], S.[new_apirecommendationdate], s.[new_apideactivation], s.new_api_historical
		 );


	--Update API Status Name field from the Program Entity as of 10/19/2020. RSE
	UPDATE a
	SET [new_apistatusname] = p.[new_api_status_globalname]
	FROM [dbo].[CRM_AccountEntity_API] AS a
	INNER JOIN [dbo].[CRM_ProgramEntity] AS p ON a.accountid = p.new_accountid

END TRY
BEGIN CATCH

	
	DECLARE @ErrorMessage NVARCHAR(4000)
        , @ErrorNumber INT
        , @ErrorSeverity INT
        , @ErrorState INT
        , @ErrorLine INT
        , @ErrorProcedure NVARCHAR(200)

		SELECT 
        @ErrorNumber = ERROR_NUMBER()
        , @ErrorSeverity = ERROR_SEVERITY()
        , @ErrorState = ERROR_STATE()
        , @ErrorLine = ERROR_LINE()
        , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-')
		, @ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (@ErrorMessage 
        , @ErrorSeverity, 1               
        , @ErrorNumber    -- parameter: original error number.
        , @ErrorSeverity  -- parameter: original error severity.
        , @ErrorState     -- parameter: original error state.
        , @ErrorProcedure -- parameter: original error procedure name.
        , @ErrorLine       -- parameter: original error line number.
        );

END CATCH
END






GO
