USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRxCareSelect_NDC5List]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spRxCareSelect_NDC5List]
--               10/16/2015 DG  sorted by DrugName 
as
--select NDC,Drugname from  DCPriceRx05 order by NDC
select NDC,Drugname from  DCPriceRx05 order by Drugname
GO
