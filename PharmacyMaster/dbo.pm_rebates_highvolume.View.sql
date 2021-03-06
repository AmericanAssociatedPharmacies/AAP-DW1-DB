USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[pm_rebates_highvolume]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pm_rebates_highvolume]

AS

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
FROM pharmacymaster.dbo.pm_rebates_highvolume_New
--ORDER BY Date ASC, PMID ASC
GO
