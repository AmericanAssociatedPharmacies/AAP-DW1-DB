USE [CAHODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetFormulary_Azure]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetFormulary_Azure]

	@RowID INT

AS

SET NOCOUNT ON;



BEGIN

	SELECT FileRowID, DateKey, CAHFileType, CIN, Description, Size, AAPSell, Supplier, BrandName, Form, NDCUPC, DPNum, UOM, PricePerUnit, GPIID, GCN, GCNSEQ, Color, FileProcessed, CorrectedNDCUPC, IsBackupSource, IsTenSource, IsSourceWeekly, IsTopGenerics
	FROM [dbo].[CAH_FormularyFile]
	WHERE RowID > @RowID



END
GO
