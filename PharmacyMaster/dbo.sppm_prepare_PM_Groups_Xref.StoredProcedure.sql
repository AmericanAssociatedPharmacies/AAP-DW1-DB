USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_prepare_PM_Groups_Xref]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <03/29/2010>
-- Description:	Backup and Truncate PM_Groups_Xref to recreate
-- =============================================
CREATE PROCEDURE [dbo].[sppm_prepare_PM_Groups_Xref]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table


   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_Groups_xref_bkp')
          DROP TABLE PM_Groups_xref_bkp
  
   SELECT * into  PM_Groups_xref_bkp from PM_Groups_xref

  -- TRUNCATE TABLE PM_Groups_xref
END








GO
