USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2NDCM_O]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2NDCM_O](
	[NDC_UPC_HRI] [varchar](11) NOT NULL,
	[Modifier_Code] [varchar](6) NOT NULL,
	[Reserve] [nvarchar](6) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[NDC_UPC_HRI] ASC,
	[Modifier_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
