USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spGMReport_AAPAvg]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGMReport_AAPAvg]
as
--Select AAPAvg FROM GMAvg where Date=(select max(Date)from GMAvg)
Select top 1 AAPAvg FROM GMAvg order by [date] desc

--select * from GMAvg
GO
