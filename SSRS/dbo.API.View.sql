USE [SSRS]
GO
/****** Object:  View [dbo].[API]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[API] AS
SELECT *
FROM SalesDDS.dbo.APIComplianceReport 
GO
