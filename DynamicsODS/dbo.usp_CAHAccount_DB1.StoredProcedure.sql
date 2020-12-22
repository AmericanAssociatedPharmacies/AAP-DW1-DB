USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAHAccount_DB1]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAHAccount_DB1]

AS

SET NOCOUNT ON;

BEGIN


	SELECT PMID, CAHAccountNo, AAPEffectiveDate, AAPQuitDate, AAPEffectiveDateKey, AAPQuitDateKey, CorrectedCAHAccountNo, AAPAccountNo, PreviousMemberPMID
	FROM [dbo].[vwCAHAccount]
	ORDER BY PMID ASC

END

GO
