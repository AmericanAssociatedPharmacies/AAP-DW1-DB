USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spQC_SCANESIDaily]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spQC_SCANESIDaily]
(
	@ncpdp varchar(8),
	@includePHI int
)
AS
/*	rxaap quality center SCAN data display
	copy of spQC_SCANESIDaily which returns no data when called from PHP
	BG 1/2015 show only populated columns, e.g. omit drug3 if no records containing it
	optionally suppress PHI columns
*/
BEGIN
DECLARE @buf varchar(100)
SELECT 
distinct --remove duplicates in successive files
	  /*[Id]
      ,[QC_ScanFileId]
      ,[NCPDP]
      ,[NPI]
      ,[PharmacyName]
      ,[CorporateName]
      ,[ClientEsiId]
      ,
      */
	  case when @includePHI=1 then [PatientId] else '' end as [PatientId]
      ,case when @includePHI=1 then [PatientLName] else '' end as [PatientLName]
      ,case when @includePHI=1 then [PatientFName] else '' end as [PatientFName]
      ,case when @includePHI=1 then [DOB] else '' end as [DOB]
      ,case when @includePHI=1 then [Phone] else '' end as [Phone]
      --,[PlanName] --always SCAN HEALTH PLAN
      --,[CMSContractId] --show this? two distinct values
      ,[FirstFillDate]
      ,[Drug1NpiNbr]
      ,[Drug1NumFill]
      ,[Drug1Name]
      ,[Drug1GCN]
      ,[Drug2NumFill]
      ,[Drug2Name]
      ,[Drug2GCN]
      ,[Drug3NumFill]  --show this and the following only if populated
      ,[Drug3Name]
      ,[Drug3GCN]
      ,[Drug4NumFill]
      ,[Drug4Name]
      ,[Drug4GCN]
      ,[Drug5NumFill]
      ,[Drug5Name]
      ,[Drug5GCN]
      --,[IsValid] --? all NULL
INTO #TempTable_QC_ScanEsiDaily  
FROM [WebDev].[dbo].[QC_ScanEsiDaily]
where NCPDP=@NCPDP

SELECT @buf = max([Drug5Name]) from #TempTable_QC_ScanEsiDaily
if (ltrim(@buf)='' or @buf is null)
	BEGIN
		ALTER TABLE #TempTable_QC_ScanEsiDaily DROP COLUMN [Drug5NumFill],[Drug5Name],[Drug5GCN]
	END
SELECT @buf = max([Drug4Name]) from #TempTable_QC_ScanEsiDaily
if (ltrim(@buf)='' or @buf is null)
	BEGIN
		ALTER TABLE #TempTable_QC_ScanEsiDaily DROP COLUMN [Drug4NumFill],[Drug4Name],[Drug4GCN]
	END
SELECT @buf = max([Drug3Name]) from #TempTable_QC_ScanEsiDaily
if (ltrim(@buf)='' or @buf is null)
	BEGIN
		ALTER TABLE #TempTable_QC_ScanEsiDaily DROP COLUMN [Drug3NumFill],[Drug3Name],[Drug3GCN]
	END
SELECT @buf = max([Drug2Name]) from #TempTable_QC_ScanEsiDaily
if (@buf is null or ltrim(@buf)='')
	BEGIN
		ALTER TABLE #TempTable_QC_ScanEsiDaily DROP COLUMN [Drug2NumFill],[Drug2Name],[Drug2GCN]
	END	

SELECT * FROM #TempTable_QC_ScanEsiDaily  
DROP TABLE #TempTable_QC_ScanEsiDaily  
END


GO
