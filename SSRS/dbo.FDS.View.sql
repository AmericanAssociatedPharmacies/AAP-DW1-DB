USE [SSRS]
GO
/****** Object:  View [dbo].[FDS]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FDS] AS
SELECT *
FROM ClaimsDDS.dbo.FDSComplianceReport 
GO
