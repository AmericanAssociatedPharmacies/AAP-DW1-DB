USE [Pricing]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_Staging_ABC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Staging].[usp_Load_Staging_ABC]


/*******************************************************************************

-- Author: Scott Edwards
-- Description: Used to insert\update ABC information for PricingFAct table.
-- InParameter: N\A
-- OutParameter: N\A
-- Created Date: 08/25/2017
-- Revision History :
-- Modified Date Modified By version Description
-- Test code: Execute sproc as is.

********************************************************************************/

AS

SET NOCOUNT ON;

BEGIN

	--Windows function to keep out duplicate rows
	SELECT dt.DateKey
	, dt.ABCItemNum
	, dt.NDC
	, dt.ABC_AWP
	, dt.ABCInvoicePrice
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY [DateKey], [NDC] ORDER BY(SELECT NULL)) AS RN
			, DateKey
			, ABCItemNum
			, NDC
			, ABC_AWP
			, ABCInvoicePrice
			FROM [Staging].[vwABC]
		) AS dt
	WHERE dt.RN = 1

END


GO
