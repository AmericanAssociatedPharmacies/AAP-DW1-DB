USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Taxonomy_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_Taxonomy_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[Taxonomy] AS T
	USING (SELECT [NCPDPProviderID], [TaxonomyCode], [ProviderTypeCode], [DeleteDate]
		   FROM [Staging].[vw_NCPDP_Taxonomy]
		   ) AS S
				([NCPDPProviderID], [TaxonomyCode], [ProviderTypeCode], [DeleteDate])
		  ON T.[NCPDPProviderID] = S.[NCPDPProviderID]
		  AND T.ProviderTypeCode = s.ProviderTypeCode

WHEN MATCHED THEN

UPDATE SET [TaxonomyCode] = S.[TaxonomyCode]
		 , [DeleteDate] = S.[DeleteDate]

WHEN NOT MATCHED THEN
		INSERT ([NCPDPProviderID], ProviderTypeCode, [TaxonomyCode], [DeleteDate])
		VALUES (S.[NCPDPProviderID], S.ProviderTypeCode, S.[TaxonomyCode], S.[DeleteDate]);
END



GO
