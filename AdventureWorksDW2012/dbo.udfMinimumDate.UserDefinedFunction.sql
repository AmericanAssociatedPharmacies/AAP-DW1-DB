USE [AdventureWorksDW2012]
GO
/****** Object:  UserDefinedFunction [dbo].[udfMinimumDate]    Script Date: 12/22/2020 6:01:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udfMinimumDate] (
    @x DATETIME, 
    @y DATETIME
) RETURNS DATETIME
AS
BEGIN
    DECLARE @z DATETIME

    IF @x <= @y 
        SET @z = @x 
    ELSE 
        SET @z = @y

    RETURN(@z)
END
GO
