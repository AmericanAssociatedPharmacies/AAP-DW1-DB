USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_create_Commission_MO_CS]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <10/14/2010>
-- Description:	Create Monthly Global Report
-- =============================================
CREATE PROCEDURE [dbo].[sppm_create_Commission_MO_CS]
--(@in_month varchar(02), @in_year varchar(4))

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table

	--DECLARE @date datetime;
	--DECLARE @dateOut varchar(10);
--	SET @date = @in_month + '/01/' + @in_year

	--SET @dateOut =  (SELECT SUBSTRING(CONVERT(VARCHAR(11),@date, 109), 10, 2) )
	--SET @dateOut = @dateOut + '-';

	--SET @dateOut =  @dateOut + (SELECT SUBSTRING(CONVERT(VARCHAR(11),@date, 109), 1, 3) )
 

 
		 IF EXISTS(SELECT name FROM sys.tables
			 WHERE name = 'tmp_MO_jmw')
		 BEGIN
          DROP TABLE tmp_MO_jmw
         END
 
 SELECT * INTO tmp_MO_jmw from ( 
--select * from(
	          SELECT   
               cast(null as varchar(10)) as TM , 
               PMID,  
			   cast(null as varchar(20)) as AAP# ,  
			   cast(null as varchar(20)) as Parent# ,  
			   cast(null as varchar(20)) as [API Warehouse#] ,  
               cast(null as datetime) as [AAP Eff] ,
               cast(null as datetime) as [AAP Quit] ,
               cast(null as  varchar(100)) as [Description] , 
			   cast(null as  varchar(200)) as Affiliate ,    
			   cast(null as  varchar(100)) as [Account DBA Name] ,  
			   cast(null as  varchar(100)) as [City] ,  
			   cast(null as  varchar(100)) as ST , 
			   cast(null as datetime ) as [Whse Acct Date Opened] , 
               cast(null as varchar(20)) as [Status] ,
			   cast(null as  varchar(10)) as Wholesaler,  

			   MAX([API Gen]) as [API Sept 10 Generic Sales],
			   MAX([API Br]) as [API Sept 10 Brand Sales],
			   MAX([API OTC]) as [API Sept 10 OTC Sales],
			   MAX([API Total]) as [API Sept 10 Total Sales],
			   MAX([CH Total]) as [CAH Sept 10 Total Sales], 
			   MAX([ML Total]) as [ML Sept 10 Total Sales] 
   
	FROM (
	  SELECT PMID ,

           'CH Total' as dateCHT,
			sum(isnull(CombNetSales,0))as CombNetSales ,
           'API Gen' as dateAPIG,
			sum(isnull(WHAPIGeneric,0))as WHAPIGeneric,
			'API Br' as dateAPIB,
			sum(isnull(WHAPIBrand,0))as WHAPIBrand,
			'API OTC' as dateAPIO,
			sum(isnull(WHAPIOTC,0))as WHAPIOTC ,
			'API Total' as dateAPIT,
			sum(isnull(WHAPIGeneric,0)) + sum(isnull(WHAPIBrand,0)) + sum(isnull(WHAPIOTC,0))as WHAPITot,
			'ML Total' as dateMLT,
			sum(isnull(MLTotal,0))as MLTotal ,  
			'All Total' as dateAllT,
			sum(isnull(WHAPIGeneric,0)) + sum(isnull(WHAPIBrand,0)) + sum(isnull(WHAPIOTC,0)) + 
                sum(isnull(CombNetSales,0)) + sum(isnull(MLTotal,0)) + sum(isnull(AndaTotal,0)) as AllTotal     
 

	  FROM all_volume  where ( month(date) in (09) and year(date) = 2010) 
				         
			 group by PMID  
  ) as TableDate

     PIVOT 
	(
	  SUM(CombNetSales)
	  FOR dateCHT IN  ([CH Total])
	)as P7
     PIVOT 
	(
	  SUM(WHAPIGeneric)
	  FOR dateAPIG IN  ([API Gen])
	)as P8
     PIVOT 
	(
	  SUM(WHAPIBrand)
	  FOR dateAPIB IN  ([API Br])
	)as P9
     PIVOT 
	(
	  SUM(WHAPIOTC)
	  FOR dateAPIO IN  ([API OTC])
	)as P10
     PIVOT 
	(
	  SUM(WHAPITot)
	  FOR dateAPIT IN  ([API Total])
	)as P11
	 PIVOT 
	(
	  SUM(MLTotal)
	  FOR dateMLT IN  ([ML Total])
	)as P12

	group by PMID 

)vol

	UPDATE v set
		TM = p.territory  ,
		[AAP#] = p.aapaccountno,
		[Parent#] = p.aapparentno ,
		[API Warehouse#] = p.apiaccountno ,
		[AAP Eff] = p.aapeffectivedate,
        [AAP Quit] = p.aapquitdate,
		[Description] = p.AccountDescription,
		Affiliate = p.Affiliate,
		[Account DBA Name] = p.[accountname],
		City = p.City, 
		ST = p.State ,
        [Whse Acct Date Opened] = p.DateOpened,
		[Status] = p.apistatus,
        Wholesaler = case when w.vendor is null then 'CH' else w.vendor end    
	 FROM tmp_MO_jmw v
	left join v_PM_AllWithAffiliates p on v.pmid=p.pmid
	left join v_wholesaler_primary w on v.pmid=w.pmid

-- To Get the detail of 9000000 account
--select a.territory as TM,cast('' as varchar(10)) as PMID,
--cast('' as varchar(10)) as AAP#,
--cast('' as varchar(10)) as Parent#,
--a.accountno as [API Warehouse#],
--cast('' as varchar(10)) as [AAP Eff],
--cast('' as varchar(10)) as [AAP Quit],
--cast('' as varchar(10)) as [Description],
--cast('' as varchar(10)) as [Affiliate],
--a.accountname as [Account DBA Name],
--a.City,
--a.state as ST,
--a.dateopened as [Whse Acct Date Opened],
--a.Status,
--cast('' as varchar(10)) as Wholesaler,
-- case when [API Q3 Generic Sales] is null then 0 else [API Q3 Generic Sales] end  as [API Q3 Generic Sales],
--   case when [API Q3 Brand Sales] is null then 0 else   [API Q3 Brand Sales] end  as [API Q3 Brand Sales]  ,
--  case when [API Q3 OTC Sales]  is null then 0 else [API Q3 OTC Sales] end  as [API Q3 OTC Sales],
--
-- case when [API Q3 Generic Sales] is null then 0 else [API Q3 Generic Sales] end + 
--  case when [API Q3 Brand Sales] is null then 0 else   [API Q3 Brand Sales] end +
--case when [API Q3 OTC Sales]  is null then 0 else [API Q3 OTC Sales] end as [API Q3 Total Sales]
--
--from pmbackups..tmp_apiaccountmaster_orig a
--left outer join
--(
--select whaccountid,sum(extsales) as [API Q3 Generic Sales]  from  api..v_apisalesdetail a
-- WHERE      month(invdate) in(07,08,09) and year(invdate) = 2010 and type = 'Generic' 
--and not exists
--(
-- select apiaccountno from all_volume p where a.whaccountid = p.apiaccountno 
--and month(date) in(07,08,09) and year(date )= 2010 ) and a.whaccountid not in (select apiaccountno  from pm_apiaccounts  where date is not null)
--group by whaccountid
--) gen 
--on gen.whaccountid = a.accountno    
-- 
--left outer join
--(
--select whaccountid,sum(extsales) as [API Q3 Brand Sales]  from  api..v_apisalesdetail a
-- WHERE      month(invdate) in(07,08,09) and year(invdate) = 2010 and type = 'Brand' 
--and not exists
--(
-- select apiaccountno from all_volume p where a.whaccountid = p.apiaccountno 
--and month(date) in(07,08,09) and year(date )= 2010 ) and a.whaccountid not in (select apiaccountno  from pm_apiaccounts  where date is not null)
--group by whaccountid
--) br 
--on br.whaccountid = a.accountno  
--left outer join
--(
--select whaccountid,sum(extsales) as [API Q3 OTC Sales]  from  api..v_apisalesdetail a
-- WHERE      month(invdate) in(07,08,09) and year(invdate) = 2010 and type = 'OTC' 
--and not exists
--(
-- select apiaccountno from all_volume p where a.whaccountid = p.apiaccountno 
--and month(date) in(07,08,09) and year(date )= 2010 ) and a.whaccountid not in (select apiaccountno  from pm_apiaccounts  where date is not null)
--group by whaccountid
--) otc 
--on otc.whaccountid = a.accountno where (  [API Q3 Brand Sales] is not null or [API Q3 Generic Sales] is not null or  [API Q3 OTC Sales] is not null)
--
--order by a.territory desc
-- put in the not exists here - see sppm_create_ReportCardVoulem_DYN

END








GO
