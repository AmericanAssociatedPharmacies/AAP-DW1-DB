USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_weather_alert_get]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spweb_weather_alert_get]
as 
select item,value from content_strings
where category='api_weather_alert'
GO
