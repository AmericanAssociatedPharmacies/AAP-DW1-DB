USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_ProviderRelationship]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ProviderRelationship]

AS

SELECT ProviderRelationshipKey
, NCPDPProviderID
, RelationshipID
, PaymentCenterID
, RemitandReconciliationID
, ProviderType
, IsPrimary
, CONVERT(DATE, CASE	
			WHEN EffectiveFromDate = '00000000' THEN '29991231'
			ELSE RIGHT(EffectiveFromDate, 4) + LEFT(EffectiveFromDate, 2) +  SUBSTRING(EffectiveFromDate,3,2)
			END
			) AS EffectiveFromDate
, CONVERT(DATE, CASE	
			WHEN EffectiveThroughDate = '00000000' THEN '29991231'
			ELSE RIGHT(EffectiveThroughDate, 4) + LEFT(EffectiveThroughDate, 2) +  SUBSTRING(EffectiveThroughDate,3,2)
			END
			) AS EffectiveThroughDate
, RowCreatedDate
FROM [dbo].[ProviderRelationship]
GO
