USE [ReportsTest]
GO
/****** Object:  View [test].[SampleStores]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [test].[SampleStores]
	AS
SELECT 
*
FROM 
[PharmacyMaster].dbo.v_PM_AllWithAffiliates
GO
