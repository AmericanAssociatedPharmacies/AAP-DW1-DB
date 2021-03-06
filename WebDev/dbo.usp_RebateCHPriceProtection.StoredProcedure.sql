USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_RebateCHPriceProtection]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_RebateCHPriceProtection]
	-- Add the parameters for the stored procedure here
	@PMID int
AS
BEGIN
	/*BG 10/27/14
	Originally started with 8/14 rebate paid in 9/2014 payment file, date adjustment removed 2/15
	Note that the rebate-paid file date shown here is 1 month greater than the detail in pharmacymaster..CA_PriceProtection
	*/
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @startdate_CHMonthly datetime
set @startdate_CHMonthly = '9/1/2014'
select 
top 6
[date] as [filedate]
-- ***HACK FOR FIRST MONTH, removed 2/15 BG***
--,case when [date]='9/1/2014' then 'August 2014' else datename(month,[date]) + ' ' + convert(varchar(4),year([date])) end as [Rebate For]
,[date] as [RebateFor]
,[PriceProtectionRebate] as [RebateAmount]
--,'' as Detail

from pharmacymaster..PM_Rebates_CHAAP
	where pmid=@PMID
	and [date] >= @startdate_CHMonthly
	order by [date] desc
END
GO
