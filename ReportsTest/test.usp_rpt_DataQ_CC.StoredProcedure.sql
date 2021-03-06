USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_DataQ_CC]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_rpt_DataQ_CC]
	--------------
	--Parameters--
	--------------
@NCPDPProviderID VARCHAR(7)
	--------------

AS
     SET NOCOUNT ON;
     BEGIN
	---------------
	--TEMP TABLES--
	---------------
         DECLARE @TempSample TABLE
(NCPDPProviderID              INT
, PhysicalLocationCountyParish VARCHAR(5)
);
         DECLARE @TempCounty TABLE
(Code VARCHAR(5)
, Name VARCHAR(50)
);
	   ----------------------------
	   --DataQ Provider information
	   ----------------------------

         INSERT INTO @TempSample
                SELECT DISTINCT
                       a.NCPDPProviderID
                     , a.PhysicalLocationCountyParish
                FROM NCPDPODS.dbo.vw_ProviderInformation AS a
                WHERE a.NCPDPProviderID = @NCPDPProviderID;
         INSERT INTO @TempCounty
                SELECT b.StateFIPSCode + b.CountyFIPSCode AS Code
                     , b.GUName AS Name
                FROM ReportsTest.test.CountyCode AS b
                WHERE b.EntityDescription = 'County';
         SELECT UPPER(t1.Name) AS name
         FROM @TempCounty AS t1
              JOIN @TempSample AS t2 ON t1.Code = t2.PhysicalLocationCountyParish;
     END;



GO
