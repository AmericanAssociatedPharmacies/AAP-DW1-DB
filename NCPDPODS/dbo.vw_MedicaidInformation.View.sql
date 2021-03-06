USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_MedicaidInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_MedicaidInformation]

AS


SELECT MedicaidKey, NCPDPProviderID, StateCode, MedicaidID
, CASE	
	WHEN DeleteDate = '00000000' THEN '29991231'
	ELSE NULL
	END AS DeleteDate
, RowCreatedDate
FROM [dbo].[MedicaidInformation]
GO
