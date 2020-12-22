USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_PM_Pharmacy_BCPOUT]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_PM_Pharmacy_BCPOUT]

AS

SET NOCOUNT ON;

BEGIN

	EXEC master..xp_cmdshell 'bcp DynamicsODS.Staging.vw_PM_Pharmacy_DB1 OUT "\\fs1.aap.local\Server\IT Department\Dynamics\PharmacyMasterDB1\PharmacyMaster.dat" -c -t^| -T',no_output

END
GO
