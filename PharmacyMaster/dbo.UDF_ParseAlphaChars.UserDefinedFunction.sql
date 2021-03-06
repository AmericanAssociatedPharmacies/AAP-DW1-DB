USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[UDF_ParseAlphaChars]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[UDF_ParseAlphaChars]
(
@string VARCHAR(8000)
)
RETURNS VARCHAR(8000)
AS
BEGIN
DECLARE @IncorrectCharLoc SMALLINT
SET @IncorrectCharLoc = PATINDEX('%[^0-9]%', @string)
WHILE @IncorrectCharLoc > 0
BEGIN
SET @string = STUFF(@string, @IncorrectCharLoc, 1, '')
SET @IncorrectCharLoc = PATINDEX('%[^0-9]%', @string)
END
SET @string = @string
RETURN @string
END

GO
