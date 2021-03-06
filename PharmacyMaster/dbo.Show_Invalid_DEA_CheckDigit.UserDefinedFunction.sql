USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[Show_Invalid_DEA_CheckDigit]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rudy Hinojosa
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Show_Invalid_DEA_CheckDigit]
(	
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	WITH INVALIDCHECKDIGIT
AS 
(
select 
PMID,
dea,
substring(dea,9,1) as 'CHECKDIGIT',
(cast(dbo.udf_parsealphachars(substring(DEA,3,1)) as integer) + cast(dbo.udf_parsealphachars(substring(DEA,5,1)) as integer) + cast(dbo.udf_parsealphachars(substring(DEA,7,1)) as integer)) +
(cast(dbo.udf_parsealphachars(substring(DEA,4,1)) as integer) + cast(dbo.udf_parsealphachars(substring(DEA,6,1)) as integer) + cast(dbo.udf_parsealphachars(substring(DEA,8,1)) as integer)) * 2 AS 'CALCDIGIT'
from pm_pharmacy where dea is not null AND ISNUMERIC(SUBSTRING(DEA,7,3)) = 1 AND substring(dea,9,1) <> RIGHT(CAST((cast(dbo.udf_parsealphachars(substring(DEA,3,1)) as integer) + cast(dbo.udf_parsealphachars(substring(DEA,5,1)) as integer) + cast(dbo.udf_parsealphachars(substring(DEA,7,1)) as integer)) +
(cast(dbo.udf_parsealphachars(substring(DEA,4,1)) as integer) + cast(dbo.udf_parsealphachars(substring(DEA,6,1)) as integer) + cast(dbo.udf_parsealphachars(substring(DEA,8,1)) as integer)) * 2 AS VARCHAR(2)),1)
--UNION ALL
--SELECT PMID,DEA FROM TMP WHERE CHECKDIGIT <> RIGHT(CAST(CALCDIGIT AS VARCHAR(2)),1)
UNION ALL
SELECT PMID,DEA,'' AS CHECKDIGIT, '' AS CALCDIGIT FROM PM_PHARMACY WHERE ISNUMERIC(SUBSTRING(DEA,3,1)) = 0 AND DEA IS NOT NULL 
--ORDER BY PMID
)

SELECT PMID,DEA FROM INVALIDCHECKDIGIT

)
GO
