USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_update_PM_Modifications]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <04/28/2010>
-- Description:	UPdate PM_Programs table
-- =============================================
CREATE PROCEDURE [dbo].[sppm_update_PM_Modifications]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table

   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_Modifications_bkp')
          DROP TABLE PM_Modifications_bkp

   SELECT * into PM_Modifications_bkp from PM_Modifications

    IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_Modifications')
          DROP TABLE PM_Modifications

	SELECT * into  PM_Modifications from (


	SELECT p.PMID,m.ModDate,m.ModType,m.WhyModified as Reason from aap..AAPStoreModifications m 
	 join aap..aapaccount a  on m.accountid = a.accountid
	 join pharmacymaster..pm_pharmacy p on a.dea = p.dea


	) ch
 



 
END








GO
