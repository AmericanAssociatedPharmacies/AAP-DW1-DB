USE [API]
GO
/****** Object:  StoredProcedure [dbo].[uSP_select_APISalesDetail]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[uSP_select_APISalesDetail] @InvDate Varchar(13)
as
Select *
from API.dbo.APISalesDetail
where InvDate=@InvDate
GO
