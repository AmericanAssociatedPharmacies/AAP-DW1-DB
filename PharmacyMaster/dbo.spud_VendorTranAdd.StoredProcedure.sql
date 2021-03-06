USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_VendorTranAdd]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spud_VendorTranAdd]
	(
		@vendorid int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO VendorTransaction (VendorID) VALUES(@vendorid)

	DECLARE @tran int

	Select @tran = max(TransactionID) FROM VendorTransaction

	Select @tran as tranid

END
GO
