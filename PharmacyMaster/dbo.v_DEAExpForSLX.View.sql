USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_DEAExpForSLX]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_DEAExpForSLX]
AS
SELECT  DEA,DEAExp  from  v_pm_allwithaffiliates
where DEA is not null and  deaexp is not null  
 
GO
