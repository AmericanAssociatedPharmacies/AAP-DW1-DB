USE [AdventureWorksDW2012]
GO
/****** Object:  UserDefinedFunction [dbo].[udfTwoDigitZeroFill]    Script Date: 12/22/2020 6:01:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Converts the specified integer (which should be < 100 and > -1)
-- into a two character string, zero filling from the left 
-- if the number is < 10.
CREATE FUNCTION [dbo].[udfTwoDigitZeroFill] (@number int) 
RETURNS char(2)
AS
BEGIN
	DECLARE @result char(2);
	IF @number > 9 
		SET @result = convert(char(2), @number);
	ELSE
		SET @result = convert(char(2), '0' + convert(varchar, @number));
	RETURN @result;
END

GO
