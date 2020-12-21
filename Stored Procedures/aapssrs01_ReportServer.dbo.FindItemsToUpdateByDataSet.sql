USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[FindItemsToUpdateByDataSet] Script Date: 12/21/2020 8:55:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FindItemsToUpdateByDataSet]
@DataSetID uniqueidentifier
AS

select
        6, /* KpiDataUpdate enum. ToDo: Retrieve this from DB instead*/
        RS.[ScheduleID],
        DS.[ItemID],
        RS.[SubscriptionID],
        C.[Path],
        C.[Type]
from
    [DataSets] DS Inner join [Catalog] C on C.[ItemID] = DS.[ItemID]
    Inner join [ReportSchedule] RS on RS.[ReportID] = DS.[LinkID]
where
    DS.[LinkID] = @DataSetID
