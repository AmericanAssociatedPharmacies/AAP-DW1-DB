USE [WebDev]
GO
/****** Object:  View [dbo].[v_web_pm_AllVolume]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_web_pm_AllVolume]
as
select * from pharmacymaster..all_volume
GO
