USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_prepare_CH_ALLPVA_SALES_SSIS]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 8/30/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_prepare_CH_ALLPVA_SALES_SSIS] 
 
AS

BEGIN
    IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'CH_ALLPVA_SALES_BKP')
          DROP TABLE CH_ALLPVA_SALES_BKP
 

	SELECT * into CH_ALLPVA_SALES_BKP from CH_ALLPVA_SALES

END

GO
