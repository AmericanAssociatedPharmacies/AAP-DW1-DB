USE [AdventureWorksDW2012]
GO
/****** Object:  UserDefinedFunction [dbo].[udfBuildISO8601Date]    Script Date: 12/22/2020 6:01:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Builds an ISO 8601 format date from a year, month, and day specified as integers.
-- This format of date should parse correctly regardless of SET DATEFORMAT and SET LANGUAGE.
-- See SQL Server Books Online for more details.
CREATE FUNCTION [dbo].[udfBuildISO8601Date] (@year int, @month int, @day int)
RETURNS datetime
AS 
BEGIN
	RETURN cast(convert(varchar, @year) + '-' + [dbo].[udfTwoDigitZeroFill](@month) 
	    + '-' + [dbo].[udfTwoDigitZeroFill](@day) + 'T00:00:00' 
	    as datetime);
END
GO
