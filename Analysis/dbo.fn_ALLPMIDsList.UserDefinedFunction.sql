USE [Analysis]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ALLPMIDsList]    Script Date: 12/22/2020 6:06:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Moultrie, Lovie>
-- Create date: <May 22, 2019>
-- Description:	<PMID Function for all PMIDS>
-- =============================================
CREATE FUNCTION [dbo].[fn_ALLPMIDsList] (@PMIDList int)

RETURNS TABLE 
AS
 RETURN
(
	-- Add the SELECT statement with parameter references here

	 SELECT DISTINCT V.PMID from [PharmacyMaster].[dbo].[All_Volume_new] V
	         LEFT JOIN PharmacyMaster.dbo.APItoPMID_LifeTime L
			 ON V.PMID = V.PMID
	 WHERE L.AAPEffectiveDate<= AAPEffectiveDate 
	 AND L.AAPQuitDate >= AAPQuitDate
	 AND V.PMID > 7
)
GO
