USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[Report_Def]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report_Def](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportDescription] [varchar](255) NULL,
	[ReportName] [varchar](255) NULL,
	[Requestor] [varchar](255) NULL,
	[Developer] [varchar](255) NULL,
	[StoredProcName] [varchar](255) NULL,
	[Frequency] [varchar](255) NULL,
	[Documents] [varchar](255) NULL,
	[HassleFactor] [varchar](255) NULL,
	[Notes] [varchar](1024) NULL,
 CONSTRAINT [PK_Report_Def] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
