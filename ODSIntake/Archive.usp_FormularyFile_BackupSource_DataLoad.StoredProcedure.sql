USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Archive].[usp_FormularyFile_BackupSource_DataLoad]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Archive].[usp_FormularyFile_BackupSource_DataLoad]

AS

SET NOCOUNT ON;

BEGIN


	MERGE [Archive].[CAH_FormularyFiles_BackupSource] AS t
	USING(SELECT ROW_NUMBER() OVER(PARTITION BY DateKey, CIN ORDER BY RowID ASC) AS RN
			, [DateKey]
			, [CIN]
			, [Description]
			, [Size]
			, [AAP Sell]
			, [Supplier]
			, [Brand Name]
			, [Form]
			, [NDC/UPC]
			, [DP#]
			, [UOM]
			, [Price Per Unit]
			, [GPI_ID]
			, [GCN]
			, [GCN SEQ]
			, [Color]
			, [FileProcessed]
			, [RowCreatedDate]
			, [CorrectedNDCUPC]			
			FROM [Staging].[CAH_FormularyFiles_BackupSource]
				) AS s (RN
						, [DateKey]
						, [CIN]
						, [Description]
						, [Size]
						, [AAP Sell]
						, [Supplier]
						, [Brand Name]
						, [Form]
						, [NDC/UPC]
						, [DP#]
						, [UOM]
						, [Price Per Unit]
						, [GPI_ID]
						, [GCN]
						, [GCN SEQ]
						, [Color]
						, [FileProcessed]
						, [RowCreatedDate]
						, [CorrectedNDCUPC]
						) ON t.CIN = s.CIN AND t.DateKey = s.DateKey
							AND s.RN = 1
		WHEN MATCHED THEN
		UPDATE SET [CIN] = s.CIN
			, [Description] = s.[Description]
			, [Size] = s.Size
			, [AAP Sell] = s.[AAP Sell]
			, [Supplier] = s.[Supplier]
			, [Brand Name] = s.[Brand Name]
			, [Form] = s.[Form]
			, [NDC/UPC] = s.[NDC/UPC]
			, [DP#] = s.[DP#]
			, [UOM] = s.[UOM]
			, [Price Per Unit] = s.[Price Per Unit]
			, [GPI_ID] = s.[GPI_ID]
			, [GCN] = s.[GCN]
			, [GCN SEQ] = s.[GCN SEQ]
			, [Color] = s.[Color]
			, [FileProcessed] = s.[FileProcessed]
			, [CorrectedNDCUPC] = s.[CorrectedNDCUPC]
		WHEN NOT MATCHED THEN
		INSERT([DateKey]
				, [CIN]
				, [Description]
				, [Size]
				, [AAP Sell]
				, [Supplier]
				, [Brand Name]
				, [Form]
				, [NDC/UPC]
				, [DP#]
				, [UOM]
				, [Price Per Unit]
				, [GPI_ID]
				, [GCN]
				, [GCN SEQ]
				, [Color]
				, [FileProcessed]
				, [CorrectedNDCUPC]
				)
		VALUES(s.[DateKey]
				, s.[CIN]
				, s.[Description]
				, s.[Size]
				, s.[AAP Sell]
				, s.[Supplier]
				, s.[Brand Name]
				, s.[Form]
				, s.[NDC/UPC]
				, s.[DP#]
				, s.[UOM]
				, s.[Price Per Unit]
				, s.[GPI_ID]
				, s.[GCN]
				, s.[GCN SEQ]
				, s.[Color]
				, s.[FileProcessed]
				, s.[CorrectedNDCUPC]
				);

END
GO
