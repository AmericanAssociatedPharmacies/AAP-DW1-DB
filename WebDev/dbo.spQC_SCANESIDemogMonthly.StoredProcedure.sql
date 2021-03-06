USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_SCANESIDemogMonthly]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Deepa
-- Create date: 4/18/2016
-- Description:	Display ESI scan monthly demographic data on website
				-- 4/27/2016 DG --Added a filter on date columns to return only current year's data, per Darla's request
				--6/3/2016 DG --Renamed LICS column
-- =============================================
CREATE PROCEDURE [dbo].[spQC_SCANESIDemogMonthly] 
	@ncpdp varchar(7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT 
[PATIENT_ID] as [Patient ID]
      ,[PATIENT_LAST_NAME] as [Patient LName]
      ,[PAT_FIRST_NME] as [Patient FName]
      ,DOB as [DOB (yy/mm/dd)]
      ,[PHONE] as Phone
	,case  [GENDER_CDE] when 'M' then 'Male' when 'F' then 'Female' end as Gender
      ,[ADDRESS_LINE_1] + ' ' + ISNULL([ADDRESS_LINE_2],'') as [Address]      
      ,[CITY_NME] as City
      ,[STATE] 
      ,[ZIP]
      ,[LICS] as [Low Income Subsidy]--as [License Status]      
	,convert(varchar(12),convert(datetime,[Date_Last_Fill_Diabetes]),101) as [Date LastFill Diabetes]
      ,[Last_Fill_GCN_Diabetes] as [LastFill GCN Diabetes]
      ,[Last_Fill_Rx_Nbr_Diabetes] as [LastFill Rx Nbr Diabetes]
      ,convert(varchar(12),convert(datetime,[Date_Last_Fill_Hypertension]),101) as [Date LastFill Hypertension] 
      ,[Last_Fill_GCN_Hypertension] as [LastFill GCN Hypertension]
      ,[Last_Fill_Rx_Nbr_Hypertension] as [LastFill Rx Nbr Hypertension]
      ,convert(varchar(12),convert(datetime,[Date_Last_Fill_cholesterol]),101) as [Date LastFill Cholesterol] 
      ,[Last_Fill_GCN_cholesterol] as [LastFill GCN Cholesterol]
      ,[Last_Fill_Rx_Nbr_cholesterol] as [LastFill Rx Nbr Cholesterol]

  
 INTO #TempTable_QC_ScanEsiDemogMonthly  
FROM [QC_ScanEsiDemographicMonthly]
where ncpdp=@ncpdp --'0512334'
and isvalid=1
and filedate=(select max(filedate) from [QC_ScanEsiDemographicMonthly])
-- 4/27/2016 DG --Added a filter on date columns to return only current year's data, per Darla's request
AND (convert(datetime, [Date_Last_Fill_Diabetes]) >=  DATEADD(yy, DATEDIFF(yy,0,getdate()), 0) 
	OR convert(datetime, [Date_Last_Fill_Hypertension]) >=  DATEADD(yy, DATEDIFF(yy,0,getdate()), 0)
	OR  convert(datetime, [Date_Last_Fill_cholesterol]) >=  DATEADD(yy, DATEDIFF(yy,0,getdate()), 0))
order by [PATIENT_ID] 

select *
from #TempTable_QC_ScanEsiDemogMonthly 

drop table #TempTable_QC_ScanEsiDemogMonthly 
END

--exec spQC_SCANESIDemogMonthly '0512334'
GO
