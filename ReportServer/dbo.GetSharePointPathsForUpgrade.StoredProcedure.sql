USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[GetSharePointPathsForUpgrade]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetSharePointPathsForUpgrade]
AS
BEGIN
SELECT DISTINCT SUBSTRING([Path], 1, LEN([Path])-LEN([Name]) - 1) as Prefix, LEN([Path])-LEN([Name]) as PrefixLen
  FROM [Catalog]
  WHERE LEN([Path]) > 0 AND [Path] NOT LIKE '/{%'
  ORDER BY PrefixLen DESC
END
GO
