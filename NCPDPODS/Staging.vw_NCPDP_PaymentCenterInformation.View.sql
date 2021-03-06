USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_PaymentCenterInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_NCPDP_PaymentCenterInformation]

AS

SELECT SUBSTRING(C1,1,6) AS PaymentCenterID
, SUBSTRING(C1,7,35) AS PaymentCenterName
, NULLIF(SUBSTRING(C1,42,55), '') AS PaymentCenterAddress1
, NULLIF(SUBSTRING(C1,97,55), '') AS PaymentCenterAddress2
, NULLIF(SUBSTRING(C1,152,30), '') AS PaymentCenterCity
, NULLIF(SUBSTRING(C1,182,2), '') AS PaymentCenterStateCode
, NULLIF(SUBSTRING(C1,184,9), '') AS PaymentCenterZipCode
, NULLIF(SUBSTRING(C1,193,10), '') AS PaymentCenterPhoneNumber
, NULLIF(SUBSTRING(C1,203,5), '') AS PaymentCenterExtension
, NULLIF(SUBSTRING(C1,208,10), '') AS PaymentCenterFaxNumber
, NULLIF(SUBSTRING(C1,218,10), '') AS PaymentCenterNPI
, NULLIF(SUBSTRING(C1,228,15), '') AS PaymentCenterFedralTaxID
, NULLIF(SUBSTRING(C1,243,30), '') AS PaymentCenterContactName
, NULLIF(SUBSTRING(C1,273,30), '') AS PaymentCenterContactTitle
, NULLIF(SUBSTRING(C1,303,50), '') AS PaymentCenterEmailAddress
, NULLIF(SUBSTRING(C1,353,8), '') AS DeleteDate
FROM(SELECT MIN(RowID) AS MinRowID
	, MAX(RowID) AS MaxRowID
	FROM ODSIntake.[Staging].[NCPDP_PaymentCenterInformation]
	) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_PaymentCenterInformation] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID
GO
