USE [WebDev]
GO
/****** Object:  View [dbo].[v_PM_AnnualRebates]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_PM_AnnualRebates]
as
select * from pharmacymaster..PM_AnnualRebates
GO
