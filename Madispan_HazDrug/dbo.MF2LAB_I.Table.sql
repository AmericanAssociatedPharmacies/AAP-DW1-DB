USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[MF2LAB_I]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2LAB_I](
	[Medi_Span_Labeler_Identifier] [int] NULL,
	[Manufacturers_Labeler_Name] [nvarchar](30) NULL,
	[Manufacturers_Abbreviated_Name] [nvarchar](10) NULL,
	[Labeler_Type_Code] [nvarchar](1) NULL,
	[Reserve] [nvarchar](9) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL
) ON [PRIMARY]
GO
