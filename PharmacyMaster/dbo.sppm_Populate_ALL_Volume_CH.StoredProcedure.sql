USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_Populate_ALL_Volume_CH]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <10/08/2010>
-- Description:	 Populate ALL_VOlume table with CH AAP and API data (from CH_ALLPVA_SALES)
-- =============================================
CREATE PROCEDURE [dbo].[sppm_Populate_ALL_Volume_CH]
(@in_month varchar(2), @in_year varchar(4) )
AS
BEGIN

--
--   IF EXISTS(SELECT name FROM sys.tables
--        WHERE name = 'tmp_ytd_WH_Sales_CS')
--          DROP TABLE tmp_ytd_WH_Sales_CS
 
DECLARE @date varchar(10);
SET @date = @in_month + '/01/' + @in_year;
 
 

-- UPDATE WITH CH 
UPDATE v set 
         CHAccountNo = c.CHAccountNo,
         DCNum = c.DCNum,
         DCCity = c.DCCity,
         AccountName = c.AccountName,
         Address  = c.Address,
         City  = c.City,
         State = c.State,
         ZIP = c.ZIP,
         APIAccountNo = c.APIAccountNo,
         AAPAccountNo = c.AAPAccountNo,
         UDAccountNo  = c.UDAccountNo,
         DEA = c.DEA,
        APICOGAppliedSales  = c.APICOGAppliedSales,
        APINetSales  = c.APINetSales,
        APIGENRx  = c.APIGENRx,
        APIGENTotalSrc = c.APIGENTotalSrc,
        APIGENTotalP2P3 = c.APIGENTotalP2P3,
        APIGENTotal = c.APIGENTotal,
        APIBrand = c.APIBrand,
        APIOTC = c.APIOTC,
        APIOther  = c.APIOther,
        APIGBRPerc  = c.APIGBRPerc,
        AAPCOGAppliedSales  = c.AAPCOGAppliedSales,
        AAPNetSales = c.AAPNetSales,
        AAPBrand = c.AAPBrand,
        AAPGENTotal = c.AAPGENTotal,
        AAPGENTotalSrc = c.AAPGENTotalSrc,
        AAPGENExcl = c.AAPGENExcl,
        AAPOTC  = c.AAPOTC,
        AAPOther  = c.AAPOther,
        AAPTotalRX = c.AAPTotalRX,
	    AAPExcludedFromTotalRX = c.AAPExcludedFromTotalRX,
	    AAPNonRXOTCandHH = c.AAPNonRXOTCandHH,
	    AAPSourceCompliance = c.AAPSourceCompliance,
        UDNetSales  = c.UDNetSales,
        UDBrand = c.UDBrand,
        UDGENTotalSrc = c.UDGENTotalSrc,
        UDGENTotal  = c.UDGENTotal,
        UDOTC  = c.UDOTC,
        UDOther  = c.UDOther,
        UDAdminOnly   = c.UDAdminOnly,
        CombNetSales  = c.CombNetSales,
        CombBrands  = c.CombBrands,
        CombOTC   = c.CombOTC,
        CombGENTotal  = c.CombGENTotal,
        CombGENTotalSrc = c.CombGENTotalSrc,
        CombOther = c.CombOther,
        CombAdminOnly = c.CombAdminOnly
	    FROM   pharmacymaster..ALL_Volume v 
			inner join 
			 (  
              	SELECT Date,PMID,CHAccountNo,DCNum,DCCity,AccountName,Address,City,State,ZIP,APIAccountNo,AAPAccountNo,UDAccountNo,DEA,APICOGAppliedSales,
						APINetSales,APIGENRx,APIGENTotalSrc,APIGENTotalP2P3,APIGENTotal,APIBrand,APIOTC,APIOther,APIGBRPerc,AAPCOGAppliedSales,AAPNetSales,
						AAPBrand,AAPGENTotal,AAPGENTotalSrc,AAPGENExcl,AAPOTC,AAPOther,
                        AAPTotalRX,	AAPExcludedFromTotalRX,	AAPNonRXOTCandHH, AAPSourceCompliance,
                        UDNetSales,UDBrand,UDGENTotalSrc,UDGENTotal,UDOTC,UDOther,UDAdminOnly,CombNetSales,
						CombBrands,CombOTC,CombGENTotal,CombGENTotalSrc,CombOther,CombAdminOnly
                 FROM CH_ALLPVA_SALES
				 WHERE      month(date) = @in_month and year(date) = @in_year   
			) c 
		   on v.pmid =c.pmid where month(v.date) = @in_month and year(v.date) = @in_year  -- CHANGE DATES

--INSERT WH DATA Brand WHERE THERE IS WH VOLUME BUT THERE WAS NO PVA VOLUME
 INSERT  into pharmacymaster..ALL_Volume (Date,PMID,CHAccountNo,DCNum,DCCity,AccountName,Address,City,State,ZIP,APIAccountNo,AAPAccountNo,UDAccountNo,DEA,APICOGAppliedSales,
						APINetSales,APIGENRx,APIGENTotalSrc,APIGENTotalP2P3,APIGENTotal,APIBrand,APIOTC,APIOther,APIGBRPerc,AAPCOGAppliedSales,AAPNetSales,
						AAPBrand,AAPGENTotal,AAPGENTotalSrc,AAPGENExcl,AAPOTC,AAPOther,
                         AAPTotalRX,	AAPExcludedFromTotalRX,	AAPNonRXOTCandHH, AAPSourceCompliance,
						UDNetSales,UDBrand,UDGENTotalSrc,UDGENTotal,UDOTC,UDOther,UDAdminOnly,CombNetSales,
						CombBrands,CombOTC,CombGENTotal,CombGENTotalSrc,CombOther,CombAdminOnly )   

      SELECT @date ,PMID,CHAccountNo,DCNum,DCCity,AccountName,Address,City,State,ZIP,APIAccountNo,AAPAccountNo,UDAccountNo,DEA,APICOGAppliedSales,
						APINetSales,APIGENRx,APIGENTotalSrc,APIGENTotalP2P3,APIGENTotal,APIBrand,APIOTC,APIOther,APIGBRPerc,AAPCOGAppliedSales,AAPNetSales,
						AAPBrand,AAPGENTotal,AAPGENTotalSrc,AAPGENExcl,AAPOTC,AAPOther,
                         AAPTotalRX,	AAPExcludedFromTotalRX,	AAPNonRXOTCandHH, AAPSourceCompliance,
						UDNetSales,UDBrand,UDGENTotalSrc,UDGENTotal,UDOTC,UDOther,UDAdminOnly,CombNetSales,
						CombBrands,CombOTC,CombGENTotal,CombGENTotalSrc,CombOther,CombAdminOnly
      FROM (   -- CHANGE DATES
			SELECT Date,PMID,CHAccountNo,DCNum,DCCity,AccountName,Address,City,State,ZIP,APIAccountNo,AAPAccountNo,UDAccountNo,DEA,APICOGAppliedSales,
						APINetSales,APIGENRx,APIGENTotalSrc,APIGENTotalP2P3,APIGENTotal,APIBrand,APIOTC,APIOther,APIGBRPerc,AAPCOGAppliedSales,AAPNetSales,
						AAPBrand,AAPGENTotal,AAPGENTotalSrc,AAPGENExcl,AAPOTC,AAPOther,
                         AAPTotalRX,	AAPExcludedFromTotalRX,	AAPNonRXOTCandHH, AAPSourceCompliance,
						UDNetSales,UDBrand,UDGENTotalSrc,UDGENTotal,UDOTC,UDOther,UDAdminOnly,CombNetSales,
						CombBrands,CombOTC,CombGENTotal,CombGENTotalSrc,CombOther,CombAdminOnly
                 FROM CH_ALLPVA_SALES
				 WHERE      month(date) = @in_month and year(date) = @in_year   
		 )vol
	 WHERE not exists  (select pmid from pharmacymaster..ALL_Volume where pmid = vol.pmid and   month(date) = @in_month and year(date) = @in_year  ); -- CHANGE DATES



	---SET any NULLS TO ZERO and DO totals
    
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

-- AAPTotalRX,	AAPExcludedFromTotalRX,	AAPNonRXOTCandHH, AAPSourceCompliance,

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

--UPdate Totals 
	UPDATE ALL_Volume set CombNetSales = APINetSales + AAPNetSales + UDNetSales;
	UPDATE ALL_Volume set CombBrands = APIBrand + AAPBrand + UDBrand;
    UPDATE ALL_Volume SET CombOTC = APIOTC + AAPOTC + UDOTC ;
    UPDATE ALL_Volume SET CombGENTotal = APIGENTotal + AAPGENTotal + UDGENTotal;
    UPDATE ALL_Volume SET CombGENTotalSrc = APIGENTotalSrc + AAPGENTotalSrc + UDGENTotalSrc;
    UPDATE ALL_Volume SET CombOther = AAPOther + UDOther + APIOther;
	UPDATE ALL_Volume SET CombAdminOnly = UDAdminOnly;

--  QA for what was loaded from the CH_ALLPVA_SALES
--	select sum(CombNetSales) from  CH_ALLPVA_SALES where month(date)= 09
--	select sum(CombNetSales) from  ALL_Volume where month(date)= 09
--
--	 select sum(CombBrands)  from CH_ALLPVA_SALES where month(date)= 09
--	 select sum(CombBrands)  from ALL_Volume where month(date)= 09
--
--     select sum(CombOTC)  from CH_ALLPVA_SALES   where month(date)= 09
--     select sum(CombOTC)  from ALL_Volume   where month(date)= 09 
-- 
--     select sum(CombGENTotal)  from CH_ALLPVA_SALES where month(date)= 09
--     select sum(CombGENTotal)  from ALL_Volume where month(date)= 09
--
--    select sum(CombGENTotalSrc)  from CH_ALLPVA_SALES where month(date)= 09
--    select sum(CombGENTotalSrc)  from ALL_Volume where month(date)= 09
--
--     select sum(CombOther)  from CH_ALLPVA_SALES   where month(date)= 09
--     select sum(CombOther)  from ALL_Volume   where month(date)= 09
--
--	 select sum(CombAdminOnly)   from CH_ALLPVA_SALES where month(date)= 09
--	 select sum(CombAdminOnly)   from ALL_Volume where month(date)= 09
--
--
--	select sum(CombNetSales), sum( APINetSales + AAPNetSales + UDNetSales) from CH_ALLPVA_SALES where month(date) = 09
--	select sum(CombNetSales), sum( APINetSales + AAPNetSales + UDNetSales) from ALL_Volume where month(date) = 09
--
--	select  sum(CombBrands) ,sum(APIBrand + AAPBrand + UDBrand ) from CH_ALLPVA_SALES where month(date) = 09
--	select  sum(CombBrands) ,sum(APIBrand + AAPBrand + UDBrand ) from ALL_Volume where month(date) = 09
--
--    select   sum(CombOTC), sum(APIOTC + AAPOTC + UDOTC) from CH_ALLPVA_SALES where month(date) = 09
--    select   sum(CombOTC), sum(APIOTC + AAPOTC + UDOTC) from ALL_Volume where month(date) = 09
--
--    select   sum(CombGENTotal),sum(APIGENTotal + AAPGENTotal + UDGENTotal) from CH_ALLPVA_SALES where month(date) = 09
--    select   sum(CombGENTotal),sum(APIGENTotal + AAPGENTotal + UDGENTotal) from ALL_Volume where month(date) = 09
--
--    select   sum(CombGENTotalSrc), sum(APIGENTotalSrc + AAPGENTotalSrc + UDGENTotalSrc) from CH_ALLPVA_SALES where month(date) = 09
--    select   sum(CombGENTotalSrc), sum(APIGENTotalSrc + AAPGENTotalSrc + UDGENTotalSrc) from ALL_Volume where month(date) = 09
--
--    select   sum(CombOther), sum(AAPOther + UDOther + APIOther) from CH_ALLPVA_SALES where month(date) = 09
--    select   sum(CombOther), sum(AAPOther + UDOther + APIOther) from ALL_Volume where month(date) = 09
--
--	select   sum(CombAdminOnly), sum(UDAdminOnly) from CH_ALLPVA_SALES where month(date) = 09
--	select   sum(CombAdminOnly), sum(UDAdminOnly) from ALL_Volume where month(date) = 09


 
END








GO
