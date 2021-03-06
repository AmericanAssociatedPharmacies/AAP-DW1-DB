USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_Adherence_all]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spQC_Adherence_all]
(
@ncpdp varchar(11)
,@showall int	--0 next fill date > today -N; 1 all in table DATEADD(mm, 1, @StartDate)
)
as
DECLARE @startdt datetime
set @startdt = case when @showall=1 then DATEADD(mm,-3,getdate()) else DATEADD(dd,-10,getdate()) end

SELECT --[Pharm ID]
      [BINNbr] as [Bin]
      ,[PlanName] as [Plan]
      --,[GPI]
      ,[PatID] as [Patient ID]
      --,CONVERT(VARCHAR(8),[PatientDOB],1) as [DOB]
      ,[Category]
      ,[DrugName] as [Drug]
      ,[Rx Nbr] as [Rx #]
      ,CONVERT(VARCHAR(8),[NextFillDate],1) as [Next Fill]
      ,CONVERT(VARCHAR(8),[LastFillDate],1) as [Last Fill]
      ,[RefillsRemain] as [Refills Remaining]
      ,[RefillNbr] as [Refill #]
      --,[DaysAfterLastRefill]
      ,[DaySupply] as [DS]
      
  FROM [WebDev].[dbo].[QC_Adherence]
  where [pharm id] = @ncpdp
  and [NextFillDate] >= @startdt
  order by [NextFillDate] desc
  
--  grant execute on spQC_Adherence to webdevuser
/*
select top 10 * from QC_Adherence --where category is not null
select max(lastfilldate) from QC_Adherence where [pharm id]='0105432'
*/
GO
