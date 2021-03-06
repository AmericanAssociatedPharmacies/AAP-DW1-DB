USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vw_CRM_AccountEntity_ProfitAmp]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_CRM_AccountEntity_ProfitAmp]

AS

SELECT [ProfitAmpKey]
	 , [accountid]
	 , [new_profitampactivationdate] AS profitampactivationdate
	 , [new_profitampapplicationemail] AS profitampapplicationemail
	 , [new_profitampapplicationname] AS profitampapplicationname
	 , [new_profitampapplicationreceived] AS profitampapplicationreceived
	 , [new_profitampapplicationtitle] AS profitampapplicationtitle
	 , [new_profitamplevel] AS profitamplevel
	 , [new_profitamplevelname] AS profitamplevelname
	 , [new_profitampsenderemail] AS profitampsenderemail
	 , [new_profitampsenderemailname] AS profitampsenderemailname
	 , [new_profitampsent] AS profitampsent
	 , [new_profitamptermination] AS profitamptermination
	 , [RowCreatedDate]
	 , [DateKey]
	 , [new_profitampbilling] AS ProfitAmpBilling
	 , [new_profitampfee]  AS ProfitAmpFee 
FROM [dbo].[CRM_AccountEntity_ProfitAmp]

GO
