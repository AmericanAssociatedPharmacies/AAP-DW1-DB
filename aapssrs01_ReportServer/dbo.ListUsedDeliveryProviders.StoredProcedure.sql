USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[ListUsedDeliveryProviders]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListUsedDeliveryProviders]
AS
select distinct [DeliveryExtension] from Subscriptions where [DeliveryExtension] <> ''
GO
