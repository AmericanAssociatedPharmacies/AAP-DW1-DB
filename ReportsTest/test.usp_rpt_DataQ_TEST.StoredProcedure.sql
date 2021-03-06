USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_DataQ_TEST]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_rpt_DataQ_TEST]
	--------------
	--Parameters--
	--------------
@NCPDPProviderID VARCHAR(7)
	--------------

AS
     SET NOCOUNT ON;
     BEGIN
	---------------
	--TEMP TABLES--
	---------------
         DECLARE @TempSample TABLE(NCPDPProviderID INT);

	   ----------------------------
	   --DataQ Provider information
	   ----------------------------

         INSERT INTO @TempSample
                SELECT DISTINCT
                       a.NCPDPProviderID
                FROM NCPDPODS.dbo.vw_ProviderInformation AS a;
                --WHERE a.DispenserClassCode = '01';
         SELECT a.NCPDPProviderID
              , a.LegalBusinessName
              , a.Name
			  , a.ContactFirstName
			  , a.ContactLastName
			  , a.ContactTitle
			  , a.ContactPhoneNumber
			  , a.ContactEmailAddress
              , a.PhysicalLocationAddress1
              , a.PhysicalLocationAddress2
              , a.PhysicalLocationCity
              , a.PhysicalLocationStateCode
              , a.PhysicalLocationZipCode
              , a.PhysicalLocationCountyParish
              , a.PhysicalLocationStoreOpenDate
			  , a.PhysicalLocationPhoneNumber
			  , a.PhysicalLocationFAX
			  , a.PhysicalLocationEmailAddress
              , CASE
                    WHEN a.PhysicalLocationStoreClosureDate > GETDATE()
                    THEN NULL
                    ELSE a.PhysicalLocationStoreClosureDate
                END AS PhysicalLocationStoreClosureDate
              , a.DEARegistrationID
              , a.DEAExpirationDate
              , a.FedralTaxIDNumber
              , a.StateIncomeTaxIDNumber
              , c.StateLicesnseNumber
			  , c.StateLicenseExpirationDate
              , c.LicenseStateCode
              , a.NPI
         FROM NCPDPODS.dbo.vw_ProviderInformation AS a
              INNER JOIN @TempSample AS b ON a.NCPDPProviderID = b.NCPDPProviderID
                                             AND a.NCPDPProviderID = @NCPDPProviderID
              INNER JOIN NCPDPODS.dbo.vw_StateLicense AS c ON a.NCPDPProviderID = c.NCPDPProviderID;
     END;



GO
