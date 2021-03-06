USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDS_DeleteDupsKeepMaxTransactionDateDedup]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_FDS_DeleteDupsKeepMaxTransactionDateDedup]

AS

SET NOCOUNT ON

BEGIN

	RETURN

	----Will DELETE exact dup but keeps MAX TransactionDate
	--DECLARE @PMID INT

	--DECLARE C1 CURSOR FOR
	--SELECT DISTINCT PMID
	--FROM [dbo].[FDSComplianceReport]

	--OPEN C1

	--FETCH NEXT
	--FROM C1
	--INTO @PMID

	--WHILE @@FETCH_STATUS = 0
	--BEGIN

	--	DELETE x
	--	FROM [dbo].[FDSComplianceReport] AS x
	--	INNER JOIN(SELECT dt.RowID
	--				FROM(SELECT ROW_NUMBER() OVER(PARTITION BY PMID, GPI, AWPPerDose, [QuantityDispensed], IsGeneric, [PrescriptionNumber], [RefillNumber], NDC,  [Is340BClaim] ORDER BY TransactionDate DESC) AS RN
	--					, *
	--					FROM [dbo].[FDSComplianceReport]
	--					WHERE PMID = @PMID
	--					) AS dt
	--				WHERE dt.RN > 1
	--			) AS dt ON x.RowID = dt.RowID

	--	FETCH NEXT
	--	FROM C1
	--	INTO @PMID


	--END

	--CLOSE C1
	--DEALLOCATE C1


	
	----Will DELETE dup (removes QuantityDispensed column) but keeps MAX TransactionDate
	--DECLARE C2 CURSOR FOR
	--SELECT DISTINCT PMID
	--FROM [dbo].[FDSComplianceReport]

	--OPEN C2

	--FETCH NEXT
	--FROM C2
	--INTO @PMID

	--WHILE @@FETCH_STATUS = 0
	--BEGIN

	--	DELETE x
	--	FROM [dbo].[FDSComplianceReport] AS x
	--	INNER JOIN(SELECT dt.RowID
	--				FROM(SELECT ROW_NUMBER() OVER(PARTITION BY PMID, GPI, AWPPerDose, IsGeneric, PrescriptionNumber, RefillNumber, NDC, Is340BClaim, CONVERT(Date,TransactionDate) ORDER BY TransactionDate DESC) AS RN
	--						, *
	--					 FROM [dbo].[FDSComplianceReport]
	--					 WHERE PMID = @PMID
	--					) AS dt
	--				WHERE dt.RN > 1
	--			) AS dt ON x.RowID = dt.RowID

	--	FETCH NEXT
	--	FROM C2
	--	INTO @PMID


	--END

	--CLOSE C2
	--DEALLOCATE C2



END
GO
