USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetDataSets]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[GetDataSets]
@ItemID [uniqueidentifier],
@AuthType int
AS
BEGIN

SELECT
    DS.ID,
    DS.LinkID,
    DS.[Name],
    C.Path,
    SD.NtSecDescPrimary,
    C.Intermediate,
    C.[Parameter]
FROM
   ExtendedDataSets AS DS
   LEFT OUTER JOIN Catalog C ON DS.[LinkID] = C.[ItemID]
   LEFT OUTER JOIN [SecData] AS SD ON C.[PolicyID] = SD.[PolicyID] AND SD.AuthType = @AuthType
WHERE
   DS.[ItemID] = @ItemID
END
GO
