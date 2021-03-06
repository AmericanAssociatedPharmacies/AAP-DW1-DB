USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_VendorAccts_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_VendorAccts_Load]


AS

SET NOCOUNT ON;


INSERT INTO dbo.PM_VendorAccts(PMID, VendorID, IsPrimary, [VendAcctNum], PVA, PaymentTerms, Source, PVAEffectiveDate, [RowVersion], Created, Modified)
SELECT PMID, VendorID, IsPrimary, [VendAcctNum], PVA, PaymentTerms, Source, PVAEffectiveDate, [RowVersion], GETDATE(), GETDATE()
FROM Staging.vw_VendorAccts AS A
WHERE PMID IS NOT NULL
AND NOT EXISTS(SELECT 1
				FROM dbo.PM_VendorAccts AS B
				WHERE A.PMID = B.PMID
				--AND A.VendorID = B.VendorID
				--AND A.VendAcctNum = B.VendAcctNum
				--AND A.Source = B.Source
				)
ORDER BY PMID ASC


GO
