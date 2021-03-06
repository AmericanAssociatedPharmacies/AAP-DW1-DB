USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[member_compliance_reports]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[member_compliance_reports]
@V_StartDate datetime,
@V_EndDate datetime
as
If OBJECT_ID('tempdb..#TempAnalysis_temp') is not null
begin
truncate table #TempAnalysis_temp
end 
else 
begin 
Create table #TempAnalysis_temp (PMID int,[Start_Date] datetime,[End_Date] datetime, Purchase  decimal (18,2) ,Dispense  decimal (18,2) ,[PR%]  decimal (18,2) )
end 

If OBJECT_ID('tempdb..#TempAnalysis') is not null
begin
truncate table #TempAnalysis
end 
else 
begin 
create table #TempAnalysis 
(PMID INT, 
 GPI                VARCHAR(20), 
 Description        VARCHAR(250), 
 [Purchase Qty]     DECIMAL(18, 2), 
 [Purchases @ AWP]  DECIMAL(18, 2), 
 [Dispense Qty]     DECIMAL(18, 2), 
 [Dispense @ AWP]   DECIMAL(18, 2), 
 [Leakage Quantity] DECIMAL(18, 2), 
 [Leakage @ AWP]    DECIMAL(18, 2)
);
end 



declare  @IncrementalCounter INT 
declare @GPI int
declare @GPICount int
set @GPICount=ISNULL((SELECT COUNT(GPI) FROM GPI_NUMBERS),0)
SET @IncrementalCounter = 1

while @IncrementalCounter <= @GPICount

BEGIN

SELECT @GPI =GPI FROM GPI_NUMBERS where ROWID = @IncrementalCounter
SET @IncrementalCounter = @incrementalCounter +1


	 

INSERT INTO #TempAnalysis
( GPI, PMID,
 Description, 
 [Purchase Qty], 
 [Purchases @ AWP], 
 [Dispense Qty], 
 [Dispense @ AWP], 
 [Leakage Quantity], 
 [Leakage @ AWP]
)
EXEC [SSRS].[dbo].[usp_Compliance_Beta_workaround] 
     @PMID = @GPI, 
     @StartDate =@V_StartDate,
     @EndDate = @V_EndDate,
	 -- Do not Change! This parameter sets it to GENERIC ONLY
     @BG = 1;
	


--select  GPI, 
-- Description, 
-- [Purchase Qty], 
-- [Purchases @ AWP], 
-- [Dispense Qty], 
-- [Dispense @ AWP], 
-- [Leakage Quantity], 
-- [Leakage @ AWP] from #TempAnalysis
--group by GPI, 
-- Description, 
-- [Purchase Qty], 
-- [Purchases @ AWP], 
-- [Dispense Qty], 
-- [Dispense @ AWP], 
-- [Leakage Quantity], 
-- [Leakage @ AWP]
-- HAVING COUNT(*) >1;
 
 insert into #TempAnalysis_temp 
select @GPI as PMID, @V_StartDate,@V_EndDate, cast(SUM(a.[Purchases @ AWP])*100 AS decimal (18,2)) as [Purchase] , cast(SUM(a.[Dispense @ AWP])*100 AS decimal (18,2))
as [Dispense], CAST(SUM(a.[Purchases @ AWP]) / SUM(a.[Dispense @ AWP])*100 AS decimal (18,2)) AS [PR %]
FROM
(
    SELECT *
    FROM #TempAnalysis  where PMID=@GPI
) AS a
END
select * from #TempAnalysis_temp





--exec member_compliance_reports N'20190210',N'20191231'
GO
