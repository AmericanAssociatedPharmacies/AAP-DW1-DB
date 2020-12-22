USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[MF2ERR_K]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2ERR_K](
	[Key_Identifier] [nvarchar](1) NULL,
	[Unique_Key] [nvarchar](19) NULL,
	[Data_Element_Code] [nvarchar](4) NULL,
	[Data_Element_Length] [int] NULL,
	[Reserve] [nvarchar](5) NULL
) ON [PRIMARY]
GO
