USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_CommType]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_CommType](
	[CommID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](255) NULL,
	[ProgramID] [int] NULL,
	[EditOnWeb] [bit] NULL,
 CONSTRAINT [PK_PM_Comm] PRIMARY KEY CLUSTERED 
(
	[CommID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
