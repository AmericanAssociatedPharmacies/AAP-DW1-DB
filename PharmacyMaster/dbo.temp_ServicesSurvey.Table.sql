USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[temp_ServicesSurvey]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_ServicesSurvey](
	[PK_ServicesSurvey] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[DiabetesEducatorCertified] [smallint] NULL,
	[DiabetesEducatorNonCertified] [smallint] NULL,
	[HypertensionTesting] [smallint] NULL,
	[AsthmaServices] [smallint] NULL,
	[CholesterolServices] [smallint] NOT NULL,
	[CompoundingLevel1thru3] [smallint] NULL,
	[CompoundingLevel4Sterile] [smallint] NULL,
	[DMELight] [smallint] NULL,
	[DMEHeavy] [smallint] NULL,
	[DMEAccreditedPharmacy] [smallint] NULL,
	[Contracted340BSelfAdministered] [smallint] NULL,
	[Contracted340BThirdPartyAdministered] [smallint] NULL,
	[Contracted340BExplain] [varchar](500) NULL,
	[ImmunizationsFLUVaccines] [smallint] NULL,
	[ImmunizationsTravelVaccines] [smallint] NULL,
	[ImmunizationsOtherExplain] [varchar](500) NULL,
	[WeightLossClinics] [smallint] NULL,
	[NutritionServices] [smallint] NULL,
	[OtherRetirementCommunities] [smallint] NULL,
	[OtherAssistedLivingFacilities] [smallint] NULL,
	[OtherHospiceCenters] [smallint] NULL,
	[OtherSkilledNursingFacilities] [smallint] NULL,
	[DeliveryServicesNoCharge] [smallint] NULL,
	[DeliveryServicesChargeFee] [smallint] NULL
) ON [PRIMARY]
GO
