USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Archive].[usp_pm_rebates_highvolume_New_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Archive].[usp_pm_rebates_highvolume_New_Load]

AS

SET NOCOUNT ON;

BEGIN


INSERT INTO [Archive].[pm_rebates_highvolume_New]
			([date]
			, [rebate_type]
			, [PMID]
			, [AAP#]
			, [API acct]
			, [Customer Name]
			, [City]
			, [ST]
			, [Bs Class]
			, [Month]
			, [Current Est Mo Sales]
			, [Mo API Volume]
			, [CAH off Contract-LTC Volume]
			, [AAP Net Sales]
			, [Mo Comb Volume]
			, [AAP Sales- COG Applied]
			, [AAP Brand RX Sales]
			, [Current CA COG]
			, [Base]
			, [Brand RX@WAC]
			, [Brand RX Saved]
			, [High Volume Incentive]
			, [Total Saved]
			, [ECOG]
			, [COG Reduction]
			, [Generic Source]
			, [1% Generic Admin]
			, [Incentive from AAP Net Sales]
			, [A/P Payment Mode]
			, [Group]
			, [RowCreatedDate]
			, [RowUpdatedDate]
			, [RowversionID]
			)


			SELECT [date]
			, [rebate_type]
			, [PMID]
			, [AAP#]
			, [API acct]
			, [Customer Name]
			, [City]
			, [ST]
			, [Bs Class]
			, [Month]
			, [Current Est Mo Sales]
			, [Mo API Volume]
			, [CAH off Contract-LTC Volume]
			, [AAP Net Sales]
			, [Mo Comb Volume]
			, [AAP Sales- COG Applied]
			, [AAP Brand RX Sales]
			, [Current CA COG]
			, [Base]
			, [Brand RX@WAC]
			, [Brand RX Saved]
			, [High Volume Incentive]
			, [Total Saved]
			, [ECOG]
			, [COG Reduction]
			, [Generic Source]
			, [1% Generic Admin]
			, [Incentive from AAP Net Sales]
			, [A/P Payment Mode]
			, [Group]
			, [RowCreatedDate]
			, [RowUpdatedDate]
			, [RowversionID]
			FROM [Staging].[pm_rebates_highvolume_New]

END

--SELECT ', [' + name + ']'
--FROM sys.syscolumns
--WHERE id = OBJECT_ID('Staging.pm_rebates_highvolume_New')
--ORDER BY colid ASC
GO
