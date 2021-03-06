USE [NCPDPODS]
GO
/****** Object:  Table [Staging].[ServicesOffered]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ServicesOffered](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NCPDPProviderID] [varchar](7) NULL,
	[AcceptsePrescriptionsIndicator] [varchar](1) NULL,
	[AcceptsePrescriptionsCode] [varchar](2) NULL,
	[DeliveryServiceIndicator] [varchar](1) NULL,
	[DeliveryServiceCode] [varchar](2) NULL,
	[CompoundingServiceIndicator] [varchar](1) NULL,
	[CompoundingServiceCode] [varchar](2) NULL,
	[DriveUpWindowIndicator] [varchar](1) NULL,
	[DriveUpWindowCode] [varchar](2) NULL,
	[DurableMedicalEquipmentIndicator] [varchar](1) NULL,
	[DurableMedicalEquipmentCode] [varchar](2) NULL,
	[WalkInClinicIndicator] [varchar](1) NULL,
	[WalkInClinicCode] [varchar](2) NULL,
	[24HourEmergencyServiceIndicator] [varchar](1) NULL,
	[24HourEmergencyServiceCode] [varchar](2) NULL,
	[MultiDoseCompliancePackagingIndicator] [varchar](1) NULL,
	[MultiDoseCompliancePackagingCode] [varchar](2) NULL,
	[ImmunizationsProvidedIndicator] [varchar](1) NULL,
	[ImmunizationsProvidedCode] [varchar](2) NULL,
	[HandicappedAccessibleIndicator] [varchar](1) NULL,
	[HandicappedAccessibleCode] [varchar](2) NULL,
	[340BStatusIndicator] [varchar](1) NULL,
	[340BStatusCode] [varchar](2) NULL,
	[ClosedDoorFacilityIndicator] [varchar](1) NULL,
	[ClosedDoorFacilityStatusCode] [varchar](2) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_ServicesOffered] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[ServicesOffered] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
