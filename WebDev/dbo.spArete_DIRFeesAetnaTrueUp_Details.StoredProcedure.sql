USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spArete_DIRFeesAetnaTrueUp_Details]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Vrindha Nair
-- Create date: 07/27/2016
-- Description:	Aetna 2015 True Up
-- =============================================
CREATE PROCEDURE [dbo].[spArete_DIRFeesAetnaTrueUp_Details] 
(
 @ncpdp NVARCHAR(7)
)
	
AS
BEGIN
	
	
	
		
				SELECT * FROM  WebDev.dbo.DIRFees_AetnaTrueUp WHERE PharmacyNABP = @ncpdp

    

			
END
GO
