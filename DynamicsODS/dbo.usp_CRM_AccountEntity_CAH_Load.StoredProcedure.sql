USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_AccountEntity_CAH_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_CRM_AccountEntity_CAH_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[CRM_AccountEntity_CAH] AS T
	USING (SELECT [accountid], [new_cah_account], [new_cah_avg_volume], [new_cah_cog], [new_cah_dso], [new_cah_potential_volume], [new_cah_terms], [new_cah_termsname], [new_cahpvacontractdate]
			, [new_cahpvaeffdatenewagreement], [new_cahpvalastreview], [new_cahpvamatrix], [new_cahpvamatrixname], [new_cahpvareviewtype], [new_cahpvareviewtypename], [new_cahpvastatus], [new_cahpvastatusname]
			, [new_cahpvatermcode], [new_cahpvatermcodename], [new_cahpvatermcomment], [new_cahpvatermdate], [DateKey], [new_cah_account2], [new_cah_account3], [new_cahcsosaccount], [new_cahposaccount], new_cahstaccount
		    , [new_cahdepositaccount], [new_cahdmeaccount], [new_cahotcaccount], [new_cahspecialtyaccount], [new_cahcomboaccount], [new_cahgenericrebate], [new_cahhighvolumerebate]
		   FROM	[ODSIntake].[Staging].[CRM_AccountEntity_CAH]) AS S
			( [accountid], [new_cah_account], [new_cah_avg_volume], [new_cah_cog], [new_cah_dso], [new_cah_potential_volume], [new_cah_terms], [new_cah_termsname], [new_cahpvacontractdate]
			, [new_cahpvaeffdatenewagreement], [new_cahpvalastreview], [new_cahpvamatrix], [new_cahpvamatrixname], [new_cahpvareviewtype], [new_cahpvareviewtypename], [new_cahpvastatus], [new_cahpvastatusname]
			, [new_cahpvatermcode], [new_cahpvatermcodename], [new_cahpvatermcomment], [new_cahpvatermdate], [DateKey], [new_cah_account2], [new_cah_account3], [new_cahcsosaccount], [new_cahposaccount], new_cahstaccount
			, [new_cahdepositaccount], [new_cahdmeaccount], [new_cahotcaccount], [new_cahspecialtyaccount], [new_cahcomboaccount], [new_cahgenericrebate], [new_cahhighvolumerebate]
			) ON T.accountid = S.accountid

WHEN MATCHED THEN

UPDATE SET [new_cah_account] = S.[new_cah_account]
		 , [new_cah_avg_volume] = S.[new_cah_avg_volume]
		 , [new_cah_cog] = (S.[new_cah_cog] * -1)
		 , [new_cah_dso] = S.[new_cah_dso]
		 , [new_cah_potential_volume] = S.[new_cah_potential_volume]
		 , [new_cah_terms] = S.[new_cah_terms]
		 , [new_cah_termsname] = S.[new_cah_termsname]
		 , [new_cahpvacontractdate] = S.[new_cahpvacontractdate]
		 , [new_cahpvaeffdatenewagreement] = S.[new_cahpvaeffdatenewagreement]
		 , [new_cahpvalastreview] = S.[new_cahpvalastreview]
		 , [new_cahpvamatrix] = S.[new_cahpvamatrix]
		 , [new_cahpvamatrixname] = S.[new_cahpvamatrixname]
		 , [new_cahpvareviewtype] = S.[new_cahpvareviewtype]
		 , [new_cahpvareviewtypename] = S.[new_cahpvareviewtypename]
		 , [new_cahpvastatus] = S.[new_cahpvastatus]
		 , [new_cahpvastatusname] = S.[new_cahpvastatusname]
		 , [new_cahpvatermcode] = S.[new_cahpvatermcode]
		 , [new_cahpvatermcodename] = S.[new_cahpvatermcodename]
		 , [new_cahpvatermcomment] = S.[new_cahpvatermcomment]
		 , [new_cahpvatermdate] = S.[new_cahpvatermdate]
		 , [DateKey] = S.[DateKey]
		 , [new_cah_account2] = s.[new_cah_account2]
		 , [new_cah_account3] = s.[new_cah_account3]
		 , [new_cahcsosaccount] = s.[new_cahcsosaccount]
		 , [new_cahposaccount] = s.[new_cahposaccount]
		 , new_cahstaccount = s.new_cahstaccount
		 , [new_cahdepositaccount] = s.[new_cahdepositaccount]
		 , [new_cahdmeaccount] = s.[new_cahdmeaccount]
		 , [new_cahotcaccount] = s.[new_cahotcaccount]
		 , [new_cahspecialtyaccount] = s.[new_cahspecialtyaccount]
		 , [new_cahcomboaccount] = s.[new_cahcomboaccount]
		 , [new_cahgenericrebate] = s.[new_cahgenericrebate]
		 , [new_cahhighvolumerebate] = (s.[new_cahhighvolumerebate] * -1)

WHEN NOT MATCHED THEN
		 INSERT ([accountid], [new_cah_account], [new_cah_avg_volume], [new_cah_cog], [new_cah_dso], [new_cah_potential_volume], [new_cah_terms], [new_cah_termsname], [new_cahpvacontractdate]
		 , [new_cahpvaeffdatenewagreement], [new_cahpvalastreview], [new_cahpvamatrix], [new_cahpvamatrixname], [new_cahpvareviewtype], [new_cahpvareviewtypename], [new_cahpvastatus], [new_cahpvastatusname]
		 , [new_cahpvatermcode], [new_cahpvatermcodename], [new_cahpvatermcomment], [new_cahpvatermdate], [DateKey], [new_cah_account2], [new_cah_account3], [new_cahcsosaccount], [new_cahposaccount], new_cahstaccount
		 , [new_cahdepositaccount],  [new_cahdmeaccount], [new_cahotcaccount], [new_cahspecialtyaccount],[new_cahcomboaccount], [new_cahgenericrebate], [new_cahhighvolumerebate]
		 )
		 VALUES ( S.[accountid], S.[new_cah_account], S.[new_cah_avg_volume], (S.[new_cah_cog] * -1), S.[new_cah_dso], S.[new_cah_potential_volume], S.[new_cah_terms], S.[new_cah_termsname], S.[new_cahpvacontractdate]
		, S.[new_cahpvaeffdatenewagreement], S.[new_cahpvalastreview], S.[new_cahpvamatrix], S.[new_cahpvamatrixname], S.[new_cahpvareviewtype], S.[new_cahpvareviewtypename], S.[new_cahpvastatus], S.[new_cahpvastatusname]
		, S.[new_cahpvatermcode], S.[new_cahpvatermcodename], S.[new_cahpvatermcomment], S.[new_cahpvatermdate], S.[DateKey], s.[new_cah_account2], s.[new_cah_account3], s.[new_cahcsosaccount], s.[new_cahposaccount], s.new_cahstaccount
		, s.[new_cahdepositaccount],  s.[new_cahdmeaccount], s.[new_cahotcaccount], s.[new_cahspecialtyaccount], s.[new_cahcomboaccount], s.[new_cahgenericrebate], (s.[new_cahhighvolumerebate] * -1) 
		 );

END








GO
