USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetNextPortionPersistedStream]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNextPortionPersistedStream]
@DataPointer binary(16),
@DataIndex int,
@Length int
AS

READTEXT [ReportServer2017TempDB].dbo.PersistedStream.Content @DataPointer @DataIndex @Length
GO
