USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_prepare_ALLPVA_LOAD_SLX_B4ML]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <03/29/2010>
-- Description:	Create table to use for load to SLX - ALL PVA , ANDA
-- =============================================
CREATE PROCEDURE [dbo].[sppm_prepare_ALLPVA_LOAD_SLX_B4ML]
 (@in_month varchar(2), @in_year varchar(4))
AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table
	DECLARE @SQL varchar(6000);
	DECLARE @MO_1 varchar(2);
	DECLARE @MO_2 varchar(2);
	DECLARE @MO_3 varchar(2);
	DECLARE @ANDA_MO_1 varchar(15);
	DECLARE @ANDA_MO_2 varchar(15);
	DECLARE @ANDA_MO_3 varchar(15);
	DECLARE @MO_1_Year varchar(4);
	DECLARE @MO_2_Year varchar(4);
	DECLARE @MO_3_Year varchar(4);
	DECLARE @prev_year varchar(4);
    DECLARE @ANDA_MO_NAME_1 varchar(15);
	DECLARE @ANDA_MO_NAME_2 varchar(15);
	DECLARE @ANDA_MO_NAME_3 varchar(15);

	SET @prev_year = @in_year -1;
	SET @MO_1_Year =  @in_year;
	SET @MO_2_Year =  @in_year;
	SET @MO_3_Year =  @in_year;

	-- Here we set the months we need to be getting data from
	IF( @in_month = '01')
		 BEGIN
		   SET @MO_3 = '01';
		   SET @MO_2 = '12';
		   SET @MO_1 = '11';
		   SET @MO_2_Year =  @prev_year;
		   SET @MO_1_Year =  @prev_year;
		   SET @ANDA_MO_3 = 'c.January';
		   SET @ANDA_MO_2 = 'p.December';
		   SET @ANDA_MO_1 = 'p.November';
           SET @ANDA_MO_NAME_3 = 'January';
		   SET @ANDA_MO_NAME_2 = 'December';
		   SET @ANDA_MO_NAME_1 = 'November';
		 END
	IF( @in_month = '02')
		 BEGIN
		   SET @MO_3 = '02';
		   SET @MO_2 = '01';
		   SET @MO_1 = '12';
		   SET @MO_1_Year =  @prev_year;
		   SET @ANDA_MO_3 = 'c.February';
		   SET @ANDA_MO_2 = 'c.January';
		   SET @ANDA_MO_1 = 'p.December';
           SET @ANDA_MO_NAME_3 = 'February';
		   SET @ANDA_MO_NAME_2 = 'January';
		   SET @ANDA_MO_NAME_1 = 'December';
		 END
	IF( @in_month = '03')
		 BEGIN
		   SET @MO_3 = '03';
		   SET @MO_2 = '02';
		   SET @MO_1 = '01';
		   SET @ANDA_MO_3 = 'c.March';
		   SET @ANDA_MO_2 = 'c.February';
		   SET @ANDA_MO_1 = 'c.January';
           SET @ANDA_MO_NAME_3 = 'March';
		   SET @ANDA_MO_NAME_2 = 'February';
		   SET @ANDA_MO_NAME_1 = 'January';
		 END
	IF( @in_month = '04')
		 BEGIN
		   SET @MO_3 = '04';
		   SET @MO_2 = '03';
		   SET @MO_1 = '02';
		   SET @ANDA_MO_3 = 'c.April';
		   SET @ANDA_MO_2 = 'c.March';
		   SET @ANDA_MO_1 = 'c.February';
           SET @ANDA_MO_NAME_3 = 'April';
		   SET @ANDA_MO_NAME_2 = 'March';
		   SET @ANDA_MO_NAME_1 = 'February';
		 END
	IF( @in_month = '05')
		 BEGIN
		   SET @MO_3 = '05';
		   SET @MO_2 = '04';
		   SET @MO_1 = '03';
		   SET @ANDA_MO_3 = 'c.May';
		   SET @ANDA_MO_2 = 'c.April';
		   SET @ANDA_MO_1 = 'c.March';
           SET @ANDA_MO_NAME_3 = 'May';
		   SET @ANDA_MO_NAME_2 = 'April';
		   SET @ANDA_MO_NAME_1 = 'March';
		 END
	IF( @in_month = '06')
		 BEGIN
		   SET @MO_3 = '06';
		   SET @MO_2 = '05';
		   SET @MO_1 = '04';
		   SET @ANDA_MO_3 = 'c.June';
		   SET @ANDA_MO_2 = 'c.May';
		   SET @ANDA_MO_1 = 'c.April';
           SET @ANDA_MO_NAME_3 = 'June';
		   SET @ANDA_MO_NAME_2 = 'May';
		   SET @ANDA_MO_NAME_1 = 'April';
		 END
	IF( @in_month = '07')
		 BEGIN
		   SET @MO_3 = '07';
		   SET @MO_2 = '06';
		   SET @MO_1 = '05';
		   SET @ANDA_MO_3 = 'c.July';
		   SET @ANDA_MO_2 = 'c.June';
		   SET @ANDA_MO_1 = 'c.May';
           SET @ANDA_MO_NAME_3 = 'July';
		   SET @ANDA_MO_NAME_2 = 'June';
		   SET @ANDA_MO_NAME_1 = 'May';
		 END
	IF( @in_month = '08')
		 BEGIN
		   SET @MO_3 = '08';
		   SET @MO_2 = '07';
		   SET @MO_1 = '06';
		   SET @ANDA_MO_3 = 'c.August';
		   SET @ANDA_MO_2 = 'c.July';
		   SET @ANDA_MO_1 = 'c.June';
           SET @ANDA_MO_NAME_3 = 'August';
		   SET @ANDA_MO_NAME_2 = 'July';
		   SET @ANDA_MO_NAME_1 = 'June';
		 END
	IF( @in_month = '09')
		 BEGIN
		   SET @MO_3 = '09';
		   SET @MO_2 = '08';
		   SET @MO_1 = '07';
		   SET @ANDA_MO_3 = 'c.September';
		   SET @ANDA_MO_2 = 'c.August';
		   SET @ANDA_MO_1 = 'c.July';
           SET @ANDA_MO_NAME_3 = 'September';
		   SET @ANDA_MO_NAME_2 = 'August';
		   SET @ANDA_MO_NAME_1 = 'July';
		 END
	IF( @in_month = '10')
		 BEGIN
		   SET @MO_3 = '10';
		   SET @MO_2 = '09';
		   SET @MO_1 = '08';
		   SET @ANDA_MO_3 = 'c.October';
		   SET @ANDA_MO_2 = 'c.September';
		   SET @ANDA_MO_1 = 'c.August';
           SET @ANDA_MO_NAME_3 = 'October';
		   SET @ANDA_MO_NAME_2 = 'September';
		   SET @ANDA_MO_NAME_1 = 'August';
		 END
	IF( @in_month = '11')
		 BEGIN
		   SET @MO_3 = '11';
		   SET @MO_2 = '10';
		   SET @MO_1 = '09';
		   SET @ANDA_MO_3 = 'c.November';
		   SET @ANDA_MO_2 = 'c.October';
		   SET @ANDA_MO_1 = 'c.September';
           SET @ANDA_MO_NAME_3 = 'November';
		   SET @ANDA_MO_NAME_2 = 'October';
		   SET @ANDA_MO_NAME_1 = 'September';
		 END
	IF( @in_month = '12')
		 BEGIN
		   SET @MO_3 = '12';
		   SET @MO_2 = '11';
		   SET @MO_1 = '10';
		   SET @ANDA_MO_3 = 'c.December';
		   SET @ANDA_MO_2 = 'c.November';
		   SET @ANDA_MO_1 = 'c.October';
           SET @ANDA_MO_NAME_3 = 'December';
		   SET @ANDA_MO_NAME_2 = 'November';
		   SET @ANDA_MO_NAME_1 = 'October';
		 END

   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'tmp_ALLPVA_SLX')
          DROP TABLE tmp_ALLPVA_SLX

exec api..spud_API_SALES_LOAD_SLX_AAP @in_month, @in_year; -- Need to execute this to get wh totals !!!!!!!!!!!!!  CHANGE DATE
  
SELECT * INTO tmp_ALLPVA_SLX from (
   SELECT p.pmid,p.accountname,p.dea,p.apiaccountno, m1.totnetsales   as m1 ,  m2.totnetsales  as m2, m3.totnetsales   as m3 ,
	cast(0.0 as numeric(38,2)) as  mo3Avg ,
	cast(0.0 as numeric(38,2)) as  Anda1, 
	cast(0.0 as numeric(38,2)) as  Anda2, 
	cast(0.0 as numeric(38,2)) as  Anda3, 
	cast(0.0 as numeric(38,2)) as  AndaTotal,
    cast(0.0 as numeric(38,2)) as  WHM1, 
	cast(0.0 as numeric(38,2)) as  WHM2, 
	cast(0.0 as numeric(38,2)) as  WHM3, 
    cast(0.0 as numeric(38,2)) as  whPVAAvg3mo 

	FROM pm_pharmacy p
	left outer join
	(
	SELECT apinetsales + aapnetsales + udnetsales as totnetsales,pmid from
	ALL_VOLUME where [date] = @MO_1 + '/01/' +  @MO_1_Year -- CHANGE DATES
	)m1
	 on p.pmid = m1.pmid 
	left outer join
	(
	SELECT apinetsales + aapnetsales + udnetsales as totnetsales,pmid from
	ALL_VOLUME where [date] = @MO_2 + '/01/' +  @MO_2_Year -- CHANGE DATES
	)m2
	 on p.pmid = m2.pmid 
	left outer join
	(
	SELECT apinetsales + aapnetsales + udnetsales as totnetsales,pmid from
	ALL_VOLUME where [date] = @MO_3 + '/01/' +  @MO_3_Year -- CHANGE DATES
	)m3
	 on p.pmid = m3.pmid
	WHERE (m1.pmid is not null
	or m2.pmid is not null
	or m3.pmid is not null)  
) slx


 update tmp_ALLPVA_SLX set m1 = 0.0 where m1 is null;
 update tmp_ALLPVA_SLX set m2 = 0.0 where m2 is null;
 update tmp_ALLPVA_SLX set m3 = 0.0 where m3 is null;




 SET @SQL = ' UPDATE t set  anda1 =  cp.andam1,   anda2 = cp.andam2,    anda3 = cp.andam3     FROM   pharmacymaster..tmp_ALLPVA_SLX t '+
 
			 ' inner join '+
			 '( SELECT sum(' +@ANDA_MO_1 + ') as andam1 ,sum(' + @ANDA_MO_2 + ') as andam2,sum('+ @ANDA_MO_3 +') as andam3 ,case when c.pmid is null then p.pmid else c.pmid end as pmid from '+
			 '	(  SELECT pm.pmid, sum(v.' + @ANDA_MO_NAME_1 +') as '+ @ANDA_MO_NAME_1 +' ,sum(v.'+ @ANDA_MO_NAME_2 +') as '+ @ANDA_MO_NAME_2 +',sum(v.'+ @ANDA_MO_NAME_3 +') as '+ @ANDA_MO_NAME_3 +
			 '		  from reporting..VolumeCalYY v  '+
			 '		LEFT outer join pm_pharmacy pm  on pm.UDAccountNo = v.acct_no or pm.aapAccountNo = v.acct_no '+
			 '		 where v.vendor_id in (199,221) and v.year in( '''+ @in_year + ''' ) and  ( v.'+ @ANDA_MO_NAME_1 +'<> 0 OR v.'+ @ANDA_MO_NAME_2 +'<> 0 OR v.'+@ANDA_MO_NAME_3+' <> 0) '+
			 '		 group by pm.pmid  ) c '+
			 '	 FULL outer join '+
			 '	( '+
			 '	  SELECT pm1.pmid,   sum(v1.' + @ANDA_MO_NAME_1 +') as '+ @ANDA_MO_NAME_1 +' ,sum(v1.'+ @ANDA_MO_NAME_2 +') as '+ @ANDA_MO_NAME_2 +',sum(v1.'+ @ANDA_MO_NAME_3 +') as '+ @ANDA_MO_NAME_3 +
			 '		 from reporting..VolumeCalYY v1  '+
			 '	   LEFT outer join pm_pharmacy pm1  on pm1.UDAccountNo = v1.acct_no or pm1.aapAccountNo = v1.acct_no '+
			'		 where v1.vendor_id in (199,221) and v1.year in( ''' + @prev_year + ''' ) and   ( v1.'+ @ANDA_MO_NAME_1 +'<> 0 OR v1.'+ @ANDA_MO_NAME_2 +'<> 0 OR v1.'+@ANDA_MO_NAME_3+' <> 0) '+
			'	   group by pm1.pmid  ) p   '+
			' on c.pmid = p.pmid group by c.pmid,p.pmid '+			 
			')cp '+
			' on t.pmid = cp.pmid ';
		 
				EXEC (@SQL)


		SET @SQL = 'INSERT  into tmp_ALLPVA_SLX (DEA,PMID,AccountName,ApiAccountNo,Anda1,Anda2,Anda3,m1,m2,m3,mo3Avg,WHM1,WHM2,WHM3,whPVAAvg3mo)  '+
			' select pm.dea,pm.pmid,pm.accountname,pm.apiaccountno,cp.' + @ANDA_MO_NAME_1 +',cp.' + @ANDA_MO_NAME_2 + ',cp.' + @ANDA_MO_NAME_3 +' ,0,0,0,0,0,0,0,0 from ( '+
			' SELECT case when c.pmid is null then p.pmid else c.pmid end as PMID, '+

			@ANDA_MO_1 +' ,' + @ANDA_MO_2 +',' + @ANDA_MO_3 +' FROM '+ 
			'(  SELECT pm.pmid,  sum(v.' +   @ANDA_MO_NAME_1 + ') as '   + @ANDA_MO_NAME_1 + ' ,sum(v.' + @ANDA_MO_NAME_2 + ') as ' + @ANDA_MO_NAME_2 + ',sum(v.' + @ANDA_MO_NAME_3 + ') as ' + @ANDA_MO_NAME_3 + ' from reporting..VolumeCalYY v '+
  				'	LEFT outer join pm_pharmacy pm  on pm.UDAccountNo = v.acct_no or pm.aapAccountNo = v.acct_no 	' +
 				' where v.vendor_id in (199,221) and v.year in( '''+ @in_year + ''' ) and  ( v.'+ @ANDA_MO_NAME_1 +'<> 0 OR v.'+ @ANDA_MO_NAME_2 +'<> 0 OR v.'+@ANDA_MO_NAME_3+' <> 0) '+
				'	 group by pm.pmid  ) c 	'+
				'   FULL outer join 	'+
				'( 	  SELECT  pm1.pmid,  sum(v1.' +   @ANDA_MO_NAME_1 + ') as '   + @ANDA_MO_NAME_1 + ' ,sum(v1.' + @ANDA_MO_NAME_2 + ') as ' + @ANDA_MO_NAME_2 + ',sum(v1.' + @ANDA_MO_NAME_3 + ') as ' + @ANDA_MO_NAME_3 + ' from reporting..VolumeCalYY v1 '+
 				 '  LEFT outer join pm_pharmacy pm1  on pm1.UDAccountNo = v1.acct_no or pm1.aapAccountNo = v1.acct_no '+
				'	 where v1.vendor_id in (199,221) and v1.year in( ''' + @prev_year + ''' ) and  ( v1.'+ @ANDA_MO_NAME_1 +'<> 0 OR v1.'+ @ANDA_MO_NAME_2 +'<> 0 OR v1.'+@ANDA_MO_NAME_3+' <> 0) '+
				'   group by pm1.pmid  ) p    on c.pmid = p.pmid '+
				'  group by c.pmid,p.pmid,'+ @ANDA_MO_1+ ',' + @ANDA_MO_2 + ',' + @ANDA_MO_3 +'  )cp  '+
			    ' LEFT outer join pm_pharmacy pm   on pm.pmid = cp.pmid ' +
			 
			    '  WHERE not exists  (select pmid from pharmacymaster..tmp_ALLPVA_SLX where pmid = pm.pmid ) and cp.' + @ANDA_MO_NAME_1 + ' is not null';

 
     EXEC (@SQL)

-- UPDATE ANDA TOTALS TO ZERO WHEN NULL

       IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'tmp_Anda_3MO')
          DROP TABLE tmp_Anda_3MO

	SET @SQL = 'SELECT * into tmp_Anda_3MO from ( '+
			 ' SELECT pmid,anda1 as  ' + @ANDA_MO_NAME_1 +' ,  anda2 as '+ @ANDA_MO_NAME_2 +', anda3 as '+ @ANDA_MO_NAME_3 +' from tmp_ALLPVA_SLX where (anda1 <>0 or anda2 <>0 or anda3 <> 0)   '+
	         ' )tmp ';
    EXEC (@SQL)


	UPDATE tmp_ALLPVA_SLX set ANDA1 = 0.00 where ANDA1 is null;
	UPDATE tmp_ALLPVA_SLX set ANDA2 = 0.00 where ANDA2 is null;
	UPDATE tmp_ALLPVA_SLX set ANDA3 = 0.00 where ANDA3 is null;
	UPDATE tmp_ALLPVA_SLX set ANDATotal = 0.00 where ANDATotal is null;
	UPDATE tmp_ALLPVA_SLX set m1 = 0.00 where m1 is null;
	UPDATE tmp_ALLPVA_SLX set m2 = 0.00 where m2 is null;
	UPDATE tmp_ALLPVA_SLX set m3 = 0.00 where m3 is null;


-- For First Month ML Volume - add it into the Cardinal Volume
   SET @SQL = '	UPDATE su set '+
		' su.m1 =  vol.sales + su.m1'+
 	    ' FROM   pharmacymaster..tmp_ALLPVA_SLX su '+
		'	inner join '+
		'	 (       '+
		'		SELECT sum(' + @ANDA_MO_NAME_1 + ') as sales, pm.pmid   '+
		'		from reporting..volumecalyy n '+
		'		left outer join '+
		'			(SELECT pmid,udaccountno,aapAccountNo  FROM PM_Pharmacy) pm on pm.UDAccountNo = n.acct_no or pm.aapAccountNo = n.acct_no '+
		'			where vendor_id = 79 and year = ' + @MO_1_Year + ' AND ( ' + @ANDA_MO_NAME_1 + ' <> 0 )   '+
		'		group by udaccountno,aapaccountno,pm.pmid '+
 		'	 ) vol '+
		'  on su.pmid = vol.pmid    ';
 print @sql
	 EXEC (@SQL);


  	  SET @SQL = 'INSERT  into tmp_ALLPVA_SLX (DEA,PMID,AccountName,ApiAccountNo,Anda1,Anda2,Anda3,m1,m2,m3,mo3Avg,WHM1,WHM2,WHM3,whPVAAvg3mo)  '+
			 ' SELECT vol.dea,vol.pmid,vol.AccountName,vol.apiaccountno,0,0,0,sales,0,0,0,0,0,0,0 FROM '+
             ' ( '+
 			 '	 SELECT dea, pm.pmid,AccountName,apiaccountno,sum(' + @ANDA_MO_NAME_1 + ') as sales  '+
			 '		from reporting..volumecalyy n  '+
			 '		left outer join  '+
			 '			(SELECT pmid,udaccountno,aapAccountNo,dea,AccountName,apiaccountno  FROM PM_Pharmacy) pm on pm.UDAccountNo = n.acct_no or pm.aapAccountNo = n.acct_no  '+
			 '		where vendor_id = 79 and year = ' + @MO_1_Year + ' AND (  ' + @ANDA_MO_NAME_1 + '  <> 0 )   ' +
			 '	group by udaccountno,aapaccountno,pm.pmid,DEA,AccountName ,apiaccountno '+
 			 ' ) vol	  '+
	         '   WHERE    not exists  (select pmid from pharmacymaster..tmp_ALLPVA_SLX  where   pmid = vol.pmid) and sales is not null';
 print @sql
	 EXEC (@SQL);


-- For Second Month ML Volume - add it into the Cardinal Volume
   SET @SQL = '	UPDATE su set '+
		' su.m2 =  vol.sales + su.m2'+
 	    ' FROM   pharmacymaster..tmp_ALLPVA_SLX su '+
		'	inner join '+
		'	 (       '+
		'		SELECT sum(' + @ANDA_MO_NAME_2 + ') as sales, pm.pmid   '+
		'		from reporting..volumecalyy n '+
		'		left outer join '+
		'			(SELECT  pmid,udaccountno,aapAccountNo  FROM PM_Pharmacy) pm on pm.UDAccountNo = n.acct_no or pm.aapAccountNo = n.acct_no '+
		'			where vendor_id = 79 and year = ' + @MO_2_Year + ' AND ( ' + @ANDA_MO_NAME_2 + ' <> 0 )   '+
		'		group by udaccountno,aapaccountno,pm.pmid '+
 		'	 ) vol '+
		'  on su.pmid = vol.pmid    ';
	 EXEC (@SQL);




    SET @SQL = 'INSERT  into tmp_ALLPVA_SLX (DEA,PMID,AccountName,ApiAccountNo,Anda1,Anda2,Anda3,m1,m2,m3,mo3Avg,WHM1,WHM2,WHM3,whPVAAvg3mo)  '+
			 ' SELECT vol.dea,vol.pmid,vol.AccountName,vol.apiaccountno,0,0,0,0,sales,0,0,0,0,0,0 FROM '+
             ' ( '+
 			 '	 SELECT dea, pm.pmid,AccountName,apiaccountno,sum(' + @ANDA_MO_NAME_2 + ') as sales  '+
			 '		from reporting..volumecalyy n  '+
			 '		left outer join  '+
			 '			(SELECT  pmid,udaccountno,aapAccountNo,dea,AccountName,apiaccountno  FROM PM_Pharmacy) pm on pm.UDAccountNo = n.acct_no or pm.aapAccountNo = n.acct_no  '+
			 '		where vendor_id = 79 and year = ' + @MO_2_Year + ' AND (  ' + @ANDA_MO_NAME_2 + '  <> 0 ) '   +
			 '	group by udaccountno,aapaccountno,pm.pmid,DEA,AccountName ,apiaccountno '+
 			 ' ) vol	  '+
	         '  WHERE   not exists  (select pmid from pharmacymaster..tmp_ALLPVA_SLX  where   pmid = vol.pmid)   and sales is not null';
	 EXEC (@SQL);

-- For Third Month ML Volume - add it into the Cardinal Volume
   SET @SQL = '	UPDATE su set '+
		' su.m3 =  vol.sales + su.m3'+
 	    ' FROM   pharmacymaster..tmp_ALLPVA_SLX su '+
		'	inner join '+
		'	 (       '+
		'		SELECT sum(' + @ANDA_MO_NAME_3 + ') as sales, pm.pmid   '+
		'		from reporting..volumecalyy n '+
		'		left outer join '+
		'			(SELECT  pmid,udaccountno,aapAccountNo  FROM PM_Pharmacy) pm on pm.UDAccountNo = n.acct_no or pm.aapAccountNo = n.acct_no '+
		'			where vendor_id = 79 and year = ' + @MO_3_Year + ' AND ( ' + @ANDA_MO_NAME_3 + ' <> 0 )   '+
		'		group by udaccountno,aapaccountno,pm.pmid '+
 		'	 ) vol '+
		'  on su.pmid = vol.pmid    ';
	 EXEC (@SQL);

         SET @SQL = 'INSERT  into tmp_ALLPVA_SLX (DEA,PMID,AccountName,ApiAccountNo,Anda1,Anda2,Anda3,m1,m2,m3,mo3Avg,WHM1,WHM2,WHM3,whPVAAvg3mo)  '+
			 ' SELECT vol.dea,vol.pmid,vol.AccountName,vol.apiaccountno,0,0,0,0,0,sales,0,0,0,0,0 FROM '+
             ' ( '+
 			 '	 SELECT dea, pm.pmid,AccountName,apiaccountno,sum(' + @ANDA_MO_NAME_3 + ') as sales  '+
			 '		from reporting..volumecalyy n  '+
			 '		left outer join  '+
			 '			(SELECT pmid,udaccountno,aapAccountNo,dea,AccountName,apiaccountno  FROM PM_Pharmacy) pm on pm.UDAccountNo = n.acct_no or pm.aapAccountNo = n.acct_no  '+
			 '		where vendor_id = 79 and year = ' + @MO_3_Year + ' AND (  ' + @ANDA_MO_NAME_3 + '  <> 0 ) ' +
			 '	group by udaccountno,aapaccountno,pm.pmid,DEA,AccountName ,apiaccountno '+
 			 ' ) vol	  '+
	         '   WHERE   not exists  (select pmid from pharmacymaster..tmp_ALLPVA_SLX  where   pmid = vol.pmid)  and sales is not null';
	 EXEC (@SQL);

	UPDATE tmp_ALLPVA_SLX set m1 = 0.00 where m1 is null;
	UPDATE tmp_ALLPVA_SLX set m2 = 0.00 where m2 is null;
	UPDATE tmp_ALLPVA_SLX set m3 = 0.00 where m3 is null;

	UPDATE tmp_ALLPVA_SLX set ANDA1 = 0.00 where ANDA1 is null;
	UPDATE tmp_ALLPVA_SLX set ANDA2 = 0.00 where ANDA2 is null;
	UPDATE tmp_ALLPVA_SLX set ANDA3 = 0.00 where ANDA3 is null;



-- UPDATE WITH WH DATA **********Need to run the stored proc to create api..tmp_API_SALES_LOAD_SLX_AAP with data required for these months
		UPDATE t set 
        WHM1 =  v.tot_mo_1, -- CHANGE DATES
		WHM2 = v.tot_mo_2,  -- CHANGE DATES
        WHM3 = v.tot_mo_3       -- CHANGE DATES
	    FROM   pharmacymaster..tmp_ALLPVA_SLX t 
			inner join 
			 (  
              	SELECT  sum(tot_mo_1)as tot_mo_1,sum(tot_mo_2) as tot_mo_2,sum(tot_mo_3) as tot_mo_3,wh.pmid  from api..tmp_API_SALES_LOAD_SLX_AAP wh 
				    left outer join
					(
						SELECT *   from pharmacymaster..tmp_ALLPVA_SLX 
					) pva on wh.pmid = pva.pmid where wh.pmid 
					is not null
                    GROUP by wh.pmid
			) v 
		   on t.pmid =v.pmid

--INSERT WH DATA WHERE THERE IS WH VOLUME BUT THERE WAS NO PVA VOLUME
 INSERT  into tmp_ALLPVA_SLX (DEA,PMID,AccountName,ApiAccountNo,WHM1,WHM2,WHM3,m1,m2,m3,mo3Avg, Anda1,  Anda2, Anda3,AndaTotal,whPVAAvg3mo  )       
      SELECT * ,0,0,0,0,0,0,0,0,0 FROM (  
			SELECT  pm.dea,pm.pmid,pm.accountname,pm.apiaccountno,  sum(tot_mo_1)as WHM1,sum(tot_mo_2)as WHM2,sum(tot_mo_3) as WHM3-- CHANGE DATES
				FROM api..tmp_API_SALES_LOAD_SLX_AAP wh 
				left outer join (
					SELECT pmid,DEA,accountname ,apiaccountno FROM  pm_pharmacy
				) pm on pm.pmid = wh.pmid
				WHERE  wh.pmid 
					is not null --!!!! CHANGE  DATES
			group by  pm.dea,pm.pmid,pm.accountname,pm.apiaccountno   
		 )vol
	 WHERE not exists  (select pmid from pharmacymaster..tmp_ALLPVA_SLX where pmid = vol.pmid ); 

	UPDATE tmp_ALLPVA_SLX set m1 = 0.00 where m1 is null;
	UPDATE tmp_ALLPVA_SLX set m2 = 0.00 where m2 is null;
	UPDATE tmp_ALLPVA_SLX set m3 = 0.00 where m3 is null;

	UPDATE tmp_ALLPVA_SLX set ANDA1 = 0.00 where ANDA1 is null;
	UPDATE tmp_ALLPVA_SLX set ANDA2 = 0.00 where ANDA2 is null;
	UPDATE tmp_ALLPVA_SLX set ANDA3 = 0.00 where ANDA3 is null;
 


 
 
-- Backup table before Deletes and changes for Chriss


       IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'tmp_ALLPVA_SLX_BD')
          DROP TABLE tmp_ALLPVA_SLX_BD

		SELECT * into tmp_ALLPVA_SLX_BD from tmp_ALLPVA_SLX


--- Put New Code here 
	BEGIN
		DECLARE @id int;
		DECLARE @oldDEA   varchar(50);
		DECLARE @newDEA   varchar(50);

		SELECT @id = min( id ) from pharmacymaster..SLX_PVA_DEA_Merge;

		WHILE @id is not null
			BEGIN
				SET @oldDEA = (SELECT DEA_OLD from pharmacymaster..SLX_PVA_DEA_Merge where id = @id);
				SET @newDEA = (SELECT DEA_NEW from pharmacymaster..SLX_PVA_DEA_Merge where id = @id);

			SET @SQL = 'Update tmp_ALLPVA_SLX set m1 = m1 +  case when (select m1 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0  
				else  (select m1 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)

			SET @SQL = 'Update tmp_ALLPVA_SLX set m2 = m2 +  case when (select m2 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0 
				else  (select m2 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)

			SET @SQL = 'Update tmp_ALLPVA_SLX set m3 = m3 + case when (select m3 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0 
				else  (select m3 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)


			SET @SQL = 'Update tmp_ALLPVA_SLX set anda1 = anda1 +   case when (select anda1 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0 
				else  (select anda1 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)
			SET @SQL = 'Update tmp_ALLPVA_SLX set anda2 = anda2 +  case when (select anda2 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0 
				else  (select anda2 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)
			SET @SQL = 'Update tmp_ALLPVA_SLX set anda3 = anda3 +  case when (select anda3 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0 
				else  (select anda3 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)

			SET @SQL = 'Update tmp_ALLPVA_SLX set whm1 = whm1 +  case when (select whm1 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0 
				else  (select whm1 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)
			SET @SQL = 'Update tmp_ALLPVA_SLX set whm2 = whm2 +  case when (select whm2 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0 
				else  (select whm2 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)
			SET @SQL = 'Update tmp_ALLPVA_SLX set whm3 = whm3 + case when (select whm3 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') is null then 0 
				else  (select whm3 from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +''') end 
				where dea = '''+ @newDEA +'''';
			EXEC(@SQL)
			 

			--NOW DELETE old dea from tmp_ALLPVA_SLX if new one exists
            SET @SQL = ' IF EXISTS (select * from tmp_ALLPVA_SLX where dea = ''' + @newDEA +''') '+
						' BEGIN '+
		 	            '	Delete from tmp_ALLPVA_SLX where dea = ''' + @oldDEA +'''' +
                        ' END ' +
						' ELSE '+
						' BEGIN '+
                        '  UPDATE tmp_ALLPVA_SLX set dea = ''' + @newDEA +''' where dea = ''' + @oldDEA +'''' +
                        ' END ' ;
		 	EXEC(@SQL)

            print (@SQL)

			SELECT @id = min( id ) from pharmacymaster..SLX_PVA_DEA_Merge where id > @id;
		END

	END

--- End New Code

--Chriss wanted these removed so they don't show in exception report ---
BEGIN
SET @SQL = 'Delete from tmp_ALLPVA_SLX where dea in( ''BD6305317'',''BD6305393'',''BD6528876'',''BN7470571'',''BW7075333'',''BW9275137'',''FC0226351'',''FD1275800'',''FH0732241'')';
EXEC(@SQL)
END
-- Populate Month Average and Anda Total
	UPDATE tmp_ALLPVA_SLX set mo3Avg = dbo.AvgNoLeading0s3argsSLX(m1,m2,m3);
	UPDATE tmp_ALLPVA_SLX set ANDATotal = dbo.SumMonths(anda1,anda2,anda3);
    UPDATE tmp_ALLPVA_SLX set whPVAAvg3mo = dbo.AvgNoLeading0s3argsSLX(m1 + WHM1,m2+ WHM2,m3+ WHM3);
END








GO
