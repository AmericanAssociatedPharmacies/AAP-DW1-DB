USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_Populate_ALL_Volume_ML]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <10/08/2010>
-- Description:	 Populate ALL_VOlume table with ML Sales 
-- =============================================
CREATE PROCEDURE [dbo].[sppm_Populate_ALL_Volume_ML]
(@in_month varchar(2), @in_year varchar(4) )
AS
BEGIN

--
--   IF EXISTS(SELECT name FROM sys.tables
--        WHERE name = 'tmp_ytd_WH_Sales_CS')
--          DROP TABLE tmp_ytd_WH_Sales_CS
 
DECLARE @SQL varchar(1000);
DECLARE @date varchar(10);
SET @date = @in_month + '/01/' + @in_year;
 

 
-- For First Month ML Volume - add it into the Cardinal Volume
   SET @SQL = '	UPDATE su set '+
		' su.MLTotal =  vol.sales '+
 	    ' FROM   pharmacymaster..ALL_Volume su '+
		'	inner join '+
		'	 (       '+
		'		SELECT sum(TotalSales) as sales, pmid   '+
		'		from pharmacymaster..MiamiLuken  '+
		'			where date = ''' + @date +   ''''+
		'		group by  pmid '+
 		'	 ) vol '+
		'  on su.pmid = vol.pmid and su.date = ''' + @date + '''';
 print @sql
	 EXEC (@SQL);


  	  SET @SQL = 'INSERT  into ALL_Volume (Date,DEA,PMID,AccountName,aapAccountNo,ApiAccountNo,UDAccountNo,MLTotal)  '+
			 ' SELECT ''' + @date + ''' as  insDate ,vol.dea,vol.pmid,vol.AccountName,vol.aapAccountNo,vol.apiaccountno,vol.udaccountno,sales FROM '+
             ' ( '+
 			 '	 SELECT ''' + @date + ''' as date,dea,pm.pmid,pm.AccountName,apiaccountno,aapAccountNo,pm.udaccountno,sum(TotalSales) as sales  '+
			 '		from pharmacymaster..MiamiLuken n  '+
			 '		left outer join  '+
			 '			(SELECT pmid,udaccountno,aapAccountNo,dea,AccountName,apiaccountno  FROM PM_Pharmacy) pm on pm.pmid = n.pmid    '+
			 '		where  date = ''' + @date  +  ''''+
			 '	group by pm.udaccountno,aapaccountno,pm.pmid,DEA,pm.AccountName ,apiaccountno '+
 			 ' ) vol	  '+
	         '  WHERE not exists  (select pmid from pharmacymaster..ALL_Volume  where   pmid = vol.pmid and date = ''' + @date + ''')'; 
 print @sql
	 EXEC (@SQL);
    
	UPDATE pharmacymaster..ALL_Volume set WHAPIBrand = 0.00 where WHAPIBrand is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPIGeneric = 0.00 where WHAPIGeneric is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPIOTC = 0.00 where WHAPIOTC is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPITotal = 0.00 where WHAPITotal is null;
    UPDATE pharmacymaster..ALL_Volume set MLTotal = 0.00 where MLTotal is null;
    UPDATE pharmacymaster..ALL_Volume set AndaTotal = 0.00 where AndaTotal is null;
 


--SET Other Fields TO ZERO WHERE NULL
	UPDATE ALL_Volume SET APICOGAppliedSales = 0.00 where APICOGAppliedSales is null;
	UPDATE ALL_Volume SET APINetSales  = 0.00 where APINetSales is null;
	UPDATE ALL_Volume SET APIGENRx = 0.00 where APIGENRx is null;
	UPDATE ALL_Volume SET APIGENTotalSrc = 0.00 where APIGENTotalSrc is null;
	UPDATE ALL_Volume SET APIGENTotalP2P3 = 0.00 where APIGENTotalP2P3 is null;
	UPDATE ALL_Volume SET APIGENTotal = 0.00 where APIGENTotal is null;
	UPDATE ALL_Volume SET APIBrand = 0.00 where APIBrand is null;
	UPDATE ALL_Volume SET APIOTC = 0.00 where APIOTC is null;
	UPDATE ALL_Volume SET APIGBRPerc = 0.00 where APIGBRPerc is null;
	UPDATE ALL_Volume SET AAPCOGAppliedSales = 0.00 where AAPCOGAppliedSales is null;
	UPDATE ALL_Volume SET AAPNetSales = 0.00 where AAPNetSales is null;
	UPDATE ALL_Volume SET AAPBrand = 0.00 where AAPBrand is null;
	UPDATE ALL_Volume SET AAPGENTotal = 0.00 where AAPGENTotal is null;
	UPDATE ALL_Volume SET AAPGENTotalSrc = 0.00 where AAPGENTotalSrc is null;
	UPDATE ALL_Volume SET AAPGENExcl = 0.00 where AAPGENExcl is null;
	UPDATE ALL_Volume SET AAPOTC = 0.00 where AAPOTC is null;
	UPDATE ALL_Volume SET AAPOther = 0.00 where AAPOther is null;
	UPDATE ALL_Volume SET AAPTotalRX = 0.00 where AAPTotalRX is null;
	UPDATE ALL_Volume SET AAPExcludedFromTotalRX = 0.00 where AAPExcludedFromTotalRX is null;
	UPDATE ALL_Volume SET AAPNonRXOTCandHH = 0.00 where AAPNonRXOTCandHH is null;
	UPDATE ALL_Volume SET AAPSourceCompliance = 0.00 where AAPSourceCompliance is null;

	UPDATE ALL_Volume SET UDNetSales = 0.00 where UDNetSales is null;
	UPDATE ALL_Volume SET UDBrand = 0.00 where UDBrand is null;
	UPDATE ALL_Volume SET UDGENTotal = 0.00 where UDGENTotal is null;
	UPDATE ALL_Volume SET UDGENTotalSrc = 0.00 where UDGENTotalSrc is null;
	UPDATE ALL_Volume SET UDOTC = 0.00 where UDOTC is null;
	UPDATE ALL_Volume SET UDOther = 0.00 where UDOther is null;
	UPDATE ALL_Volume SET CombNetSales = 0.00 where CombNetSales is null;
	UPDATE ALL_Volume SET CombBrands = 0.00 where CombBrands is null;
	UPDATE ALL_Volume SET CombOTC = 0.00 where CombOTC is null;
	UPDATE ALL_Volume SET CombGENTotal = 0.00 where CombGENTotal is null;
	UPDATE ALL_Volume SET CombGENTotalSrc = 0.00 where CombGENTotalSrc is null;
    UPDATE ALL_Volume SET CombOther = 0.00 where CombOther is null;

	UPDATE ALL_Volume SET APIOther = 0.0 where APIOther is null;
	UPDATE ALL_Volume SET UDAdminOnly = 0.0 where UDAdminOnly is null
	UPDATE ALL_Volume SET CombAdminOnly = 0.0 where CombAdminOnly is null;

	UPDATE pharmacymaster..ALL_Volume set WHAPIBrand = 0.00 where WHAPIBrand is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPIGeneric = 0.00 where WHAPIGeneric is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPIOTC = 0.00 where WHAPIOTC is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPITotal = 0.00 where WHAPITotal is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPIBrandUnits = 0.00 where WHAPIBrandUnits is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPIGenericUnits = 0.00 where WHAPIGenericUnits is null;
	UPDATE pharmacymaster..ALL_Volume set WHAPIOTCUnits = 0.00 where WHAPIOTCUnits is null;

 
END








GO
