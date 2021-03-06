USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_PM_VendorAccts_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_PM_VendorAccts_Load]

AS

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

BEGIN


	INSERT INTO [dbo].[PM_VendorAccts](PMID, VendorID, isPrimary, VendAcctNum, PVA, PaymentTerms, Source, PVAEffectiveDate, [RowVersion], Created, Modified)
	SELECT dt.PMID
	, dt.VendorID
	, dt.IsPrimary
	, dt.VendAcctNum
	, dt.PVA
	, dt.PaymentTerms
	, dt.Source
	, dt.PVAEffectiveDate
	, dt.[RowVersion]
	, dt.Created
	, dt.Modified
	FROM(SELECT PMID
	, VendorID
	, IsPrimary
	, CONVERT(VARCHAR(32), LEFT(VendAcctNum,32)) AS VendAcctNum
	, CONVERT(VARCHAR(30), LEFT(PVA,30)) AS PVA
	, CONVERT(VARCHAR(50), LEFT(PaymentTerms,50)) AS PaymentTerms
	, CONVERT(VARCHAR(3), LEFT(Source, 3)) AS Source
	, PVAEffectiveDate
	, CONVERT(INT, 1) AS [RowVersion]
	, GETDATE() AS Created
	, GETDATE() AS Modified
		FROM Staging.PM_VendorAccts
		) AS dt
	WHERE NOT EXISTS(SELECT 1
					FROM [dbo].[PM_VendorAccts] AS pva
					WHERE dt.PMID = pva.PMID
					AND dt.VendorID = pva.VendorID
					AND dt.Source = pva.Source  
					)


END


GO
