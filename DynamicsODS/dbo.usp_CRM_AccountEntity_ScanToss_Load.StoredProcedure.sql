USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_AccountEntity_ScanToss_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CRM_AccountEntity_ScanToss_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[CRM_AccountEntity_ScanToss] AS T
	USING (SELECT [accountid], [new_scantoss_activation_date], [new_scantoss_app_received_date], [new_scantoss_eligible_date], [new_scantoss_status], [new_scantoss_statusname], [new_scantoss_version]
				, [new_scantoss_versionname], [DateKey]
			FROM [ODSIntake].[Staging].[CRM_AccountEntity_ScanToss]) AS S
			([accountid], [new_scantoss_activation_date], [new_scantoss_app_received_date], [new_scantoss_eligible_date], [new_scantoss_status], [new_scantoss_statusname], [new_scantoss_version]
			, [new_scantoss_versionname], [DateKey]
			)
			ON T.accountid = S.accountid

WHEN MATCHED THEN

UPDATE SET [new_scantoss_activation_date] = S.[new_scantoss_activation_date]
		 , [new_scantoss_app_received_date] = S.[new_scantoss_app_received_date]
		 , [new_scantoss_eligible_date] = S.[new_scantoss_eligible_date]
		 , [new_scantoss_status] = S.[new_scantoss_status]
		 , [new_scantoss_statusname] = S.[new_scantoss_statusname]
		 , [new_scantoss_version] = S.[new_scantoss_version]
		 , [new_scantoss_versionname] = S.[new_scantoss_versionname]
		 , [DateKey] = S.[DateKey]

WHEN NOT MATCHED THEN
	INSERT ([accountid], [new_scantoss_activation_date], [new_scantoss_app_received_date], [new_scantoss_eligible_date], [new_scantoss_status], [new_scantoss_statusname], [new_scantoss_version]
			, [new_scantoss_versionname], [DateKey]
			)
	VALUES (S.[accountid], S.[new_scantoss_activation_date], S.[new_scantoss_app_received_date], S.[new_scantoss_eligible_date], S.[new_scantoss_status], S.[new_scantoss_statusname]
			, S.[new_scantoss_version], S.[new_scantoss_versionname], S.[DateKey]
			);

END


GO
