USE [SSISDB]
GO
/****** Object:  View [catalog].[customized_logging_levels]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [catalog].[customized_logging_levels]
AS
SELECT     [level_id],
           [name],
           [description],
           [profile_value],
           [events_value],
           [created_by_sid],
           [created_by_name],
           [created_time]
FROM       [internal].[customized_logging_levels]
GO
