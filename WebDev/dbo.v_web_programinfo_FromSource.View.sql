USE [WebDev]
GO
/****** Object:  View [dbo].[v_web_programinfo_FromSource]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_web_programinfo_FromSource]
as
select * from pharmacymaster..v_web_pm_userprograms
GO
