USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_StartRX30DataLoad_SQLJob]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_StartRX30DataLoad_SQLJob]

AS

SET NOCOUNT ON;

BEGIN


	EXEC msdb.dbo.sp_start_job N'RX30 Data Load';  


END
GO
