USE [ODSIntake]
GO
/****** Object:  Table [Staging].[APICatalog]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[APICatalog](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[NDC] [varchar](500) NULL,
	[UPC] [varchar](500) NULL,
	[VIN] [varchar](500) NULL,
	[Desc] [varchar](500) NULL,
	[PkgSize] [varchar](500) NULL,
	[DispUnt] [varchar](500) NULL,
	[AcqCost] [varchar](500) NULL,
	[ListPrice] [varchar](500) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_APICatalog] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[APICatalog] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
