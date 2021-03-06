USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2NAME_F]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2NAME_F](
	[Drug_Descriptor_Identifier] [int] NOT NULL,
	[Drug_Name] [nvarchar](30) NULL,
	[Route_of_Administration] [nvarchar](2) NULL,
	[Dosage_Form] [nvarchar](4) NULL,
	[Strength] [nvarchar](15) NULL,
	[Strength_Unit_of_Measure] [nvarchar](10) NULL,
	[Bioequivalence_Code] [nvarchar](1) NULL,
	[Controlled_Substance_Code] [nvarchar](1) NULL,
	[Efficacy_Code] [nvarchar](1) NULL,
	[Legend_Indicator_Code] [nvarchar](1) NULL,
	[Multi_Source_Summary_Code] [nvarchar](1) NULL,
	[Brand_Name_Code] [nvarchar](1) NULL,
	[Name_Source_Code] [nvarchar](1) NULL,
	[Generic_Product_Identifier] [nvarchar](14) NULL,
	[Knowledge_Base_Drug_Code] [bigint] NULL,
	[New_Drug_Descriptor_Identifier] [int] NULL,
	[Screenable_Flag] [nvarchar](1) NULL,
	[KDC_Flag] [nvarchar](1) NULL,
	[LocalSystemic_Code] [nvarchar](1) NULL,
	[Maintenance_Drug_Code] [nvarchar](1) NULL,
	[Form_Type_Code] [nvarchar](1) NULL,
	[Internal_External_Code] [nvarchar](1) NULL,
	[Single_Combination_Code] [nvarchar](1) NULL,
	[Representative_GPI_Flag] [nvarchar](1) NULL,
	[Representative_KDC_Flag] [nvarchar](1) NULL,
	[Reserve] [nvarchar](6) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Drug_Descriptor_Identifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
