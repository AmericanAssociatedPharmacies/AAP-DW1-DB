USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spAPI_FairShare_Update]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spAPI_FairShare_Update] 
(
	@CustNum varchar(15),
	@ProdNum varchar(15),
	@StartDate datetime,
	@RQuantity int
)
as
begin
update fairshare set [Requested Qty] = @RQuantity, [Last Updated]=getdate()
where Custnum=@Custnum
and ProdNum=@ProdNum
and [Start Date]=@StartDate
end
GO
