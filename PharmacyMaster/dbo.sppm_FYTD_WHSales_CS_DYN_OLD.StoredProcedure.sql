USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_FYTD_WHSales_CS_DYN_OLD]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <06/22/2010>
-- Description:	 Create FYTD WH Sales for Chriss S.
-- =============================================
CREATE PROCEDURE [dbo].[sppm_FYTD_WHSales_CS_DYN_OLD]
(@in_month varchar(2), @in_year varchar(4) )
AS
BEGIN


   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'tmp_FYTD_WHSales_CS_DYN')
          DROP TABLE tmp_FYTD_WHSales_CS_DYN

	DECLARE @SELECT_WH_BR varchar(2000);
	DECLARE @SELECT_WH_GEN varchar(2000);
	DECLARE @SELECT_WH_OTC varchar(2000);
    DECLARE @SQL varchar(4000);
	DECLARE @prev_year  varchar(4);
    DECLARE @HAS_SALES varchar(2000);
	SET @prev_year = @in_year -1;

	IF( @in_month = '01')
		 BEGIN
		   SET @SELECT_WH_BR = ' a.january_br  as [M1 Brand],	a.february_br as [M2 Brand],a.march_br as [M3 Brand],a.april_br as [M4 Brand],a.may_br as [M5 Brand],  a.june_br  as [M6 Brand], ' + 
            ' a.july_br  as [M7 Brand],a.august_br  as [M8 Brand], '+
			' a.september_br  as [M9 Brand],a.october_br  as [M10 Brand],a.november_br  as [M11 Brand] , a.december_br  as [M12 Brand] , '+
	        ' b.january_br  as [M13 Brand],  ';
 
          SET @SELECT_WH_GEN = 'a.january_gen as [M1 Generic],  a.february_gen as [M2 Generic], a.march_gen as [M3 Generic], a.april_gen  as [M4 Generic],a.may_gen as [M5 Generic],   a.june_gen [M6 Generic],'+
            ' a.july_gen [M7 Generic],a.august_gen  as [M8 Generic],'+
	        ' a.september_gen as [M9 Generic],a.october_gen as [M10 Generic],a.november_gen  as [M11 Generic] , a.december_gen [M12 Generic],'+
	        ' b.january_gen as [M13 Generic],  ';

		  SET @SELECT_WH_OTC = 'a.january_otc as [M1 OTC],a.february_otc  as [M2 OTC], a.march_otc  [M3 OTC],a.april_otc as [M4 OTC], a.may_otc as [M5 OTC],   a.june_otc as [M6 OTC], ' + 
            ' a.july_otc as [M7 OTC],a.august_otc as [M8 OTC],'+
			' a.september_otc as [M9 OTC],a.october_otc  as [M10 OTC],a.november_otc as [M11 OTC], a.december_otc  as [M12 OTC],'+
			' b.january_otc as [M13 OTC],   ';

         SET @HAS_SALES = ' a.january_gen <> 0 or a.february_gen <> 0 or a.march_gen <> 0 or  a.april_gen <> 0 or a.may_gen <> 0 or a.june_gen <> 0 or  a.july_gen <> 0 '+
	                       ' or a.august_gen <> 0 or  a.september_gen <> 0 or  a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0'+
	                       ' or a.january_br <> 0 or a.february_br <> 0 or a.march_br <> 0 or  a.april_br <> 0 or a.may_br <> 0 or a.june_br <> 0 or  a.july_br <> 0 '+
	                       ' or a.august_br <> 0 or  a.september_br <> 0 or  a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0'+
	                       ' or a.january_otc <> 0 or a.february_otc <> 0 or a.march_otc <> 0 or  a.april_otc <> 0 or a.may_otc <> 0 or a.june_otc <> 0 or  a.july_otc <> 0 '+
	                       ' or a.august_otc <> 0 or  a.september_otc <> 0 or  a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0';

		 END

	IF( @in_month = '02')
		 BEGIN
		   SET @SELECT_WH_BR = '	a.february_br as [M1 Brand],a.march_br as [M2 Brand],a.april_br as [M3 Brand],a.may_br as [M4 Brand],  a.june_br  as [M5 Brand], ' + 
            ' a.july_br  as [M6 Brand],a.august_br  as [M7 Brand], '+
			' a.september_br  as [M8 Brand],a.october_br  as [M9 Brand],a.november_br  as [M10 Brand] , a.december_br  as [M11 Brand] , '+
	        ' b.january_br  as [M12 Brand],b.february_br as [M13 Brand],  ';
 
          SET @SELECT_WH_GEN = ' a.february_gen as [M1 Generic], a.march_gen as [M2 Generic], a.april_gen  as [M3 Generic],a.may_gen as [M4 Generic],   a.june_gen [M5 Generic],'+
            ' a.july_gen [M6 Generic],a.august_gen  as [M7 Generic],'+
	        ' a.september_gen as [M8 Generic],a.october_gen as [M9 Generic],a.november_gen  as [M10 Generic] , a.december_gen [M11 Generic],'+
	        ' b.january_gen as [M12 Generic],b.february_gen as [M13 Generic], ';

		  SET @SELECT_WH_OTC = 'a.february_otc  as [M1 OTC], a.march_otc  [M2 OTC],	a.april_otc   as [M3 OTC], a.may_otc as [M4 OTC],   a.june_otc as [M5 OTC], ' + 
            ' a.july_otc as [M6 OTC],a.august_otc as [M7 OTC],'+
			' a.september_otc as [M8 OTC],a.october_otc  as [M9 OTC],a.november_otc as [M10 OTC], a.december_otc  as [M11 OTC],'+
			' b.january_otc as [M12 OTC],b.february_otc  as [M13 OTC],   ';

         SET @HAS_SALES = ' a.february_gen <> 0 or a.march_gen <> 0 or  a.april_gen <> 0 or a.may_gen <> 0 or a.june_gen <> 0 or  a.july_gen <> 0 '+
	                       ' or a.august_gen <> 0 or  a.september_gen <> 0 or  a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 ' +
	                       ' or a.february_br <> 0 or a.march_br <> 0 or  a.april_br <> 0 or a.may_br <> 0 or a.june_br <> 0 or  a.july_br <> 0 '+
	                       ' or a.august_br <> 0 or  a.september_br <> 0 or  a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 ' +
	                       ' or a.february_otc <> 0 or a.march_otc <> 0 or  a.april_otc <> 0 or a.may_otc <> 0 or a.june_otc <> 0 or  a.july_otc <> 0 '+
	                       ' or a.august_otc <> 0 or  a.september_otc <> 0 or  a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 ';

		 END

	IF( @in_month = '03')
		 BEGIN
		   SET @SELECT_WH_BR = '	a.march_br as [M1 Brand],a.april_br as [M2 Brand],a.may_br as [M3 Brand],  a.june_br  as [M4 Brand], ' + 
            ' a.july_br  as [M5 Brand],a.august_br  as [M6 Brand], '+
			' a.september_br  as [M7 Brand],a.october_br  as [M8 Brand],a.november_br  as [M9 Brand] , a.december_br  as [M10 Brand] , '+
	        ' b.january_br  as [M11 Brand],b.february_br as [M12 Brand], b.march_br as [M13 Brand], ';
 
          SET @SELECT_WH_GEN = ' 	 a.march_gen as [M1 Generic], a.april_gen  as [M2 Generic],a.may_gen as [M3 Generic],   a.june_gen [M4 Generic],'+
            ' a.july_gen [M5 Generic],a.august_gen  as [M6 Generic],'+
	        ' a.september_gen as [M7 Generic],a.october_gen as [M8 Generic],a.november_gen  as [M9 Generic] , a.december_gen [M10 Generic],'+
	        ' b.january_gen as [M11 Generic],b.february_gen as [M12 Generic], b.march_gen as [M13 Generic], ';

		  SET @SELECT_WH_OTC = ' a.march_otc  [M1 OTC],	a.april_otc   as [M2 OTC], a.may_otc as [M3 OTC],   a.june_otc as [M4 OTC], ' + 
            ' a.july_otc as [M5 OTC],a.august_otc as [M6 OTC],'+
			' a.september_otc as [M7 OTC],a.october_otc  as [M8 OTC],a.november_otc as [M9 OTC], a.december_otc  as [M10 OTC],'+
			' b.january_otc as [M11 OTC],b.february_otc  as [M12 OTC], b.march_otc  [M13 OTC],  ';

         SET @HAS_SALES = '  a.march_gen <> 0 or  a.april_gen <> 0 or a.may_gen <> 0 or a.june_gen <> 0 or  a.july_gen <> 0 '+
	                       ' or a.august_gen <> 0 or  a.september_gen <> 0 or  a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 ' +
	                       ' or a.march_br <> 0 or  a.april_br <> 0 or a.may_br <> 0 or a.june_br <> 0 or  a.july_br <> 0 '+
	                       ' or a.august_br <> 0 or  a.september_br <> 0 or  a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 ' +
	                       ' or a.march_otc <> 0 or  a.april_otc <> 0 or a.may_otc <> 0 or a.june_otc <> 0 or  a.july_otc <> 0 '+
	                       ' or a.august_otc <> 0 or  a.september_otc <> 0 or  a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 ';

		 END

	IF( @in_month = '04')
		 BEGIN
		   SET @SELECT_WH_BR = '	a.april_br as [M1 Brand],a.may_br as [M2 Brand],  a.june_br  as [M3 Brand], a.july_br  as [M4 Brand],a.august_br  as [M5 Brand], '+
			' a.september_br  as [M6 Brand],a.october_br  as [M7 Brand],a.november_br  as [M8 Brand] , a.december_br  as [M9 Brand] , '+
	        ' b.january_br  as [M10 Brand],b.february_br as [M11 Brand], b.march_br as [M12 Brand],b.april_br as [M13 Brand] ,';
 
          SET @SELECT_WH_GEN = ' 	a.april_gen  as [M1 Generic],a.may_gen as [M2 Generic],   a.june_gen [M3 Generic], a.july_gen [M4 Generic],a.august_gen  as [M5 Generic],'+
	        ' a.september_gen as [M6 Generic],a.october_gen as [M7 Generic],a.november_gen  as [M8 Generic] , a.december_gen [M9 Generic],'+
	        ' b.january_gen as [M10 Generic],b.february_gen as [M11 Generic], b.march_gen as [M12 Generic],b.april_gen  as [M13 Generic], ';

		  SET @SELECT_WH_OTC = '	a.april_otc   as [M1 OTC], a.may_otc as [M2 OTC],   a.june_otc as [M3 OTC], a.july_otc as [M4 OTC],a.august_otc as [M5 OTC],'+
			' a.september_otc as [M6 OTC],a.october_otc  as [M7 OTC],a.november_otc as [M8 OTC], a.december_otc  as [M9 OTC],'+
			' b.january_otc as [M10 OTC],b.february_otc  as [M11 OTC], b.march_otc  [M12 OTC],b.april_otc   as [M13 OTC],  ';

         SET @HAS_SALES = '   a.april_gen <> 0 or a.may_gen <> 0 or a.june_gen <> 0 or  a.july_gen <> 0 '+
	                       ' or a.august_gen <> 0 or  a.september_gen <> 0 or  a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 ' +
	                       ' or a.april_br <> 0 or a.may_br <> 0 or a.june_br <> 0 or  a.july_br <> 0 '+
	                       ' or a.august_br <> 0 or  a.september_br <> 0 or  a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 or   b.april_br <> 0 ' +
	                       ' or a.april_otc <> 0 or a.may_otc <> 0 or a.june_otc <> 0 or  a.july_otc <> 0 '+
	                       ' or a.august_otc <> 0 or  a.september_otc <> 0 or  a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 or  b.april_otc <> 0 ';

		 END

	IF( @in_month = '05')
		 BEGIN
		   SET @SELECT_WH_BR = '	a.may_br as [M1 Brand],  a.june_br  as [M2 Brand], a.july_br  as [M3 Brand],a.august_br  as [M4 Brand], '+
			' a.september_br  as [M5 Brand],a.october_br  as [M6 Brand],a.november_br  as [M7 Brand] , a.december_br  as [M8 Brand] , '+
	        ' b.january_br  as [M9 Brand],b.february_br as [M10 Brand], b.march_br as [M11 Brand],b.april_br as [M12 Brand],b.may_br as [M13 Brand],';
 
          SET @SELECT_WH_GEN = ' 	a.may_gen as [M1 Generic],   a.june_gen [M2 Generic], a.july_gen [M3 Generic],a.august_gen  as [M4 Generic],'+
	        ' a.september_gen as [M5 Generic],a.october_gen as [M6 Generic],a.november_gen  as [M7 Generic] , a.december_gen [M8 Generic],'+
	        ' b.january_gen as [M9 Generic],b.february_gen as [M10 Generic], b.march_gen as [M11 Generic],b.april_gen  as [M12 Generic],b.may_gen  as [M13 Generic],';

		  SET @SELECT_WH_OTC = '	a.may_otc as [M1 OTC],   a.june_otc as [M2 OTC], a.july_otc as [M3 OTC],a.august_otc as [M4 OTC],'+
			' a.september_otc as [M5 OTC],a.october_otc  as [M6 OTC],a.november_otc as [M7 OTC], a.december_otc  as [M8 OTC],'+
			' b.january_otc as [M9 OTC],b.february_otc  as [M10 OTC], b.march_otc  [M11 OTC],b.april_otc   as [M12 OTC],b.may_otc  as [M13 OTC], ';

         SET @HAS_SALES = '    a.may_gen <> 0 or a.june_gen <> 0 or  a.july_gen <> 0 '+
	                       ' or a.august_gen <> 0 or  a.september_gen <> 0 or  a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 or b.may_gen <> 0 ' +
	                       ' or a.may_br <> 0 or a.june_br <> 0 or  a.july_br <> 0 '+
	                       ' or a.august_br <> 0 or  a.september_br <> 0 or  a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 or   b.april_br <> 0 or b.may_br <> 0 ' +
	                       ' or a.may_otc <> 0 or a.june_otc <> 0 or  a.july_otc <> 0 '+
	                       ' or a.august_otc <> 0 or  a.september_otc <> 0 or  a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 or  b.april_otc <> 0 or  b.may_otc <> 0 ';

		 END

	IF( @in_month = '06')
		 BEGIN
		   SET @SELECT_WH_BR = '	  a.june_br  as [M1 Brand], a.july_br  as [M2 Brand],a.august_br  as [M3 Brand], '+
			' a.september_br  as [M4 Brand],a.october_br  as [M5 Brand],a.november_br  as [M6 Brand] , a.december_br  as [M7 Brand] , '+
	        ' b.january_br  as [M8 Brand],b.february_br as [M9 Brand], b.march_br as [M10 Brand],b.april_br as [M11 Brand],b.may_br as [M12 Brand],'+
            ' b.june_br as [M13 Brand],';
          SET @SELECT_WH_GEN = ' 	  a.june_gen [M1 Generic], a.july_gen [M2 Generic],a.august_gen  as [M3 Generic],'+
	        ' a.september_gen as [M4 Generic],a.october_gen as [M5 Generic],a.november_gen  as [M6 Generic] , a.december_gen [M7 Generic],'+
	        ' b.january_gen as [M8 Generic],b.february_gen as [M9 Generic], b.march_gen as [M10 Generic],b.april_gen  as [M11 Generic],b.may_gen  as [M12 Generic],'+
            ' b.june_gen  as [M13 Generic],';
		  SET @SELECT_WH_OTC = '	  a.june_otc as [M1 OTC], a.july_otc as [M2 OTC],a.august_otc as [M3 OTC],'+
			' a.september_otc as [M4 OTC],a.october_otc  as [M5 OTC],a.november_otc as [M6 OTC], a.december_otc  as [M7 OTC],'+
			' b.january_otc as [M8 OTC],b.february_otc  as [M9 OTC], b.march_otc  [M10 OTC],b.april_otc   as [M11 OTC],b.may_otc  as [M12 OTC], '+
			' b.june_otc  as [M13 OTC],';
         SET @HAS_SALES = ' a.june_gen <> 0 or a.july_gen <> 0 or a.august_gen <> 0 or  a.september_gen <> 0 or a.october_gen <> 0 or a.november_gen <> 0 or  a.december_gen <> 0 '+
	                       ' or b.january_gen <> 0 or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 or b.may_gen <> 0 or b.june_gen <> 0'+
	                       ' or a.june_br <> 0 or a.july_br <> 0 or a.august_br <> 0 or  a.september_br <> 0 or a.october_br <> 0 or a.november_br <> 0 or  a.december_br <> 0 '+
	                       ' or b.january_br <> 0 or b.february_br <> 0 or b.march_br <> 0 or b.april_br <> 0 or b.may_br <> 0  or b.june_br <> 0   '+
	                       ' or a.june_otc <> 0 or a.july_otc <> 0 or a.august_otc <> 0 or  a.september_otc <> 0 or a.october_otc <> 0 or a.november_otc <> 0 or  a.december_otc <> 0 '+
	                       ' or b.january_otc <> 0 or b.february_otc <> 0 or b.march_otc <> 0 or b.april_otc <> 0 or b.may_otc <> 0  or b.june_otc <> 0';

		 END

IF( @in_month = '07')
		 BEGIN
		   SET @SELECT_WH_BR = '	 a.july_br  as [M1 Brand],a.august_br  as [M2 Brand], '+
			' a.september_br  as [M3 Brand],a.october_br  as [M4 Brand],a.november_br  as [M5 Brand] , a.december_br  as [M6 Brand] , '+
	        ' b.january_br  as [M7 Brand],b.february_br as [M8 Brand], b.march_br as [M9 Brand],b.april_br as [M10 Brand],b.may_br as [M11 Brand],'+
            ' b.june_br as [M12 Brand], b.july_br as [M13 Brand],';
          SET @SELECT_WH_GEN = ' 	  a.july_gen [M1 Generic],a.august_gen  as [M2 Generic],'+
	        ' a.september_gen as [M3 Generic],a.october_gen as [M4 Generic],a.november_gen  as [M5 Generic] , a.december_gen [M6 Generic],'+
	        ' b.january_gen as [M7 Generic],b.february_gen as [M8 Generic], b.march_gen as [M9 Generic],b.april_gen  as [M10 Generic],b.may_gen  as [M11 Generic],'+
            ' b.june_gen  as [M12 Generic], b.july_gen as [M13 Generic],';
		  SET @SELECT_WH_OTC = '	  a.july_otc as [M1 OTC],a.august_otc as [M2 OTC],'+
			' a.september_otc as [M3 OTC],a.october_otc  as [M4 OTC],a.november_otc as [M5 OTC], a.december_otc  as [M6 OTC],'+
			' b.january_otc as [M7 OTC],b.february_otc  as [M8 OTC], b.march_otc  [M9 OTC],b.april_otc   as [M10 OTC],b.may_otc  as [M11 OTC], '+
			' b.june_otc  as [M12 OTC], b.july_otc as [M13 OTC],';

         SET @HAS_SALES = '     a.july_gen <> 0 '+
	                       ' or a.august_gen <> 0 or  a.september_gen <> 0 or  a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 or b.may_gen <> 0 or b.june_gen <> 0 or   b.july_gen <> 0' +
	                       ' or a.july_br <> 0 '+
	                       ' or a.august_br <> 0 or  a.september_br <> 0 or  a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 or   b.april_br <> 0 or b.may_br <> 0 or b.june_br <> 0 or  b.july_br <> 0' +
	                       ' or a.july_otc <> 0 '+
	                       ' or a.august_otc <> 0 or  a.september_otc <> 0 or  a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 or  b.april_otc <> 0 or  b.may_otc <> 0  or b.june_otc <> 0 or  b.july_otc <> 0';


		 END

IF( @in_month = '08')
		 BEGIN
		   SET @SELECT_WH_BR = '	 a.august_br  as [M1 Brand], '+
			' a.september_br  as [M2 Brand],a.october_br  as [M3 Brand],a.november_br  as [M4 Brand] , a.december_br  as [M5 Brand] , '+
	        ' b.january_br  as [M6 Brand],b.february_br as [M7 Brand], b.march_br as [M8 Brand],b.april_br as [M9 Brand],b.may_br as [M10 Brand],'+
            ' b.june_br as [M11 Brand], b.july_br as [M12 Brand], b.august_br  as [M13 Brand],';
          SET @SELECT_WH_GEN = ' 	  a.august_gen  as [M1 Generic],'+
	        ' a.september_gen as [M2 Generic],a.october_gen as [M3 Generic],a.november_gen  as [M4 Generic] , a.december_gen [M5 Generic],'+
	        ' b.january_gen as [M6 Generic],b.february_gen as [M7 Generic], b.march_gen as [M8 Generic],b.april_gen  as [M9 Generic],b.may_gen  as [M10 Generic],'+
            ' b.june_gen  as [M11 Generic], b.july_gen as [M12 Generic], b.august_gen  as [M13 Generic],';
		  SET @SELECT_WH_OTC = '	  a.august_otc as [M1 OTC],'+
			' a.september_otc as [M2 OTC],a.october_otc  as [M3 OTC],a.november_otc as [M4 OTC], a.december_otc  as [M5 OTC],'+
			' b.january_otc as [M6 OTC],b.february_otc  as [M7 OTC], b.march_otc  [M8 OTC],b.april_otc   as [M9 OTC],b.may_otc  as [M10 OTC], '+
			' b.june_otc  as [M11 OTC], b.july_otc as [M12 OTC],b.august_otc  as [M13 OTC],';

         SET @HAS_SALES =  '   a.august_gen <> 0 or  a.september_gen <> 0 or  a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 or b.may_gen <> 0 or b.june_gen <> 0 or   b.july_gen <> 0' +
                           ' or  b.august_gen <> 0 '+
	                       ' or a.august_br <> 0 or  a.september_br <> 0 or  a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 or   b.april_br <> 0 or b.may_br <> 0 or b.june_br <> 0 or  b.july_br <> 0' +
                           ' or b.august_br <> 0 ' +
	                       ' or a.august_otc <> 0 or  a.september_otc <> 0 or  a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 or  b.april_otc <> 0 or  b.may_otc <> 0  or b.june_otc <> 0 or  b.july_otc <> 0'+
                           ' or b.august_otc <> 0';

		 END
IF( @in_month = '09')
		 BEGIN
		   SET @SELECT_WH_BR =  
			' a.september_br  as [M1 Brand],a.october_br  as [M2 Brand],a.november_br  as [M3 Brand] , a.december_br  as [M4 Brand] , '+
	        ' b.january_br  as [M5 Brand],b.february_br as [M6 Brand], b.march_br as [M7 Brand],b.april_br as [M8 Brand],b.may_br as [M9 Brand],'+
            ' b.june_br as [M10 Brand], b.july_br as [M11 Brand], b.august_br  as [M12 Brand], b.september_br  as [M13 Brand],';
          SET @SELECT_WH_GEN =  
	        ' a.september_gen as [M1 Generic],a.october_gen as [M2 Generic],a.november_gen  as [M3 Generic] , a.december_gen [M4 Generic],'+
	        ' b.january_gen as [M5 Generic],b.february_gen as [M6 Generic], b.march_gen as [M7 Generic],b.april_gen  as [M8 Generic],b.may_gen  as [M9 Generic],'+
            ' b.june_gen  as [M10 Generic], b.july_gen as [M11 Generic], b.august_gen  as [M12 Generic],b.september_gen as [M13 Generic],';
		  SET @SELECT_WH_OTC =  
			' a.september_otc as [M1 OTC],a.october_otc  as [M2 OTC],a.november_otc as [M3 OTC], a.december_otc  as [M4 OTC],'+
			' b.january_otc as [M5 OTC],b.february_otc  as [M6 OTC], b.march_otc  [M7 OTC],b.april_otc   as [M8 OTC],b.may_otc  as [M9 OTC], '+
			' b.june_otc  as [M10 OTC], b.july_otc as [M11 OTC],b.august_otc  as [M12 OTC], b.september_otc as [M13 OTC],';

         SET @HAS_SALES =  '  a.september_gen <> 0 or  a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 or b.may_gen <> 0 or b.june_gen <> 0 or   b.july_gen <> 0' +
                           ' or  b.august_gen <> 0 or b.september_gen <> 0'+
	                       ' or  a.september_br <> 0 or  a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 or   b.april_br <> 0 or b.may_br <> 0 or b.june_br <> 0 or  b.july_br <> 0' +
                           ' or b.august_br <> 0 or b.september_br <> 0' +
	                       ' or   a.september_otc <> 0 or  a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 or  b.april_otc <> 0 or  b.may_otc <> 0  or b.june_otc <> 0 or  b.july_otc <> 0'+
                           ' or b.august_otc <> 0 or b.september_otc <> 0';

		 END

IF( @in_month = '10')
		 BEGIN
		   SET @SELECT_WH_BR =  
			'  a.october_br  as [M1 Brand],a.november_br  as [M2 Brand] , a.december_br  as [M3 Brand] , '+
	        ' b.january_br  as [M4 Brand],b.february_br as [M5 Brand], b.march_br as [M6 Brand],b.april_br as [M7 Brand],b.may_br as [M8 Brand],'+
            ' b.june_br as [M9 Brand], b.july_br as [M10 Brand], b.august_br  as [M11 Brand], b.september_br  as [M12 Brand], b.october_br  as [M13 Brand],';
          SET @SELECT_WH_GEN =  
	        '  a.october_gen as [M1 Generic],a.november_gen  as [M2 Generic] , a.december_gen [M3 Generic],'+
	        ' b.january_gen as [M4 Generic],b.february_gen as [M5 Generic], b.march_gen as [M6 Generic],b.april_gen  as [M7 Generic],b.may_gen  as [M8 Generic],'+
            ' b.june_gen  as [M9 Generic], b.july_gen as [M10 Generic], b.august_gen  as [M11 Generic],b.september_gen as [M12 Generic], b.october_gen as [M13 Generic],';
		  SET @SELECT_WH_OTC =  
			'  a.october_otc  as [M1 OTC],a.november_otc as [M2 OTC], a.december_otc  as [M3 OTC],'+
			' b.january_otc as [M4 OTC],b.february_otc  as [M5 OTC], b.march_otc  [M6 OTC],b.april_otc   as [M7 OTC],b.may_otc  as [M8 OTC], '+
			' b.june_otc  as [M9 OTC], b.july_otc as [M10 OTC],b.august_otc  as [M11 OTC], b.september_otc as [M12 OTC], b.october_otc  as [M13 OTC],';

         SET @HAS_SALES =  '    a.october_gen <> 0 or a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 or b.may_gen <> 0 or b.june_gen <> 0 or   b.july_gen <> 0' +
                           ' or  b.august_gen <> 0 or b.september_gen <> 0 or b.october_gen <> 0 '+
	                       ' or   a.october_br <> 0 or a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 or   b.april_br <> 0 or b.may_br <> 0 or b.june_br <> 0 or  b.july_br <> 0' +
                           ' or b.august_br <> 0 or b.september_br <> 0 or b.october_br <> 0' +
	                       ' or   a.october_otc <> 0 or a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 or  b.april_otc <> 0 or  b.may_otc <> 0  or b.june_otc <> 0 or  b.july_otc <> 0'+
                           ' or b.august_otc <> 0 or b.september_otc <> 0 or b.october_otc <> 0 ';

		 END

IF( @in_month = '11')
		 BEGIN
		   SET @SELECT_WH_BR =  
			'   a.november_br  as [M1 Brand] , a.december_br  as [M2 Brand] , '+
	        ' b.january_br  as [M3 Brand],b.february_br as [M4 Brand], b.march_br as [M5 Brand],b.april_br as [M6 Brand],b.may_br as [M7 Brand],'+
            ' b.june_br as [M8 Brand], b.july_br as [M9 Brand], b.august_br  as [M10 Brand], b.september_br  as [M11 Brand], b.october_br  as [M12 Brand],' +
            ' b.november_br  as [M13 Brand]  ,';
          SET @SELECT_WH_GEN =  
	        '   a.november_gen  as [M1 Generic] , a.december_gen [M2 Generic],'+
	        ' b.january_gen as [M3 Generic],b.february_gen as [M4 Generic], b.march_gen as [M5 Generic],b.april_gen  as [M6 Generic],b.may_gen  as [M7 Generic],'+
            ' b.june_gen  as [M8 Generic], b.july_gen as [M9 Generic], b.august_gen  as [M10 Generic],b.september_gen as [M11 Generic], b.october_gen as [M12 Generic],' +
            ' b.november_gen as [M13 Generic] , ';
		  SET @SELECT_WH_OTC =  
			'   a.november_otc as [M1 OTC], a.december_otc  as [M2 OTC],'+
			' b.january_otc as [M3 OTC],b.february_otc  as [M4 OTC], b.march_otc  [M5 OTC],b.april_otc   as [M6 OTC],b.may_otc  as [M7 OTC], '+
			' b.june_otc  as [M8 OTC], b.july_otc as [M9 OTC],b.august_otc  as [M10 OTC], b.september_otc as [M11 OTC], b.october_otc  as [M12 OTC],' +
            ' b.november_otc as [M13 OTC],  ';
         SET @HAS_SALES =  '    a.november_gen<> 0 or a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 or b.may_gen <> 0 or b.june_gen <> 0 or   b.july_gen <> 0' +
                           ' or  b.august_gen <> 0 or b.september_gen <> 0 or b.october_gen <> 0 or b.november_gen <> 0 '+
	                       ' or   a.november_br <> 0 or a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 or   b.april_br <> 0 or b.may_br <> 0 or b.june_br <> 0 or  b.july_br <> 0' +
                           ' or b.august_br <> 0 or b.september_br <> 0 or b.october_br <> 0 or  b.november_br <> 0 ' +
	                       ' or   a.november_otc <> 0 or a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 or  b.april_otc <> 0 or  b.may_otc <> 0  or b.june_otc <> 0 or  b.july_otc <> 0'+
                           ' or b.august_otc <> 0 or b.september_otc <> 0 or b.october_otc <> 0 or b.november_otc <> 0 ';
		 END

IF( @in_month = '12')
		 BEGIN
		   SET @SELECT_WH_BR =  
			'  a.december_br  as [M1 Brand] , '+
	        ' b.january_br  as [M2 Brand],b.february_br as [M3 Brand], b.march_br as [M4 Brand],b.april_br as [M5 Brand],b.may_br as [M6 Brand],'+
            ' b.june_br as [M7 Brand], b.july_br as [M8 Brand], b.august_br  as [M9 Brand], b.september_br  as [M10 Brand], b.october_br  as [M11 Brand],' +
            ' b.november_br  as [M12 Brand],b.december_br  as [M13 Brand]  ,';
          SET @SELECT_WH_GEN =  
	        '  a.december_gen [M1 Generic],'+
	        ' b.january_gen as [M2 Generic],b.february_gen as [M3 Generic], b.march_gen as [M4 Generic],b.april_gen  as [M5 Generic],b.may_gen  as [M6 Generic],'+
            ' b.june_gen  as [M7 Generic], b.july_gen as [M8 Generic], b.august_gen  as [M9 Generic],b.september_gen as [M10 Generic], b.october_gen as [M11 Generic],' +
            ' b.november_gen as [M12 Generic],b.december_gen [M13 Generic] , ';
		  SET @SELECT_WH_OTC =  
			'  a.december_otc  as [M1 OTC],'+
			' b.january_otc as [M2 OTC],b.february_otc  as [M3 OTC], b.march_otc  [M4 OTC],b.april_otc   as [M5 OTC],b.may_otc  as [M6 OTC], '+
			' b.june_otc  as [M7 OTC], b.july_otc as [M8 OTC],b.august_otc  as [M9 OTC], b.september_otc as [M10 OTC], b.october_otc  as [M11 OTC],' +
            ' b.november_otc as [M12 OTC] ,b.december_otc  as [M13 OTC], ';

         SET @HAS_SALES =  '    a.december_gen <> 0 or b.january_gen <> 0 '+
                           ' or b.february_gen <> 0 or b.march_gen <> 0 or b.april_gen <> 0 or b.may_gen <> 0 or b.june_gen <> 0 or   b.july_gen <> 0' +
                           ' or  b.august_gen <> 0 or b.september_gen <> 0 or b.october_gen <> 0 or b.november_gen <> 0 or b.december_gen <> 0 '+
	                       ' or  a.december_br <> 0 or b.january_br <> 0 '+
                           ' or b.february_br <> 0 or  b.march_br <> 0 or   b.april_br <> 0 or b.may_br <> 0 or b.june_br <> 0 or  b.july_br <> 0' +
                           ' or b.august_br <> 0 or b.september_br <> 0 or b.october_br <> 0 or  b.november_br <> 0 or b.december_br <> 0 ' +
	                       ' or   a.december_otc <> 0 or b.january_otc <> 0 ' +
                           ' or b.february_otc <> 0 or  b.march_otc <> 0 or  b.april_otc <> 0 or  b.may_otc <> 0  or b.june_otc <> 0 or  b.july_otc <> 0'+
                           ' or b.august_otc <> 0 or b.september_otc <> 0 or b.october_otc <> 0 or b.november_otc <> 0 or b.december_otc <> 0';
		 END


	SET @SQL = 'SELECT * into pharmacymaster..tmp_FYTD_WHSales_CS_DYN from ( '+
					' SELECT   a.whaccountid as WHAcct#,'+
					'  p.aapaccountno as AAP#,'+
					' case when  p.territory is null then o.territory else p.territory end as SlsMn, '+
					' case when  p.accountname is null then o.accountname else p.accountname end as Name, '+
					' case when  p.city is null then o.city else p.city end as City, '+
					' case when  p.state is null then o.state else p.state end as ST, '+
					' case when p.apistatus is null then o.status else p.apistatus end as Status, '+
					' case when p.dateopened is null then o.dateopened else p.dateopened end as [Date Opened], '+
                    @SELECT_WH_BR + @SELECT_WH_GEN + @SELECT_WH_OTC + 
					' cast(0 as float) as [Brand Totals], '+
					' cast(0 as float) as [Generic Totals],  '+
					' cast(0 as float) as [OTC Totals],  '+
					' cast(0 as float) as [Grand Totals],  '+
                    ' cast(0 as float) as [M1 Totals],  '+
                    ' cast(0 as float) as [M2 Totals],  '+
					' cast(0 as float) as [M3 Totals],  '+
					' cast(0 as float) as [M4 Totals],  '+
					' cast(0 as float) as [M5 Totals],  '+
					' cast(0 as float) as [M6 Totals],  '+
					' cast(0 as float) as [M7 Totals],  '+
					' cast(0 as float) as [M8 Totals],  '+
					' cast(0 as float) as [M9 Totals],  '+
					' cast(0 as float) as [M10 Totals],  '+
					' cast(0 as float) as [M11 Totals],  '+
					' cast(0 as float) as [M12 Totals],  '+
					' cast(0 as float) as [M13 Totals]  '+

					' from api..API_WHSales_Mnthly_ByType a  '+
					' full outer join  '+
					' (  '+
		
					'   select   * from api..API_WHSales_Mnthly_ByType  '+
					'    where year = 2010  '+
					' ) b on a.whaccountid = b.whaccountid  '+

					' left outer join  '+
					' (  '+
					'    select territory,accountname,city,state,apistatus,dateopened,apiaccountno,aapaccountno from pharmacymaster..v_PM_AllWithAffiliates  '+
					' ) p '+
 					' on a.whaccountid = p.apiaccountno  '+
					' left outer join  '+
					' (  '+
					'	select territory,accountname,city,state,status,dateopened,accountno from pmbackups..tmp_apiaccountmaster_orig  '+
					' ) o  '+
					' on a.whaccountid = o.accountno  '+
					' where a.year = 2009  and  ( '+ @HAS_SALES + ')' +
 
					' )CS ';
  print @sql;
   EXEC (@SQL);


   INSERT INTO   tmp_FYTD_WHSales_CS_DYN ( WHAcct# , AAP# ,SlsMn,Name,City,ST,status,[Date Opened]) 
    SELECT p.apiaccountno,p.aapaccountno,p.territory,p.accountname,p.city,p.state,p.apistatus,p.dateopened  FROM v_PM_AllWithAffiliates p
		left outer join(
			SELECT * FROM  tmp_FYTD_WHSales_CS_DYN
		) a
		ON p.apiaccountno = a.whacct#
       -- left outer join (
		--	SELECT dateopened,accountno from pmbackups..tmp_apiAccountmaster_orig 
		--)api
		--on p.apiaccountno = api.accountno
		WHERE a.whacct# is null and p.apistatus = 'active';

 
 
 
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M1 Brand]  = 0 where   [M1 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M2 Brand] = 0 where    [M2 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M3 Brand]  = 0 where 	[M3 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M4 Brand] = 0 where    [M4 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M5 Brand]  = 0 where 	[M5 Brand] is null; 
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M6 Brand]  = 0 where   [M6 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M7 Brand]  = 0 where  	[M7 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M8 Brand]  = 0 where  	[M8 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M9 Brand] = 0 where    [M9 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M10 Brand] = 0 where    [M10 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M11 Brand] = 0 where    [M11 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M12 Brand] = 0 where    [M12 Brand] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M13 Brand] = 0 where    [M13 Brand] is null;
 
 
 
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M1 Generic]  = 0 where    [M1 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M2 Generic] = 0 where     [M2 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M3 Generic]  = 0 where    [M3 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M4 Generic] = 0 where     [M4 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M5 Generic]  = 0 where    [M5 Generic] is null; 
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M6 Generic]  = 0 where    [M6 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M7 Generic]  = 0 where    [M7 Generic] is null;
    UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M8 Generic]  = 0 where    [M8 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M9 Generic] = 0 where     [M9 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M10 Generic] = 0 where    [M10 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M11 Generic] = 0 where    [M11 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M12 Generic] = 0 where    [M12 Generic] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M13 Generic] = 0 where    [M13 Generic] is null;

	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M1 OTC]  = 0 where    [M1 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M2 OTC] = 0 where     [M2 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M3 OTC]  = 0 where    [M3 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M4 OTC] = 0 where     [M4 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M5 OTC]  = 0 where    [M5 OTC] is null; 
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M6 OTC]  = 0 where    [M6 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M7 OTC]  = 0 where    [M7 OTC] is null;
    UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M8 OTC]  = 0 where    [M8 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M9 OTC] = 0 where     [M9 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M10 OTC] = 0 where    [M10 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M11 OTC] = 0 where    [M11 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M12 OTC] = 0 where    [M12 OTC] is null;
	UPDATE 	tmp_FYTD_WHSales_CS_DYN set	[M13 OTC] = 0 where    [M13 OTC] is null;
 
	UPDATE tmp_FYTD_WHSales_CS_DYN set [Brand Totals] =   	[M1 Brand] +[M2 Brand] + 	[M3 Brand] +
			[M4 Brand] + 	[M5 Brand] + [M6 Brand] + [M7 Brand] + 	[M8 Brand] + [M9 Brand] + [M10 Brand] +
			[M11 Brand] + [M12 Brand] + [M13 Brand] ;

	UPDATE tmp_FYTD_WHSales_CS_DYN set [Generic Totals] =  	[M1 Generic] +[M2 Generic] + 	[M3 Generic] +
			[M4 Generic] + 	[M5 Generic] + [M6 Generic] + [M7 Generic] + 	[M8 Generic] + [M9 Generic] + [M10 Generic] +
			[M11 Generic] + [M12 Generic] + [M13 Generic] ;


	UPDATE tmp_FYTD_WHSales_CS_DYN set [OTC Totals] =   	[M1 OTC] +[M2 OTC] + 	[M3 OTC] +
			[M4 OTC] + 	[M5 OTC] + [M6 OTC] + [M7 OTC] + 	[M8 OTC] + [M9 OTC] + [M10 OTC] +
			[M11 OTC] + [M12 OTC] + [M13 OTC] ;

	UPDATE tmp_FYTD_WHSales_CS_DYN set [Grand Totals] = [Brand Totals] + [Generic Totals] + [OTC Totals];

    UPDATE tmp_FYTD_WHSales_CS_DYN set [M1 Totals] = [M1 Brand] + [M1 Generic] + [M1 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M2 Totals] = [M2 Brand] + [M2 Generic] + [M2 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M3 Totals] = [M3 Brand] + [M3 Generic] + [M3 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M4 Totals] = [M4 Brand] + [M4 Generic] + [M4 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M5 Totals] = [M5 Brand] + [M5 Generic] + [M5 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M6 Totals] = [M6 Brand] + [M6 Generic] + [M6 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M7 Totals] = [M7 Brand] + [M7 Generic] + [M7 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M8 Totals] = [M8 Brand] + [M8 Generic] + [M8 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M9 Totals] = [M9 Brand] + [M9 Generic] + [M9 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M10 Totals] = [M10 Brand] + [M10 Generic] + [M10 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M11 Totals] = [M11 Brand] + [M11 Generic] + [M11 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M12 Totals] = [M12 Brand] + [M12 Generic] + [M12 OTC];
    UPDATE tmp_FYTD_WHSales_CS_DYN set [M13 Totals] = [M13 Brand] + [M13 Generic] + [M13 OTC];

 
 
 

 
 
END








GO
