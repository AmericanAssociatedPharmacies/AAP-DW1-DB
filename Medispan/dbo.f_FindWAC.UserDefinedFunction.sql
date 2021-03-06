USE [Medispan]
GO
/****** Object:  UserDefinedFunction [dbo].[f_FindWAC]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		JOSHILA NARAYANAN
-- Create date: 04/25/2012
-- Description:	Return WAC Pricing for a given NDC, date and type
-- =============================================
CREATE FUNCTION [dbo].[f_FindWAC] 
(
	@NDC varchar(11),	
	@date datetime
)
RETURNS numeric(11,5)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Price numeric(11,5)

	-- Add the T-SQL statements to compute the return value here

	SELECT   @Price= WAC
	FROM         dbo.v_WACHistory
	WHERE NDC=@NDC AND WACDate = (Select MAX(WACDate) from dbo.v_WACHistory where WACDate < @date and NDC=@NDC)


	-- Return the result of the function
	RETURN @Price

END

GO
