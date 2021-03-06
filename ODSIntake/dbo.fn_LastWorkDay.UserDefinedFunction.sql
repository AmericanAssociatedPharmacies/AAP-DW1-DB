USE [ODSIntake]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_LastWorkDay]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_LastWorkDay](
	@Date DATETIME)
RETURNS datetime

As
--Note assumes that Sunday = 1 and Saturday = 7
Begin
DECLARE
	@DW INT,
	@EOM DATETIME

	--get the last day of the month
	SET @EOM = DATEADD(hh,-1,DATEADD(mm, DATEDIFF(m,0,@Date  )+1, 0))

	--get the day of the week
	SET @DW = DATEPART(dw,@EOM)

	--make sure it is not a weekend day
	SELECT @EOM = CASE @DW WHEN 1 THEN DATEADD(d,-2,@EOM)
									WHEN 7 THEN DATEADD(d,-1,@EOM)
									ELSE @EOM END 

Return @EOM
End
GO
