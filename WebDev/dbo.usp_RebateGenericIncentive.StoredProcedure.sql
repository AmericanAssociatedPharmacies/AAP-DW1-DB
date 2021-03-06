USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_RebateGenericIncentive]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_RebateGenericIncentive]
	-- Add the parameters for the stored procedure here
	@PMID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
top 1
[Year],
[TotalGenerics] as [TotalGenerics],
[GenericIncentive] as [RebateAmount]
from
PharmacyMaster..PM_AnnualRebates
where pmid=@PMID
order by [Year] desc
END
GO
