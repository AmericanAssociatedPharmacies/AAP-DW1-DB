USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_Fairshare_Report_Details]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_API_Fairshare_Report_Details]
	-- Add the parameters for the stored procedure here
		@EndDate DATETIME2
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dt.*, p.pmid, p.accountname as [AccountName] , p.city as [City], p.state as [State], p.Territory 
	FROM FairShareProgram dt
	LEFT JOIN pharmacymaster..v_pm_pharmacy p on p.apiaccountno = dt.custnum
	WHERE [RequestedQty] > 0 AND [EndDate] = @EndDate
	ORDER BY custnum
	END
GO
