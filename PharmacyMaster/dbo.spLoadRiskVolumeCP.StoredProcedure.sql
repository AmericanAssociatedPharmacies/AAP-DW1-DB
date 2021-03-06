USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spLoadRiskVolumeCP]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JOSHILA NARAYANAN
-- Create date: 02/19/2015
-- Description:	Create temp Tables for Risk Mitigation Reports
-- =============================================
CREATE PROCEDURE [dbo].[spLoadRiskVolumeCP]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Load Volume Data

	If EXISTS (SELECT [name] from sys.tables where [name]='RiskVolumeALL')
	Drop Table RiskVolumeAll

	SELECT Date, NCPDP, AAPNetSales as CHSVolume,WHAPITotal as APIVolume,MLTotal as MLVolume, AAPNetSales + WHAPITotal + MLTotal as TotalVolume, MONTH(Date) AS Month, YEAR(Date) AS Year
	INTO RiskVolumeAll FROM dbo.ALL_Volume LEFT OUTER JOIN claims..PMStores ON  dbo.ALL_Volume.PMID = PMStores.PMID
	WHERE DATE > CONVERT(VARCHAR(10), DATEADD(mm, DATEDIFF(mm,0,DATEADD(m, - 19, GETDATE())), 0), 121) AND NCPDP IS NOT NULL AND NCPDP <> ''

	If EXISTS (SELECT [name] from sys.tables where [name]='RiskVolume')	
	DROP TABLE RiskVolume

	Select NCPDP,Year,Month, SUM(CHSVolume) as CHSVolume, SUM(APIVolume) as APIVolume, SUM(MLVolume) as MLVolume, SUM(TotalVolume) as TotalVolume
	INTO RiskVolume FROM RiskVolumeAll GROUP BY NCPDP,Year,Month



	--Load Central Pay Data 
	If EXISTS (SELECT [name] from sys.tables where [name]='RiskCP')
	Drop Table RiskCP

	DECLARE @date nvarchar(30)
	DECLARE @SQL nvarchar(500)

	set @date =  CONVERT(VARCHAR(10), DATEADD(mm, DATEDIFF(mm,0,DATEADD(m, - 19, GETDATE())), 0), 121)

	--set @sql= 'select * into RiskCP from OPENQUERY(UNITEDDB,''select ncpdp, year(tran_dt) as yr,month(tran_dt) as mo,sum(dep_amt) as CPamount from accounting.cp_direct_deposit' +
	set @sql= 'select ncpdp, year(tran_dt) as yr,month(tran_dt) as mo,sum(dep_amt) as CPamount into RiskCP  from CPay..CP2DirectDeposit' +

	' where tran_dt > ''' + @date + 

	''' group by ncpdp, year(tran_dt), month(tran_dt)  union Select CP2Check.ncpdp, year(CP2Check.paid_dt) as yr, month(CP2Check.paid_dt) as mo, sum(CP2Check.paid_amt) as CPamount from CPay..CP2Check where paid_dt > ''' +

	@date + ''' group by ncpdp,year(paid_dt),month(paid_dt)'

    print @sql;
	exec(@sql);

	GRANT CONTROL ON PharmacyMaster.dbo.RiskVolumeAll TO RiskMgmtDevs
	GRANT CONTROL ON PharmacyMaster.dbo.RiskVolume TO RiskMgmtDevs
	GRANT CONTROL ON PharmacyMaster.dbo.RiskCP TO RiskMgmtDevs


END
GO
