USE [WebDev]
GO
/****** Object:  View [dbo].[v_CredentiallingPrepopulateTMP]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_CredentiallingPrepopulateTMP]
AS
-- per Deepa and Bruce a NCPDP may have several pmid, we load our data by pmid therefore we may not need to update our view at all
-- below is the view load on rank = 1 or rank is null
SELECT ou.* 
FROM (select c.* , Rank() OVER (PARTITION BY c.NCPDP ORDER BY c.PMID DESC) AS [Rank] 
from pharmacymaster..v_CredentiallingPrepopulate c) ou
WHERE ou.NCPDP IS NULL OR  ou.[RANK] = 1 

GO
