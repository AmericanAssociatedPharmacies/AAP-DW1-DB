USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[USP_MemberComplainceReport]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[USP_MemberComplainceReport](@start_date datetime,@end_date datetime)
as 
Begin
If OBJECT_ID('tempdb..#TempAnalysis_temp') is not null
begin
truncate table #TempAnalysis_temp
end 
else 
begin 
Create table #TempAnalysis_temp (PMID int,StartDate date,EndDate Date, Purchase  decimal (18,2) ,Dispense  decimal (18,2) ,[PR%]  decimal (18,2) )
end
Declare MemberComplaince Cursor for 
select GPI from GPI_NUMBERS
Open MemberComplaince
Declare @GPI int
--,@stdate Date=N'20190101',@edate date=N'20191231'

Fetch Next from MemberComplaince into @GPI
while @@FETCH_STATUS=0
BEGIN

DECLARE @TempAnalysis TABLE
(GPI                VARCHAR(20), 
 Description        VARCHAR(250), 
 [Purchase Qty]     DECIMAL(18, 2), 
 [Purchases @ IP]  DECIMAL(18, 2), 
 [Dispense Qty]     DECIMAL(18, 2), 
 [Dispense @ IP]   DECIMAL(18, 2), 
 [Leakage Quantity] DECIMAL(18, 2), 
 [Leakage @ IP]    DECIMAL(18, 2)
);
INSERT INTO @TempAnalysis
(GPI, 
 Description, 
 [Purchase Qty], 
 [Purchases @ IP], 
 [Dispense Qty], 
 [Dispense @ IP], 
 [Leakage Quantity], 
 [Leakage @ IP]
)
EXEC [SSRS].[dbo].[usp_Compliance_Beta] 
     @PMID = @GPI, 
     @StartDate =@start_date,
     @EndDate = @end_date,
	 -- Do not Change! This parameter sets it to GENERIC ONLY
     @BG = 1;
insert into #TempAnalysis_temp 
select @GPI,@start_date,@end_date, cast(SUM(a.[Purchases @ IP])*100 AS decimal (18,2)) as [Purchase] ,
 cast(SUM(a.[Dispense @ IP])*100 AS decimal (18,2))as [Dispense], 
CAST(SUM(a.[Purchases @ IP]) / SUM(a.[Dispense @ IP])*100 AS decimal (18,2)) AS [PR %]
FROM
(
    SELECT *
    FROM @TempAnalysis
) AS a
Fetch Next from MemberComplaince into @GPI
delete from @TempAnalysis
END
close MemberComplaince
Deallocate MemberComplaince
select * from #TempAnalysis_temp
end
GO
