USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_AllWithGroups]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_PM_AllWithGroups]
AS

SELECT p.* , dbo.PMListGroupAfflNames(pmid) as group_name,dbo.PmListGroupID(p.pmid)   as GroupID from pm_pharmacy p
 
 
GO
