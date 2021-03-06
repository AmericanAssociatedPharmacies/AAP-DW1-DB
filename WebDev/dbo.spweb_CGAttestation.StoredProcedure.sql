USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_CGAttestation]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*  
  =============================================
  Author:		CHRIS STONE
  Create date: 07/15/2013
  Description:	Inserts into Database Table data from a web form
  Should always come from rxaap.com/compliance.attestation.php
  =============================================
*/
CREATE PROCEDURE [dbo].[spweb_CGAttestation]
	(	
  @PharmacyNotExcluded bit,
  @PersonnelNotExcluded bit,
  @RecordRetention10yr bit,
  @FWATraining bit,
  @LogPersonnelFWATraining bit,
  @PharmacyMaintainsLicensesInsurance bit,
  @PersonnelMaintainsLicensesCertifications bit,
  @StandardsOfConductInWriting bit,
  @DesignatedComplianceOfficer bit,
  @ProceduresToDetectFWA bit,
  @Attestor nvarchar(255),
  @ComplianceOfficer nvarchar(255),
	@email nvarchar(255),	
@accountname nvarchar(255),
@ncpdp nvarchar(20),
  @npi nvarchar(20), @pmid int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [WebDev].[dbo].[CGAttestations] 
(PharmacyName,NCPDP,NPI,PharmacyNotExcluded,PersonnelNotExcluded,RecordRetention10yr,
FWATraining,LogPersonnelFWATraining,PharmacyMaintainsLicensesInsurance,PersonnelMaintainsLicensesCertifications,StandardsOfConductInWriting,
DesignatedComplianceOfficer,ProceduresToDetectFWA,
Attestor,ComplianceOfficer,pmid,email,[Date])

	VALUES (@accountname,@ncpdp, @npi, @PharmacyNotExcluded ,
  @PersonnelNotExcluded ,
  @RecordRetention10yr ,
  @FWATraining ,
  @LogPersonnelFWATraining ,
  @PharmacyMaintainsLicensesInsurance ,
  @PersonnelMaintainsLicensesCertifications ,
  @StandardsOfConductInWriting ,
  @DesignatedComplianceOfficer ,
  @ProceduresToDetectFWA ,
  @Attestor ,
  @ComplianceOfficer ,
  @pmid,@email,getdate()   ) 



END





GO
