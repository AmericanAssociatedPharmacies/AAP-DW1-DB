USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_ServicesSurvey_bkp06282018]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_ServicesSurvey_bkp06282018](
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
	[DeliveryServicesChargeFee] [smallint] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PM_ServicesSurvey] PRIMARY KEY CLUSTERED 
(
	[PK_ServicesSurvey] ASC,
	[PMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_ServicesSurvey_bkp06282018] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_ServicesSurvey_bkp06282018] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_ServicesSurvey_bkp06282018] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
