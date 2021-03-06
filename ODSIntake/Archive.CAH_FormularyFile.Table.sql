USE [ODSIntake]
GO
/****** Object:  Table [Archive].[CAH_FormularyFile]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[CAH_FormularyFile](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NULL,
	[DateKey] [int] NULL,
	[CAHFileType] [varchar](500) NULL,
	[CIN] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[Supplier Name] [varchar](500) NULL,
	[CardKey] [varchar](500) NULL,
	[GCN] [varchar](500) NULL,
	[GCN_SEQ] [varchar](500) NULL,
	[GPI Code] [varchar](500) NULL,
	[UD_ID] [varchar](500) NULL,
	[Strength] [varchar](500) NULL,
	[Accunet Size] [varchar](500) NULL,
	[UOM] [varchar](500) NULL,
	[Form] [varchar](500) NULL,
	[Form Description] [varchar](500) NULL,
	[Color] [varchar](500) NULL,
	[Shape] [varchar](500) NULL,
	[Brand/Generic (CGIC)] [varchar](500) NULL,
	[TEE Rating] [varchar](500) NULL,
	[DEA Schedule Number] [varchar](500) NULL,
	[NIFO] [varchar](500) NULL,
	[Sell Price] [varchar](500) NULL,
	[Sell Price per Unit] [varchar](500) NULL,
	[Generic Name] [varchar](500) NULL,
	[Brand Name] [varchar](500) NULL,
	[Status] [varchar](500) NULL,
	[Formulary Name] [varchar](500) NULL,
	[END_DTE] [datetime] NULL,
	[CorrectedNDC] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Archive_CAH_FormularyFile] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[CAH_FormularyFile] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
