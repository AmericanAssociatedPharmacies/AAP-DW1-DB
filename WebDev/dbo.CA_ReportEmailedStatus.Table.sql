USE [WebDev]
GO
/****** Object:  Table [dbo].[CA_ReportEmailedStatus]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CA_ReportEmailedStatus](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PMID] [bigint] NULL,
	[NCPDP] [nvarchar](7) NULL,
	[AccountName] [nvarchar](max) NULL,
	[ReportType] [int] NULL,
	[IsReportGenerated] [int] NULL,
	[Email] [nvarchar](max) NULL,
	[IsEmailed] [int] NULL,
	[IsSuccess] [int] NULL,
	[IsValidEmail] [int] NULL,
	[DateCreated] [datetime] NULL,
	[FileName] [nvarchar](max) NULL,
	[Errors] [nvarchar](max) NULL,
 CONSTRAINT [PK_CA_ReportEmailedStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
