USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_PharmacyInfo]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Compliance_PharmacyInfo] @PMID INT
AS
     SET NOCOUNT ON;
    BEGIN
        DECLARE @MaxKey INT=
        (
            SELECT MAX(t1.PharmacyKey)
            FROM ClaimsDDS.dbo.PharmacyDim AS t1
            WHERE t1.PMID = @PMID
        );
        SELECT t2.PMID
             , t2.APINumber AS APIAccountNo
             , t2.AAPNumber AS AAPAccountNo
             , t2.NCPDP AS NCPDP
             , t2.PharmacyName AS AccountName
        FROM ClaimsDDS.dbo.PharmacyDim AS t2
        WHERE t2.PMID = @PMID
              AND t2.PharmacyKey = @MaxKey;
    END;
GO
