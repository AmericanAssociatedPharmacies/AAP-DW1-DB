USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDSCompliance_ItemCodeUpdate]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_FDSCompliance_ItemCodeUpdate]

AS

SET NOCOUNT ON

BEGIN

		UPDATE x
			SET ItemCode = 'A'	
			FROM dbo.FDSComplianceReport AS x
			INNER JOIN(SELECT DISTINCT GPI
							FROM SalesDDS.dbo.APIComplianceReport
							) AS a ON a.GPI = x.GPI	


			UPDATE x
			SET ItemCode = 'C'	
			FROM dbo.FDSComplianceReport AS x
			INNER JOIN(SELECT DISTINCT GPI
							FROM SalesDDS.dbo.CAHComplianceReport
							) AS a ON a.GPI = x.GPI	
			WHERE x.ItemCode <> 'A'

END
GO
