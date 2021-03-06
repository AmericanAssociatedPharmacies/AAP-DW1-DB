USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_SSRSDiagnostics]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_rpt_SSRSDiagnostics]
@Start DATETIME
,@End DATETIME
AS
SET NOCOUNT ON;
     SELECT [ReportServer].dbo.ExecutionLogStorage.[LogEntryId]
          , [ReportServer].dbo.ExecutionLogStorage.[InstanceName]
          , [ReportServer].dbo.ExecutionLogStorage.[ReportID]
          , [ReportServer].dbo.ExecutionLogStorage.[UserName]
          , [ReportServer].dbo.ExecutionLogStorage.[ExecutionId]
          , [ReportServer].dbo.ExecutionLogStorage.[RequestType]
          , [ReportServer].dbo.ExecutionLogStorage.[Format]
          , [ReportServer].dbo.ExecutionLogStorage.[Parameters]
          , [ReportServer].dbo.ExecutionLogStorage.[ReportAction]
          , [ReportServer].dbo.ExecutionLogStorage.[TimeStart]
          , [ReportServer].dbo.ExecutionLogStorage.[TimeEnd]
          , [ReportServer].dbo.ExecutionLogStorage.[TimeDataRetrieval]
          , [ReportServer].dbo.ExecutionLogStorage.[TimeProcessing]
          , [ReportServer].dbo.ExecutionLogStorage.[TimeRendering]
          , [ReportServer].dbo.ExecutionLogStorage.[Source]
          , [ReportServer].dbo.ExecutionLogStorage.[Status]
          , [ReportServer].dbo.ExecutionLogStorage.[ByteCount]
          , [ReportServer].dbo.ExecutionLogStorage.[RowCount]
          , [ReportServer].dbo.ExecutionLogStorage.[AdditionalInfo]
		, [ReportServer].dbo.Catalog.Name
     FROM [ReportServer].dbo.ExecutionLogStorage
	JOIN [ReportServer].dbo.Catalog ON [ReportServer].dbo.ExecutionLogStorage.ReportID = [ReportServer].dbo.Catalog.ItemID
	WHERE [ReportServer].dbo.ExecutionLogStorage.TimeStart >= ISNULL(@Start,[ReportServer].dbo.ExecutionLogStorage.TimeStart)
	AND [ReportServer].dbo.ExecutionLogStorage.TimeEnd <= ISNULL(@End,[ReportServer].dbo.ExecutionLogStorage.TimeEnd)
	ORDER BY [ReportServer].dbo.ExecutionLogStorage.TimeEnd DESC
GO
