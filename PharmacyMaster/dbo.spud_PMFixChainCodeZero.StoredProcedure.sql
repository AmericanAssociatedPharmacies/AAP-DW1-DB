USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PMFixChainCodeZero]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spud_PMFixChainCodeZero]

	

	
AS
BEGIN

	Begin Tran fixCodeZero
	update pharmacymaster..pm_managedcare set chaincode = null where chaincode = 0


	COMMIT Tran
END


GO
