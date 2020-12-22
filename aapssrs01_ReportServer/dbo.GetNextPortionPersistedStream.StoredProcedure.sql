USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[GetNextPortionPersistedStream]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNextPortionPersistedStream]
@DataPointer binary(16),
@DataIndex int,
@Length int
AS

READTEXT [aapssrs01_ReportServerTempDB].dbo.PersistedStream.Content @DataPointer @DataIndex @Length
GO
