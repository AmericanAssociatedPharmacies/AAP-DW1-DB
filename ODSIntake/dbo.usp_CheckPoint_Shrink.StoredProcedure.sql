USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckPoint_Shrink]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[usp_CheckPoint_Shrink]
AS 
SET NOCOUNT ON;

DBCC SHRINKFILE (2, 10)

CHECKPOINT



GO
