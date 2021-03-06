USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vw_CRM_AccountEntity_ScanToss]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_CRM_AccountEntity_ScanToss]

AS

SELECT [ScanTossKey]
	 , [accountid]
	 , [new_scantoss_activation_date] AS ScantossActivationDate
	 , [new_scantoss_app_received_date] AS ScantossAppReceivedDate
	 , [new_scantoss_eligible_date] AS ScantossEligibleDate
	 , [new_scantoss_status] AS ScantossStatus
	 , [new_scantoss_statusname] AS ScantossStatusname
	 , [new_scantoss_version] AS ScantossVersion
	 , [new_scantoss_versionname] AS ScantossVersionname
	 , [RowCreatedDate] 
	 , [DateKey]
FROM [dbo].[CRM_AccountEntity_ScanToss]


GO
