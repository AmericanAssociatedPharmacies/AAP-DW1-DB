USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPMID_Equipp]    Script Date: 12/22/2020 7:35:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPMID_Equipp] 
(
@PMID varchar(20)
)
RETURNS int
AS
BEGIN
declare @iRet int
set @iRet = NULL


IF @iRet is null
BEGIN
	IF @PMID is not null and LEN(@PMID)>0
	BEGIN
		select @iRet=username from v_EquippOwnership 
		where username=@PMID
	END
END

return @iRet
end
GO
