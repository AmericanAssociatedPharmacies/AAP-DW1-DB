USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyControlEntity_webtest]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyControlEntity_webtest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PMId] [int] NOT NULL,
	[Type] [nvarchar](150) NULL,
	[LocationType] [nvarchar](50) NULL,
	[npi] [nvarchar](11) NULL,
	[Title] [nvarchar](150) NULL,
	[EffectiveDate] [datetime] NULL,
	[PercentOwnership] [decimal](5, 2) NULL,
	[PharmacistLicense] [nvarchar](50) NULL,
	[StateIssueLicense] [nvarchar](50) NULL,
	[LicenseExpirationDate] [datetime] NULL,
	[Entity] [nvarchar](250) NULL,
	[DBA] [nvarchar](250) NULL,
	[FName] [nvarchar](150) NULL,
	[MName] [nvarchar](150) NULL,
	[LName] [nvarchar](150) NULL,
	[SSN] [nvarchar](12) NULL,
	[FEIN] [nvarchar](12) NULL,
	[DOB] [datetime] NULL,
	[Address] [nvarchar](250) NULL,
	[Address2] [nvarchar](250) NULL,
	[City] [nvarchar](250) NULL,
	[State] [nvarchar](15) NULL,
	[Zip] [nvarchar](15) NULL,
	[IsActive] [bit] NULL,
	[CriminalOffense] [bit] NULL,
	[HasOwnershipWithOtherStore] [bit] NULL,
	[HasRelationshipWithOtherOwner] [bit] NULL,
	[IsPIC] [bit] NULL,
	[IsControlEntity] [bit] NULL,
	[IsTechnician] [bit] NULL,
	[IsCertifiedTechnician] [bit] NULL,
	[IsPharmacist] [bit] NULL,
	[IsStoreManager] [bit] NULL,
	[PharState] [nvarchar](50) NULL,
	[PharExpDate] [datetime] NULL,
	[StateLicNo] [nvarchar](50) NULL,
	[IsSubmitted] [bit] NULL,
	[IsOwner] [bit] NULL
) ON [PRIMARY]
GO
