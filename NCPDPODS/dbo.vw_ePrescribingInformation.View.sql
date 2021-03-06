USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_ePrescribingInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ePrescribingInformation]

AS


SELECT ePrescribingKey
, NCPDPProviderID
, ePrescribingNetworkIdentifier
, ePrescribingServiceLevelCodes
, CONVERT(DATE, RIGHT(EffectiveFromDate, 4) + LEFT(EffectiveFromDate, 2) +  SUBSTRING(EffectiveFromDate,3,2)) AS EffectiveFromDate
, CONVERT(DATE, CASE 
	WHEN EffectiveThroughDate = '00000000' THEN '29991231'
	ELSE NULL
	END
	) AS EffectiveThroughDate
, RowCreatedDate
FROM [dbo].[ePrescribingInformation]
GO
