USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[PMGetOwnerFirstName]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rudy E. Hinojosa
-- Create date: 6-9-2010
-- Description:	Returns Last Name from Ownerfullname
-- =============================================
CREATE FUNCTION [dbo].[PMGetOwnerFirstName]
(
	-- Add the parameters for the function here
	@pOwnername varchar(100)
)
RETURNS varchar(100)
AS
BEGIN
	declare @result varchar(100)
	SELECT @result =  substring(@pOwnername,0,charindex(' ',@pOwnername)) 
	from pharmacymaster.dbo.pm_pharmacy where 1=1
	RETURN isnull(@result,'')

END


GO
