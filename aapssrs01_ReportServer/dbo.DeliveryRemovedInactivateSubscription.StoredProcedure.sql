USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[DeliveryRemovedInactivateSubscription]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeliveryRemovedInactivateSubscription]
@DeliveryExtension nvarchar(260),
@Status nvarchar(260)
AS
update
    Subscriptions
set
    [DeliveryExtension] = '',
    [InactiveFlags] = [InactiveFlags] | 1, -- Delivery Provider Removed Flag == 1
    [LastStatus] = @Status
where
    [DeliveryExtension] = @DeliveryExtension
GO
