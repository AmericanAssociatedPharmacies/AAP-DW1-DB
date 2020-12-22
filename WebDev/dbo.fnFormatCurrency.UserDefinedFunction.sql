USE [WebDev]
GO
/****** Object:  UserDefinedFunction [dbo].[fnFormatCurrency]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnFormatCurrency]
(@Param1 money)
RETURNS varchar(15)
as
BEGIN
Return('$'+convert(varchar,@param1,1))
END
GO
