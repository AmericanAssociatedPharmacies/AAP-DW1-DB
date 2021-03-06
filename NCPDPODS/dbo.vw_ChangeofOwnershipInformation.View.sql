USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_ChangeofOwnershipInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ChangeofOwnershipInformation]

AS

SELECT ChangeOfOwnershipKey
, NCPDPProviderID
, OldNCPDPProviderID
, CONVERT(DATE, RIGHT(OldStoreCloseDate, 4) + LEFT(OldStoreCloseDate, 2) +  SUBSTRING(OldStoreCloseDate,3,2)) AS OldStoreCloseDate
, CONVERT(DATE, RIGHT([ChangeofOwnershipEffectiveDate], 4) + LEFT([ChangeofOwnershipEffectiveDate], 2) +  SUBSTRING([ChangeofOwnershipEffectiveDate],3,2)) AS ChangeofOwnershipEffectiveDate
, RowCreatedDate
FROM [dbo].[ChangeofOwnershipInformation]
GO
