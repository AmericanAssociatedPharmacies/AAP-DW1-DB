USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_All_API]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
Author: David Bohler 
Create Date: 08/27/2019 
Description: Compliance Report V5
*/

CREATE PROCEDURE [dbo].[usp_Compliance_All_API]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	 BEGIN TRAN

     TRUNCATE TABLE SSRS.dbo.rpt_Compliance_API;

     INSERT INTO SSRS.dbo.rpt_Compliance_API(PMID, [Purchase Qty], [Purchases @ AWP])
     SELECT a.PMID
          , a.[Purchase Qty]
          , a.[Purchases @ AWP]
     FROM SSRS.dbo.vw_Comp_API AS a;

	 COMMIT TRAN

END TRY
BEGIN CATCH

	ROLLBACK TRAN

END CATCH
END 


GO
