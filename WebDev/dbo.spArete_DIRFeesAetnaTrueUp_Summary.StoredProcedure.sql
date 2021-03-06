USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spArete_DIRFeesAetnaTrueUp_Summary]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Vrindha Nair
-- Create date: 07/15/2016
-- Description:	DIR Fees Summary
-- =============================================
CREATE PROCEDURE [dbo].[spArete_DIRFeesAetnaTrueUp_Summary] 
(
	 @ncpdp NVARCHAR(7)
)
	
	
AS
BEGIN
	
	SET NOCOUNT ON;


	 	 

		    SELECT 'Aetna' AS [Plan PBM],  [# of Claims],'1.38' AS [Per Claim], [Total],[Payment 1], [Payment 2],[Payment 3], cast(([Total] - ([Payment 1] + [Payment 2] + [Payment 3])) as varchar) AS [Payment 4]
			FROM
			(
				SELECT  COUNT(PharmacyNABP) AS  [# of Claims], (COUNT(PharmacyNABP)*1.38) AS [Total],
				CASE WHEN ((COUNT(PharmacyNABP)*1.38) > 500.00 ) THEN  CONVERT(DECIMAL(10,2),((COUNT(PharmacyNABP)* 1.38)/4))
					ELSE (COUNT(PharmacyNABP)* 1.38) END AS [Payment 1], 
				CASE WHEN ((COUNT(PharmacyNABP)*1.38) > 500.00 ) THEN  cast(CONVERT(DECIMAL(10,2),((COUNT(PharmacyNABP)* 1.38)/4)) as varchar)  ELSE '0.00' END AS [Payment 2] ,
				CASE WHEN ((COUNT(PharmacyNABP)*1.38) > 500.00 ) THEN  cast(CONVERT(DECIMAL(10,2),((COUNT(PharmacyNABP)* 1.38)/4)) as varchar) ELSE '0.00' END AS [Payment 3] 
				FROM  WebDev.dbo.DIRFees_AetnaTrueUp WHERE PharmacyNABP = @ncpdp 
			)a
	
	 
			
END

--[spArete_DIRFeesAetnaTrueUp_Summary] '4533267'
GO
