USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[SumMonths]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE function [dbo].[SumMonths](
@m1 float,
@m2 float,
@m3 float)
returns float
as
begin

	declare @ret float
	
	set @ret = (@m1 + @m2 + @m3) 

return @ret

end



GO
