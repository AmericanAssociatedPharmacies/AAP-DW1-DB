USE [Medispan]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_Export]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_API_Export]

AS

SET NOCOUNT ON;

BEGIN

	Exec master..xp_cmdShell 'bcp Medispan.dbo.v_API OUT \\fs1.aap.local\api\API_Medispan.txt -a 32767 -c -T -S'

END
GO
