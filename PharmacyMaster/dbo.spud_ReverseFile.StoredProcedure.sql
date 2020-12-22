USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_ReverseFile]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spud_ReverseFile]
	(
		@fileID int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
     DELETE FROM VendorVolumeRebate WHERE FileID=@fileID

	 DECLARE @tranID int
	 Select @tranID=TransactionID from vendorLoad Where FileID=@fileID

	 DELETE FROM VendorTransaction WHERE TransactionID=@tranid

	 DELETE FROM VendorLoad WHERE FileID=@fileID
	 
END
GO
