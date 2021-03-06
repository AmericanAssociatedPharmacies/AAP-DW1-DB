USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PPTranUpd]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spud_PPTranUpd]
	(
		@UDNo varchar(50),
		@Volume numeric(18,2),
		@Rebate numeric(18,2),
		@PMID int,
		@ID int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE VendorVolumeRebate 
	SET UDNo = @UDNo,	
	PMID = @PMID, 
	VolumeAmt = @Volume, 
	RebateAmt = @Rebate 
WHERE ID=@ID

END
GO
