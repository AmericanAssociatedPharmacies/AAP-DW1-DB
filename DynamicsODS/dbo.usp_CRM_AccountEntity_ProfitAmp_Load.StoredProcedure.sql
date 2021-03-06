USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_AccountEntity_ProfitAmp_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_CRM_AccountEntity_ProfitAmp_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[CRM_AccountEntity_ProfitAmp] AS T
	USING (SELECT [accountid], [new_profitampactivationdate], [new_profitampapplicationemail], [new_profitampapplicationname], [new_profitampapplicationreceived], [new_profitampapplicationtitle]
				, [new_profitamplevel], [new_profitamplevelname], [new_profitampsenderemail], [new_profitampsenderemailname], [new_profitampsent], [new_profitamptermination], [DateKey], [new_profitampbilling], [new_profitampfee]
		   FROM [ODSIntake].[Staging].[CRM_AccountEntity_ProfitAmp]) AS S
		        ([accountid], [new_profitampactivationdate], [new_profitampapplicationemail], [new_profitampapplicationname], [new_profitampapplicationreceived], [new_profitampapplicationtitle]
				, [new_profitamplevel], [new_profitamplevelname], [new_profitampsenderemail], [new_profitampsenderemailname], [new_profitampsent], [new_profitamptermination], [DateKey], [new_profitampbilling], [new_profitampfee]
		   )
		   ON T.accountid = S.accountid

WHEN MATCHED THEN

UPDATE SET [new_profitampactivationdate] = S.[new_profitampactivationdate]
		 , [new_profitampapplicationemail] = S.[new_profitampapplicationemail]
		 , [new_profitampapplicationname] = S.[new_profitampapplicationname]
		 , [new_profitampapplicationreceived] = S.[new_profitampapplicationreceived]
		 , [new_profitampapplicationtitle] = S.[new_profitampapplicationtitle]
		 , [new_profitamplevel] = S.[new_profitamplevel]
		 , [new_profitamplevelname] = S.[new_profitamplevelname]
		 , [new_profitampsenderemail] = S.[new_profitampsenderemail]
		 , [new_profitampsenderemailname] = S.[new_profitampsenderemailname]
		 , [new_profitampsent] = S.[new_profitampsent]
		 , [new_profitamptermination] = S.[new_profitamptermination]
		 , [DateKey] = S.[DateKey]
		 , [new_profitampbilling] = s.[new_profitampbilling]
		 , [new_profitampfee] = s.[new_profitampfee]

WHEN NOT MATCHED THEN
		INSERT ([accountid], [new_profitampactivationdate], [new_profitampapplicationemail], [new_profitampapplicationname], [new_profitampapplicationreceived], [new_profitampapplicationtitle]
			, [new_profitamplevel], [new_profitamplevelname], [new_profitampsenderemail], [new_profitampsenderemailname], [new_profitampsent], [new_profitamptermination], [DateKey], [new_profitampbilling], [new_profitampfee]
			)
		VALUES (S.[accountid], S.[new_profitampactivationdate], S.[new_profitampapplicationemail], S.[new_profitampapplicationname], S.[new_profitampapplicationreceived], S.[new_profitampapplicationtitle]
			, S.[new_profitamplevel], S.[new_profitamplevelname], S.[new_profitampsenderemail], S.[new_profitampsenderemailname], S.[new_profitampsent], S.[new_profitamptermination], S.[DateKey], s.[new_profitampbilling], s.[new_profitampfee]
			);

END



GO
