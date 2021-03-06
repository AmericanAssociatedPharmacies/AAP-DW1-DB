USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_OrganizationTypes]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_OrganizationTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PM_OrganizationTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_OrganizationTypes] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_OrganizationTypes] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_OrganizationTypes] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
