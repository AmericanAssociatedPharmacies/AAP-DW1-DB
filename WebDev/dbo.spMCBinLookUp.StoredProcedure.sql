USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spMCBinLookUp]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spMCBinLookUp]
AS
BEGIN
	select * from data_BINReference
END
GO
