USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimsDDS_RX30_GetListOfFiles]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ClaimsDDS_RX30_GetListOfFiles] 

AS

SET NOCOUNT ON;

BEGIN

	SELECT FilePath
	FROM [dbo].[mtvf_GetFileInfo]('\\fs1.aap.local\Server\IT Department\RX30\Staging\')
	WHERE FileName LIKE '%.csv'

END
GO
