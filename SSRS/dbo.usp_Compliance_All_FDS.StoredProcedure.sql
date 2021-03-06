USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_All_FDS]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
Author: David Bohler 
Create Date: 08/27/2019 
Description: Compliance Report V5
*/

CREATE PROCEDURE [dbo].[usp_Compliance_All_FDS]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY	

	BEGIN TRAN

     TRUNCATE TABLE SSRS.dbo.rpt_Compliance_FDS;

     INSERT INTO SSRS.dbo.rpt_Compliance_FDS(PMID, [Dispense Qty], [Dispense @ AWP])
     SELECT a.[PMID]
          , a.[Dispense Qty]
          , a.[Dispense @ AWP]
     FROM [SSRS].[dbo].[vw_Comp_FDS] a;

	 COMMIT TRAN

END TRY
BEGIN CATCH

	ROLLBACK TRAN

END CATCH
END

GO
