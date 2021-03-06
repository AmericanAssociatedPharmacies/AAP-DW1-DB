USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_get_Shipping_Invoice]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spweb_get_Shipping_Invoice]
(@whaccount varchar(15),@includeDays int)
  
AS
SET NOCOUNT ON 

BEGIN

	DECLARE @days int;
	SET @days = @includeDays * -1;
	SELECT WHAccountid,InvNbr,InvDate,OrderNbr,CarrierCode,CarrierDesc,Whsnum,
         Whsname from  APISalesInvoice_Web where WHAccountid =  @whaccount
		and invdate > (select DATEADD(d,@days,getdate())) order by invdate desc
END

SET NOCOUNT OFF
GO
