USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_update_CH_ALLPVA_SALES_UD_DYN]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <04/28/2010> 
-- Description:	UPdate PM_Programs table
-- =============================================
CREATE PROCEDURE [dbo].[sppm_update_CH_ALLPVA_SALES_UD_DYN]
(@in_month varchar(2), @in_year varchar(4))
AS
BEGIN
    --THE VOLUME AND GEN INDEXING REBATE TABLES MUST BE COPIED TO UDDW1 BEFORE RUNNING
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    DECLARE @date varchar(10);
	DECLARE @MONTH varchar(15);
	DECLARE @SQL varchar(6000);


	SET @date = @in_month + '/01/' +   @in_year;

	IF( @in_month = '01')
		 BEGIN
		   SET @MONTH = 'January';
		 END
	IF( @in_month = '02')
		 BEGIN
		   SET @MONTH = 'February';
		 END
	IF( @in_month = '03')
		 BEGIN
		   SET @MONTH = 'March';
		 END
	IF( @in_month = '04')
		 BEGIN
		   SET @MONTH = 'April';
		 END
	IF( @in_month = '05')
		 BEGIN
		   SET @MONTH = 'May';
		 END
	IF( @in_month = '06')
		 BEGIN
		   SET @MONTH = 'June';
		 END
	IF( @in_month = '07')
		 BEGIN
		   SET @MONTH = 'July';
		 END
	IF( @in_month = '08')
		 BEGIN
		   SET @MONTH = 'August';
		 END
  	IF( @in_month = '09')
		 BEGIN
		   SET @MONTH = 'September';
		 END
	IF( @in_month = '10')
		 BEGIN
		   SET @MONTH = 'October';
		 END
	IF( @in_month = '11')
		 BEGIN
		   SET @MONTH = 'November';
		 END
	IF( @in_month = '12')
		 BEGIN
		   SET @MONTH = 'December';
		 END
 --TO UPDATE UDNetSales from Volume 


SET @SQL = 'UPDATE su set '+
		' UDNetSales = month, '+
        ' udaccountno =  vol.udaccountno, '+
		' accountname = vol.accountname  '+
	    ' FROM   pharmacymaster..CH_ALLPVA_SALES su '+
		'	inner join '+
		'	 (  '+
        '      	select sum(' + @MONTH + ') as month,case when  udaccountno is null then  aapaccountno else  udaccountno end as udaccountno,pmid ,accountname '+
		'		from reporting..volumecalyy n '+
		'		left outer join '+
		'			(SELECT pmid,udaccountno,aapAccountNo,accountname FROM PM_Pharmacy) pm on pm.UDAccountNo = n.acct_no or pm.aapAccountNo = n.acct_no '+
		'			where vendor_id in (65,86) and year = ' + @in_year   + ' AND ( ' + @MONTH + ' <> 0 )   '+
		'		group by udaccountno,aapaccountno,pmid,accountname '+

		'	 ) vol '+
		'  on su.pmid = vol.pmid where month(su.date) = ' + @in_month + ' and year(su.date) = ' + @in_year;

 EXEC (@SQL) 
 print @sql



 
--FOR INSERT  of UDNetSales from Volume - changed to check for PMID instead of DEA

 SET @SQL = ' INSERT  into CH_ALLPVA_SALES (date,UDNetSales,udaccountno,DEA,PMID,accountname) '+
         ' SELECT * FROM (  '+
	     '	SELECT ''' +@date+ ''' as date,sum(' + @MONTH + ') as sales,case when pm.udaccountno is null then pm.aapaccountno else pm.udaccountno end as udaccountno,dea,pmid ,accountname  '+
	     '		from reporting..volumecalyy n '+
	     '		left outer join '+
	     '			(SELECT pmid,DEA,udaccountno,aapAccountNo,accountname FROM  PM_Pharmacy) '+
         '            pm on pm.UDAccountNo = n.acct_no or pm.aapAccountNo = n.acct_no '+
		 '			where vendor_id in (65,86) and year = '+ @in_year   + ' AND ( ' + @MONTH + ' <> 0 )    '+
         '       group by udaccountno,aapaccountno,dea ,pmid,accountname '+
		 ' )vol'+
	' WHERE not exists  (select pmid from pharmacymaster..CH_ALLPVA_SALES  where month(date) = ' + @in_month + ' and year(date) = ' + @in_year + ' and pmid = vol.pmid); ';
 EXEC (@SQL) 
 print @sql

--To Update UDAccountno with Generic and Brand from Indexing Gen Rebate
 
 
	UPDATE a
	SET a.UDGenTotalSrc = g.gen_vol_amt,
	a.UDGenTotal = g.gen_vol_amt, 
	a.UDBrand = (g.rx_vol_amt - g.gen_vol_amt),
	a.UDOTC = a.UDNetSales - g.rx_vol_amt
	 FROM 
	CH_ALLPVA_SALES a     
	left join   
	(
		SELECT 
		pmid,[date],
		sum(gen_vol_amt) as gen_vol_amt, sum(rx_vol_amt) as rx_vol_amt
		FROM
		(
		SELECT  
		p.pmid, v.apply_dt as [date], v.gen_vol_amt, v.rx_vol_amt
		FROM reporting..IndexingGenRebate v left join pharmacymaster..pm_pharmacy p
			on (v.ud_acct = p.udaccountno or v.ud_acct =p.aapaccountno)
		WHERE apply_dt >= '1/1/' + @in_year                              
	) dt
	group by pmid,[date]
	) g
	on a.pmid=g.pmid and a.[date]=g.[date]    
	WHERE g.pmid is not null and month(a.date) = @in_month and  year(a.date) = @in_year-- change date here
 
--Need to set to zero first if they are null
	UPDATE CH_ALLPVA_SALES SET UDBrand = 0.00 where UDBrand is null;
	UPDATE CH_ALLPVA_SALES SET UDGENTotal = 0.00 where UDGENTotal is null;
	UPDATE CH_ALLPVA_SALES SET UDGENTotalSrc = 0.00 where UDGENTotalSrc is null;
	UPDATE CH_ALLPVA_SALES SET UDOTC = 0.00 where UDOTC is null;
	UPDATE CH_ALLPVA_SALES SET UDOther = 0.00 where UDOther is null;
	UPDATE CH_ALLPVA_SALES SET UDNetSales = 0.00 where UDNetSales is null;
-- NEED TO SET UDADMINLONLY and COMBADMINONLY from UDNETSALES - only when there were no generics - run set to ZERO first!!!!!!!!!!!!!1
	   UPDATE  su  set 
			udadminonly = ch.udnetsales,
			combadminonly =    ch.udnetsales
	   FROM CH_ALLPVA_SALES   su 
		inner join 
			( select udnetsales,pmid,date from CH_ALLPVA_SALES where udbrand = 0 and
				udgentotalsrc = 0 and udgentotal = 0 and udotc = 0 and udother = 0
				and udnetsales != 0 and month(date) = @in_month and year(date) = @in_year) ch -- Change DATE
	   on su.pmid = ch.pmid   where  month(su.date) = @in_month   and year(su.date) = @in_year

 


--SET TO ZERO WHERE NULL
	UPDATE CH_ALLPVA_SALES SET APICOGAppliedSales = 0.00 where APICOGAppliedSales is null;
	UPDATE CH_ALLPVA_SALES SET APINetSales  = 0.00 where APINetSales is null;
	UPDATE CH_ALLPVA_SALES SET APIGENRx = 0.00 where APIGENRx is null;
	UPDATE CH_ALLPVA_SALES SET APIGENTotalSrc = 0.00 where APIGENTotalSrc is null;
	UPDATE CH_ALLPVA_SALES SET APIGENTotalP2P3 = 0.00 where APIGENTotalP2P3 is null;
	UPDATE CH_ALLPVA_SALES SET APIGENTotal = 0.00 where APIGENTotal is null;
	UPDATE CH_ALLPVA_SALES SET APIBrand = 0.00 where APIBrand is null;
	UPDATE CH_ALLPVA_SALES SET APIOTC = 0.00 where APIOTC is null;
	UPDATE CH_ALLPVA_SALES SET APIGBRPerc = 0.00 where APIGBRPerc is null;
	UPDATE CH_ALLPVA_SALES SET AAPCOGAppliedSales = 0.00 where AAPCOGAppliedSales is null;
	UPDATE CH_ALLPVA_SALES SET AAPNetSales = 0.00 where AAPNetSales is null;
	UPDATE CH_ALLPVA_SALES SET AAPBrand = 0.00 where AAPBrand is null;
	UPDATE CH_ALLPVA_SALES SET AAPGENTotal = 0.00 where AAPGENTotal is null;
	UPDATE CH_ALLPVA_SALES SET AAPGENTotalSrc = 0.00 where AAPGENTotalSrc is null;
	UPDATE CH_ALLPVA_SALES SET AAPGENExcl = 0.00 where AAPGENExcl is null;
	UPDATE CH_ALLPVA_SALES SET AAPOTC = 0.00 where AAPOTC is null;
	UPDATE CH_ALLPVA_SALES SET AAPOther = 0.00 where AAPOther is null;

UPDATE CH_ALLPVA_SALES SET AAPTotalRX = 0.00 where AAPTotalRX is null;
	UPDATE CH_ALLPVA_SALES SET AAPExcludedFromTotalRX = 0.00 where AAPExcludedFromTotalRX is null;
	UPDATE CH_ALLPVA_SALES SET AAPNonRXOTCandHH = 0.00 where AAPNonRXOTCandHH is null;
	UPDATE CH_ALLPVA_SALES SET AAPSourceCompliance = 0.00 where AAPSourceCompliance is null;

	UPDATE CH_ALLPVA_SALES SET UDNetSales = 0.00 where UDNetSales is null;
	UPDATE CH_ALLPVA_SALES SET UDBrand = 0.00 where UDBrand is null;
	UPDATE CH_ALLPVA_SALES SET UDGENTotal = 0.00 where UDGENTotal is null;
	UPDATE CH_ALLPVA_SALES SET UDGENTotalSrc = 0.00 where UDGENTotalSrc is null;
	UPDATE CH_ALLPVA_SALES SET UDOTC = 0.00 where UDOTC is null;
	UPDATE CH_ALLPVA_SALES SET UDOther = 0.00 where UDOther is null;
	UPDATE CH_ALLPVA_SALES SET CombNetSales = 0.00 where CombNetSales is null;
	UPDATE CH_ALLPVA_SALES SET CombBrands = 0.00 where CombBrands is null;
	UPDATE CH_ALLPVA_SALES SET CombOTC = 0.00 where CombOTC is null;
	UPDATE CH_ALLPVA_SALES SET CombGENTotal = 0.00 where CombGENTotal is null;
	UPDATE CH_ALLPVA_SALES SET CombGENTotalSrc = 0.00 where CombGENTotalSrc is null;
    UPDATE CH_ALLPVA_SALES SET CombOther = 0.00 where CombOther is null;

	UPDATE CH_ALLPVA_SALES SET APIOther = 0.0 where APIOther is null;
	UPDATE CH_ALLPVA_SALES SET UDAdminOnly = 0.0 where UDAdminOnly is null
	UPDATE CH_ALLPVA_SALES SET CombAdminOnly = 0.0 where CombAdminOnly is null;


	UPDATE CH_ALLPVA_SALES set CombNetSales = APINetSales + AAPNetSales + UDNetSales;
	UPDATE CH_ALLPVA_SALES set CombBrands = APIBrand + AAPBrand + UDBrand;
    UPDATE CH_ALLPVA_SALES SET CombOTC = APIOTC + AAPOTC + UDOTC;
    UPDATE CH_ALLPVA_SALES SET CombGENTotal = APIGENTotal + AAPGENTotal + UDGENTotal;
    UPDATE CH_ALLPVA_SALES SET CombGENTotalSrc = APIGENTotalSrc + AAPGENTotalSrc + UDGENTotalSrc;
    UPDATE CH_ALLPVA_SALES SET CombOther = AAPOther + UDOther + APIOther;
	UPDATE CH_ALLPVA_SALES SET CombAdminOnly = UDAdminOnly;

--QA TOTALS
--	select sum(CombNetSales), sum( APINetSales + AAPNetSales + UDNetSales) from CH_ALLPVA_SALES where month(date) = 05
--	select  sum(CombBrands) ,sum(APIBrand + AAPBrand + UDBrand ) from CH_ALLPVA_SALES where month(date) = 05
--    select   sum(CombOTC), sum(APIOTC + AAPOTC + UDOTC) from CH_ALLPVA_SALES where month(date) = 05
--    select   sum(CombGENTotal),sum(APIGENTotal + AAPGENTotal + UDGENTotal) from CH_ALLPVA_SALES where month(date) = 05
--    select   sum(CombGENTotalSrc), sum(APIGENTotalSrc + AAPGENTotalSrc + UDGENTotalSrc) from CH_ALLPVA_SALES where month(date) = 05
--    select   sum(CombOther), sum(AAPOther + UDOther + APIOther) from CH_ALLPVA_SALES where month(date) = 05
--	select   sum(CombAdminOnly), sum(UDAdminOnly) from CH_ALLPVA_SALES where month(date) = 05

-- DOn't know if want to do this - can use pmid to get the accountno
--		UPDATE  su  set 
--			aapaccountno = ch.aapaccountno  
--	   FROM CH_ALLPVA_SALES_TEST_DYN_UD_BKP  su 
--		inner join 
--			( select aapaccountno,udaccountno,dea from pm_pharmacy where dea is not null and aapaccountno is not null ) ch
--	   on su.dea = ch.dea where su.aapaccountno is null and su.udaccountno is not null   
--
--	select su.aapaccountno,su.udaccountno,ch.aapaccountno,ch.udaccountno 
--	   FROM CH_ALLPVA_SALES_TEST_DYN_UD_BKP  su 
--		inner join 
--			( select aapaccountno,udaccountno,dea from pm_pharmacy where dea is not null and aapaccountno is not null ) ch
--	   on su.dea = ch.dea where su.aapaccountno is null and su.udaccountno is not null
--------------------
--		UPDATE  su  set 
--			aapaccountno = ch.aapaccountno  
--	   FROM CH_ALLPVA_SALES_TEST_DYN_UD_BKP  su 
--		inner join 
--			( select aapaccountno,udaccountno,dea from pm_pharmacy where dea is not null and aapaccountno is not null ) ch
--	   on su.dea = ch.dea where su.aapaccountno is null and su.udaccountno is not null   
--
--	select su.udaccountno,su.aapaccountno,ch.udaccountno,ch.aapaccountno 
--	   FROM CH_ALLPVA_SALES_TEST_DYN_UD_BKP  su 
--		inner join 
--			( select aapaccountno,udaccountno,dea from pm_pharmacy where dea is not null and udaccountno is not null ) ch
--	   on su.dea = ch.dea where su.udaccountno is null and su.aapaccountno is not null

-- QA UD Gen total src
--select sum(udgentotalsrc) from CH_ALLPVA_SALES 
--where month(date) = 07
--select sum(gen_vol_amt)FROM reporting..IndexingGenRebate
--WHERE  month(apply_dt) = 07 and year(apply_dt) = 2010     
---- QA UD Gen Total
--select sum(UDGenTotal) from CH_ALLPVA_SALES 
--where month(date) = 07
--select sum(gen_vol_amt)FROM reporting..IndexingGenRebate
--WHERE  month(apply_dt) = 07 and year(apply_dt) = 2010     
---- QA UD brand
--select sum(UDBrand) from CH_ALLPVA_SALES 
--where month(date) = 07
--select sum(rx_vol_amt - gen_vol_amt)FROM reporting..IndexingGenRebate
--WHERE  month(apply_dt) = 07 and year(apply_dt) = 2010   
---- QA UD OTC
--select sum(UDOTC) from CH_ALLPVA_SALES 
--where month(date) = 07
--select 
-- sum( a.UDNetSales - g.rx_vol_amt) as otc from
--	CH_ALLPVA_SALES a     
--	left join   
--	(
--		SELECT 
--		pmid,[date],
--		sum(rx_vol_amt) as rx_vol_amt
--		FROM
--		(
--		SELECT  
--		p.pmid, v.apply_dt as [date], v.gen_vol_amt, v.rx_vol_amt
--		FROM reporting..IndexingGenRebate v left join pharmacymaster..pm_pharmacy p
--			on (v.ud_acct = p.udaccountno or v.ud_acct =p.aapaccountno)
--		WHERE  month(apply_dt) = 07 and year(apply_dt) = 2010                              
--	) dt
--	group by pmid,[date]
--	) g
--	on a.pmid=g.pmid where month(a.date) = 07 and a.udnetsales <>0

--QA UDNETSALES against Volume

--select sum(UDNetSales) from CH_ALLPVA_SALES where month(date) = 08
--and year(date) = 2010
--
--select sum(august) from reporting..volumecalyy where year = 2010
--and vendor_id in (65,86)

END








GO
