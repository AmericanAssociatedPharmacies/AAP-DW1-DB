USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetDrillthroughReport] Script Date: 12/21/2020 9:12:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDrillthroughReport]
@ModelPath nvarchar(425),
@ModelItemID nvarchar(425),
@Type tinyint
AS
 SELECT
 CatRep.Path
 FROM ModelDrill
 INNER JOIN Catalog CatMod ON ModelDrill.ModelID = CatMod.ItemID
 INNER JOIN Catalog CatRep ON ModelDrill.ReportID = CatRep.ItemID
 WHERE CatMod.Path = @ModelPath
 AND ModelItemID = @ModelItemID
 AND ModelDrill.[Type] = @Type
