USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_APISalesDetail]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_Delete_APISalesDetail] 

@InvDate Varchar(13)

as

DELETE 
from API.dbo.APISalesDetail 
where InvDate=@InvDate

CHECKPOINT

GO
