USE [PharmacyMaster]
GO
/****** Object:  Table [Archive].[PM_Territory]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[PM_Territory](
	[Territory] [varchar](2) NOT NULL,
	[LastName] [varchar](35) NULL,
	[FirstName] [varchar](35) NULL,
	[GeogArea] [varchar](50) NULL,
	[Telephone] [varchar](25) NULL,
	[Cell] [varchar](25) NULL,
	[Fax] [varchar](25) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[PM_Territory] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [Archive].[PM_Territory] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [Archive].[PM_Territory] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
