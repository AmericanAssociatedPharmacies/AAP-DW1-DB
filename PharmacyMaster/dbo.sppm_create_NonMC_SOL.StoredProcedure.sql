USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_create_NonMC_SOL]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <09/10/2010>
-- Description:	Create table for compare to get listing of non MC for Solomon
-- =============================================
CREATE PROCEDURE [dbo].[sppm_create_NonMC_SOL]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table

DECLARE @date varchar(100);
DECLARE @dateTable varchar(100);
DECLARE @SQL varchar(200);

SET @date =  GetDate();
SET @dateTable =  replace(@date,' ','');
SET @dateTable =  replace(@dateTable,':','');

SET @SQL = 'SELECT * into tmp_NonMC_Sol' + @dateTable + ' from tmp_NonMC_Sol';
EXEC(@SQL);

   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'tmp_NonMC_Sol')
	BEGIN
		 IF EXISTS(SELECT name FROM sys.tables
			 WHERE name = 'tmp_NonMC_Sol_bkp')
		 BEGIN
          DROP TABLE tmp_NonMC_Sol_bkp
         END
 
     SELECT * into  tmp_NonMC_Sol_bkp from tmp_NonMC_Sol
     DROP TABLE tmp_NonMC_Sol
    END


   SELECT * into tmp_NonMC_Sol from (
		SELECT p.PMID,p.AAPAccountno,p.AccountName,p.AAPEffectiveDate,p.AAPQuitDate ,a.Address,a.Address2,a.City,a.State,a.Zip,p.OwnerName as ContactFullName,p.NCPDP,p.FedID,p.CorporateName from pm_pharmacy	p
		left outer join
		(
			SELECT * from pm_managedcare
		) m
		on p.pmid = m.pmid
		join
		(
			SELECT * from v_Address_Mailing_Financials 
		)a
		on p.pmid = a.pmid
		where  (m.chaincode is null and  aapaccountno is not null)  or (m.chaincode is null and aapaccountno is null and isNpp = 1 ) 
) ch
END








GO
