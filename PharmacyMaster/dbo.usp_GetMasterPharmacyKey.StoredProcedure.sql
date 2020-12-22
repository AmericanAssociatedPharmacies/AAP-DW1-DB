USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetMasterPharmacyKey]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetMasterPharmacyKey]


AS

SET NOCOUNT ON;


BEGIN


	 SELECT dt.PharmacyKey
	 FROM(SELECT CONVERT(VARBINARY(8), GETDATE()) AS PharmacyKey
	 ) AS dt


END
GO
