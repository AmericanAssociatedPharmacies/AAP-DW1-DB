USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spud_PMFixEmptyAAPAccountNO]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spud_PMFixEmptyAAPAccountNO]

	

	
AS
BEGIN

	Begin Tran fixAAPAccountNo
	update pm_pharmacy set aapaccountno = null where aapaccountno = ''


	COMMIT Tran
END
GO
