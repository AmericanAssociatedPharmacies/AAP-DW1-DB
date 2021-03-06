USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetConfig_AreteInvoice_CopyTemplate]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetConfig_AreteInvoice_CopyTemplate]

	@FileDir VARCHAR(500)

AS

BEGIN

--SET @FileDir = '\\fs1\Server\IT Department\Arete\InvoiceDate\Template'

	SELECT CONVERT(VARCHAR(500), FilePath) AS Source
	, CONVERT(VARCHAR(500), REPLACE(FileDirectory, 'Template', '') + REPLACE(FileName, 'Template', CONVERT(varchar(20),GETDATE(),112))) AS Destination 
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)

END
GO
