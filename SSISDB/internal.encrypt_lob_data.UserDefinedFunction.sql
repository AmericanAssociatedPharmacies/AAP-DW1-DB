USE [SSISDB]
GO
/****** Object:  UserDefinedFunction [internal].[encrypt_lob_data]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [internal].[encrypt_lob_data]
( 
    @key_name nvarchar(255), 
    @KEY varbinary(8000),
    @IV varbinary(8000),
    @lob varbinary(max) 
)
RETURNS varbinary(max)
AS
BEGIN
    DECLARE @encrypted_binary varbinary(MAX)
    SET @encrypted_binary = (SELECT [internal].[encrypt_binarydata](@key_name, @KEY,@IV, @lob))
    RETURN @encrypted_binary
END
GO
