USE [Medispan]
GO
/****** Object:  View [dbo].[vw_API_MF2NDC]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_API_MF2NDC]

AS

SELECT *
FROM [Medispan_Staging].[dbo].[MF2NDC_H]
GO
