USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAffiliate_Equipp]    Script Date: 12/22/2020 7:35:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetAffiliate_Equipp] 
(
@Affiliate varchar(200),
@aapparentno int,
@vendorid int
)
RETURNS varchar(200)
AS
BEGIN
declare @iRet varchar(200)
set @iRet = NULL


IF @iRet is null
BEGIN
	
	if (@aapparentno = 11377)
		BEGIN
			set @iRet = 'BASHAS'
		END
	else if (@vendorid = 44)
		BEGIN
			set @iRet = 'Miami Luken'
		END
	else
		BEGIN
			select @iRet=Affiliation from Equipp_Affiliates where Affiliation=@Affiliate
		END
	
END

return @iRet
end
GO
