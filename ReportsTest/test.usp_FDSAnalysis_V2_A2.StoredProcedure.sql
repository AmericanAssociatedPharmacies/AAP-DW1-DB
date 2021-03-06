USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_FDSAnalysis_V2_A2]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
Author: David Bohler 
Create Date: 11/21/2018 
Update Date 01/04/2018
Description: FDS Data Analysis
*/

CREATE PROCEDURE [test].[usp_FDSAnalysis_V2_A2]
	--------------
	--Parameters--
	--------------
@PMID INT
	--------------
AS
     SET NOCOUNT ON;
     BEGIN
         SELECT DISTINCT t1.PMID
              , t1.PharmacyName
         FROM SalesDDS.dbo.PharmacyDim AS t1
	    WHERE t1.PMID = @PMID
     END;

GO
