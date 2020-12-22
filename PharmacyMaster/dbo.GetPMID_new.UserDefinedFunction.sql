USE [PharmacyMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPMID_new]    Script Date: 12/22/2020 7:35:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPMID_new] 
(
@AAPAccountNo varchar(20)
)
RETURNS int
AS
BEGIN
declare @iRet int
set @iRet = NULL


IF @iRet is null
BEGIN
	IF @AAPAccountNo is not null and LEN(@AAPAccountNo)>0
	BEGIN
		select @iRet = PMID from PM_Pharmacy where AAPAccountNo=@AAPAccountNo 
	END
END

return @iRet
end
GO
