USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spAPI_Fairshare_Dates]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spAPI_Fairshare_Dates]
as
select [BeginDate]
      ,[EndDate]
      ,[ShipWeekOf]
from webdev.dbo.Fairshare_Dates
where [BeginDate] = (select max(BeginDate) from webdev.dbo.Fairshare_Dates)
GO
