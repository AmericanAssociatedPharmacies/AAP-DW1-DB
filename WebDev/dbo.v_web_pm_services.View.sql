USE [WebDev]
GO
/****** Object:  View [dbo].[v_web_pm_services]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[v_web_pm_services]
as
select * from
--ex_user_pm_services
pharmacymaster..[v_web_pm_services]
GO
