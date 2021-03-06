USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PMUpdateRx30]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JOSHILA NARAYANAN
-- Create date: 02/15/2011
-- Description:	Updates ComputerSoftware field in PM_Pharmacy with Rx3
-- =============================================
CREATE PROCEDURE [dbo].[spud_PMUpdateRx30]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SET ANSI_WARNINGS OFF 
-- Gets rid of this error "String or binary data would be truncated"

/*Update PM_Pharmacy Set ComputerSoftware = NULL	
	WHERE PM_Pharmacy.ComputerSoftware ='Rx30' AND AAPQuitDate IS NULL*/

/*

Update PM_Pharmacy Set ComputerSoftware = 'QS1' 
FROM PM_Pharmacy JOIN claims.dbo.v_DALoadDetails ON PM_Pharmacy.NCPDP = claims.dbo.v_DALoadDetails.[NCPDP]
WHERE Loaddate='7/1/2015 6:15:00 AM'

*/

Update PM_Pharmacy Set ComputerSoftware = 'Rx30' 
	FROM PM_Pharmacy JOIN claims.dbo.Rx30ClaimsStores ON PM_Pharmacy.NCPDP = claims.dbo.Rx30ClaimsStores.[Pharm ID]
	WHERE AAPQuitDate IS NULL AND claims.dbo.Rx30ClaimsStores.[Pharm ID] IS NOT NULL AND claims.dbo.Rx30ClaimsStores.[Pharm ID] <> '' AND PM_Pharmacy.NCPDP IS NOT NULL
	AND PM_Pharmacy.NCPDP <> ''


SET ANSI_WARNINGS ON

END
GO
