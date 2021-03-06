USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [Staging].[usp_PM_AddressMaster_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Staging].[usp_PM_AddressMaster_Load]

AS

/*******************************************************************************

-- Author: Scott Edwards
-- Description: Used to get data for PharmacyMaster ETL.
-- InParameter: N\A
-- OutParameter: N\A
-- Created Date: 04/23/2018
-- Revision History :
-- Modified Date Modified By version Description
-- Test code: Execute sproc as is.

********************************************************************************/

SET NOCOUNT ON;

BEGIN


SELECT PMID, Address_Type_Id, [Address], Address2, City, County, [State], Zip, ContactFullName, Fax, Phone, AlternatePhone, Email, Modified, [RowVersion]
FROM Staging.vw_PM_AddressMaster


END
GO
