USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_DEA]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_DEA] 

	@DEA VARCHAR(50)

AS
     SET NOCOUNT ON;
    BEGIN

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
             , a.NPI
        FROM NCPDPODS.dbo.vw_ProviderInformation AS a
		WHERE a.DEARegistrationID = @DEA
      
    END;



GO
