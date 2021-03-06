USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_create_Mnthly_WHSales_CS_DYN]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <08/05/2010>
-- Description:	 Create FYTD WH Sales for Chriss S.
-- =============================================
CREATE PROCEDURE [dbo].[sppm_create_Mnthly_WHSales_CS_DYN]
(@in_month varchar(2), @in_year varchar(4) )

AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @MCOLBR varchar(20);
	DECLARE @MCOLGEN varchar(20);
	DECLARE @MCOLOTC varchar(20);
	DECLARE @MBR varchar(20);
	DECLARE @MGEN varchar(20);
	DECLARE @MOTC varchar(20);
    DECLARE @SQL varchar(6000);

	IF( @in_month = '01' or  @in_month = '1')
		BEGIN
			SET @MCOLBR = '[January BR]';
			SET @MCOLGEN = '[January GEN]';
			SET @MCOLOTC = '[January OTC]';
			SET @MBR = 'january_br';
			SET @MGEN = 'january_gen';
			SET @MOTC = 'january_otc';

		END
	IF( @in_month = '02' or  @in_month = '2')
		BEGIN
			SET @MCOLBR = '[February BR]';
			SET @MCOLGEN = '[February GEN]';
			SET @MCOLOTC = '[February OTC]';
			SET @MBR = 'february_br';
			SET @MGEN = 'february_gen';
			SET @MOTC = 'february_otc';

		END
	IF( @in_month = '03' or  @in_month = '3')
		BEGIN
			SET @MCOLBR = '[March BR]';
			SET @MCOLGEN = '[March GEN]';
			SET @MCOLOTC = '[March OTC]';
			SET @MBR = 'march_br';
			SET @MGEN = 'march_gen';
			SET @MOTC = 'march_otc';

		END
	IF( @in_month = '04' or  @in_month = '4')
		BEGIN
			SET @MCOLBR = '[April BR]';
			SET @MCOLGEN = '[April GEN]';
			SET @MCOLOTC = '[April OTC]';
			SET @MBR = 'april_br';
			SET @MGEN = 'april_gen';
			SET @MOTC = 'april_otc';

		END
	IF( @in_month = '05' or  @in_month = '5')
		BEGIN
			SET @MCOLBR = '[May BR]';
			SET @MCOLGEN = '[May GEN]';
			SET @MCOLOTC = '[May OTC]';
			SET @MBR = 'may_br';
			SET @MGEN = 'may_gen';
			SET @MOTC = 'may_otc';

		END
	IF( @in_month = '06' or  @in_month = '6')
		BEGIN
			SET @MCOLBR = '[June BR]';
			SET @MCOLGEN = '[June GEN]';
			SET @MCOLOTC = '[June OTC]';
			SET @MBR = 'june_br';
			SET @MGEN = 'june_gen';
			SET @MOTC = 'june_otc';

		END
	IF( @in_month = '07' or  @in_month = '7')
		BEGIN
			SET @MCOLBR = '[July BR]';
			SET @MCOLGEN = '[July GEN]';
			SET @MCOLOTC = '[July OTC]';
			SET @MBR = 'july_br';
			SET @MGEN = 'july_gen';
			SET @MOTC = 'july_otc';

		END
	IF( @in_month = '08' or  @in_month = '8')
		BEGIN
			SET @MCOLBR = '[August BR]';
			SET @MCOLGEN = '[August GEN]';
			SET @MCOLOTC = '[August OTC]';
			SET @MBR = 'august_br';
			SET @MGEN = 'august_gen';
			SET @MOTC = 'august_otc';

		END
	IF( @in_month = '09' or  @in_month = '9')
		BEGIN
			SET @MCOLBR = '[September BR]';
			SET @MCOLGEN = '[September GEN]';
			SET @MCOLOTC = '[September OTC]';
			SET @MBR = 'september_br';
			SET @MGEN = 'september_gen';
			SET @MOTC = 'september_otc';

		END
	IF( @in_month = '10'  )
		BEGIN
			SET @MCOLBR = '[October BR]';
			SET @MCOLGEN = '[October GEN]';
			SET @MCOLOTC = '[October OTC]';
			SET @MBR = 'october_br';
			SET @MGEN = 'october_gen';
			SET @MOTC = 'october_otc';

		END
	IF( @in_month = '11'  )
		BEGIN
			SET @MCOLBR = '[November BR]';
			SET @MCOLGEN = '[November GEN]';
			SET @MCOLOTC = '[November OTC]';
			SET @MBR = 'november_br';
			SET @MGEN = 'november_gen';
			SET @MOTC = 'november_otc';

		END

	IF( @in_month = '12'  )
		BEGIN
			SET @MCOLBR = '[December BR]';
			SET @MCOLGEN = '[December GEN]';
			SET @MCOLOTC = '[December OTC]';
			SET @MBR = 'december_br';
			SET @MGEN = 'december_gen';
			SET @MOTC = 'december_otc';

		END

	IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'tmp_mnthly_WH_Sales_CS')
          DROP TABLE tmp_mnthly_WH_Sales_CS


	SET @SQL = ' SELECT * into tmp_mnthly_WH_Sales_CS from ( '+
					' SELECT p.pmid as PMID,p.aapaccountno as AAP#,p.aapparentno as AAPParent#, '+
					'	case when  p.territory is null or p.territory = '''' then o.territory else p.territory end as Territory,  '+
					'	a.whaccountid as Acct#, '+
					'	case when p.apistatus is null then o.status else p.apistatus end as Status,  '+
					'	case when  p.accountname is null then o.accountname else p.accountname end as Name,  '+
					'	case when  p.state is null then o.state else p.state end as ST,  '+
					'	case when p.dateopened is null then o.dateopened else p.dateopened end as [Date Opened],  '+
					 	@MBR + ' as '  + @MCOLBR +' , ' + @MGEN + ' as ' +  @MCOLGEN + ', ' + @MOTC + ' as ' +  @MCOLOTC + ',' +
                    ' cast(0 as numeric(18,2)) as [Grand Total] ' +
					' FROM api..API_WHSales_Mnthly_ByType a '+
					' left outer join pharmacymaster..v_PM_AllWithAffiliates p on p.apiaccountno = a.whaccountid '+
					' left outer join   '+
					' (  '+
					'	select territory,accountname,city,state,status,dateopened,accountno from pmbackups..tmp_apiaccountmaster_orig   '+
					' ) o  on  a.whaccountid = o.accountno '+
					' where a.year = ' + @in_year  +
			  ' ) ch ';
 
	EXEC (@SQL)
 
    SET @SQL = '  Update tmp_mnthly_WH_Sales_CS set [Grand Total] = ' + @MCOLBR +'+'  + @MCOLGEN + '+' + @MCOLOTC;
 
    EXEC (@SQL)
END








GO
