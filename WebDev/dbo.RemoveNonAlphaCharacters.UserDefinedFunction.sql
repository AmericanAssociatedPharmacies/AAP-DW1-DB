USE [WebDev]
GO
/****** Object:  UserDefinedFunction [dbo].[RemoveNonAlphaCharacters]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[RemoveNonAlphaCharacters](@Temp nvarchar(MAX))
Returns nvarchar(MAX)
AS
Begin

    Declare @KeepValues varchar(50);
	SET @KeepValues = '%[^a-z][A-Z]%';
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')

    Return @Temp
End
GO
