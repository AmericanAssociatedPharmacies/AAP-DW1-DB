USE [Medispan]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_AS400Medispan_Export]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_API_AS400Medispan_Export]

AS

SET NOCOUNT ON;

BEGIN

	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2GPPC OUT \\fs1.aap.local\api\API_Medispan_MF2GPPC.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2GPR OUT \\fs1.aap.local\api\API_Medispan_MF2GPR.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2LAB OUT \\fs1.aap.local\api\API_Medispan_MF2LAB.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2MOD OUT \\fs1.aap.local\api\API_Medispan_MF2MOD.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2NAME OUT \\fs1.aap.local\api\API_Medispan_MF2NAME.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2NDC OUT \\fs1.aap.local\api\API_Medispan_MF2NDC.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2NDCM OUT \\fs1.aap.local\api\API_Medispan_MF2NDCM.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2PRC OUT \\fs1.aap.local\api\API_Medispan_MF2PRC.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2SEC OUT \\fs1.aap.local\api\API_Medispan_MF2SEC.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2TCGPI OUT \\fs1.aap.local\api\API_Medispan_MF2TCGPI.txt -a 32767 -c -t, -T -S'
	Exec master..xp_cmdShell 'bcp Medispan.dbo.vw_API_MF2VAL OUT \\fs1.aap.local\api\API_Medispan_MF2VAL.txt -a 32767 -c -t, -T -S'

END
GO
