USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vw_CRM_AccountEntity_CAH]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_CRM_AccountEntity_CAH]

AS

SELECT [CAHKey]
	 , [accountid]
	 , [new_cah_account] AS CahAccount
	 , [new_cah_avg_volume] AS CahAvgVolume
	 , [new_cah_cog] AS CahCog
	 , [new_cah_dso] AS CahDso
	 , [new_cah_potential_volume] AS CahPotentialVolume
	 , [new_cah_terms] AS CahTerms
	 , [new_cah_termsname] AS CahTermsname
	 , [new_cahpvacontractdate] AS Cahpvacontractdate
	 , [new_cahpvaeffdatenewagreement] AS Cahpvaeffdatenewagreement
	 , [new_cahpvalastreview] AS Cahpvalastreview
	 , [new_cahpvamatrix] AS Cahpvamatrix
	 , [new_cahpvamatrixname] AS Cahpvamatrixname
	 , [new_cahpvareviewtype] AS Cahpvareviewtype
	 , [new_cahpvareviewtypename] AS Cahpvareviewtypename
	 , [new_cahpvastatus] AS Cahpvastatus
	 , [new_cahpvastatusname] AS Cahpvastatusname
	 , [new_cahpvatermcode] AS Cahpvatermcode
	 , [new_cahpvatermcodename] AS Cahpvatermcodename
	 , [new_cahpvatermcomment] AS Cahpvatermcomment
	 , [new_cahpvatermdate] AS Cahpvatermdate
	 , [RowCreatedDate]
	 , [DateKey] 
FROM [dbo].[CRM_AccountEntity_CAH]

GO
