USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[fDate2]    Script Date: 12/22/2020 7:35:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fDate2]
(
	@dt datetime
)
RETURNS varchar(3)
AS
BEGIN
	return left(datename(mm,@dt),3)
END
GO
