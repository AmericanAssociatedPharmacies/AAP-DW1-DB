USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_SoftwareVersion]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_SoftwareVersion](
	[PM_SoftwareVersion_ID] [int] IDENTITY(1,1) NOT NULL,
	[softwareversion] [varchar](15) NOT NULL,
	[mandatoryupdate] [smallint] NOT NULL,
	[releasedate] [smalldatetime] NOT NULL,
	[releasenotes] [text] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PM_SoftwareVersion] PRIMARY KEY CLUSTERED 
(
	[PM_SoftwareVersion_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_SoftwareVersion] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_SoftwareVersion] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_SoftwareVersion] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
