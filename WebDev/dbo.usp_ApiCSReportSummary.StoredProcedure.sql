USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_ApiCSReportSummary]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Chris McKinnie
-- Create date: 11/22/2017
-- =============================================
CREATE PROCEDURE [dbo].[usp_ApiCSReportSummary]
	@apiaccountno varchar(50),
	@datefrom datetime,
	@datethrough datetime
--with execute as 'webdevaap'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--exec api..spweb_apiCSReport @apiaccountno, @datefrom, @datethrough, @type
	select s.NDC, 
replace(replace(ItemDescription,'!',''),'*','') as [DescriptionSize],
sum(Qty) as [QuantityShipped]
from api..apisalesdetail s
where (ItemDescription like '!%' or ItemDescription like '*%')
and invdate >= @datefrom
and invdate <= @datethrough
and WHAccountID=@apiaccountno
group by s.NDC,Itemdescription
order by s.NDC
END
GO
